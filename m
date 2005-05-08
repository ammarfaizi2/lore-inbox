Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262854AbVEHLky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbVEHLky (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 07:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262852AbVEHLkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 07:40:53 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:45152 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S262851AbVEHLko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 07:40:44 -0400
Message-ID: <427DFAB8.5050000@tls.msk.ru>
Date: Sun, 08 May 2005 15:40:40 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jdow <jdow@earthlink.net>
Cc: James Purser <purserj@ksit.dynalias.com>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>, GIT <git@vger.kernel.org>
Subject: Re: [PATCH] Really *do* nothing in while loop
References: <20050508093440.GA9873@cip.informatik.uni-erlangen.de> <427DE086.40307@tls.msk.ru> <1115551204.3085.0.camel@kryten> <12e801c553c1$c454ea20$1225a8c0@kittycat>
In-Reply-To: <12e801c553c1$c454ea20$1225a8c0@kittycat>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jdow wrote:
> From: "James Purser" <purserj@ksit.dynalias.com>
> 
   while (deflate(&stream, 0) == Z_OK)
-  /* nothing */
+  /* nothing */;
  stream.next_in = buf;
> 
> You guys REALLY do not see the changed semantics here? You are
> changing:
>   while (deflate(&stream, 0) == Z_OK)
>       stream.next_in = buf;
> 
> into
> 
>   while (deflate(&stream, 0) == Z_OK)
>     ;
>   /* Then the data itself.. */
>   stream.next_in = buf;
> 
> I suspect the results of that tiny bit of code would be slightly
> different, especially if "stream.next_in" is volatile, "buf"
> is volatile, or if the assignment to next_in has an effect on
> the "deflate" operation.

As I already said, deflate() in this case does only ONE iteration.
stream.avail_in is NOT changed in the loop (except of the deflate()
itself, where it will be set to 0 - provided out buffer have enouth
room).  So the whole while loop does only ONE iteration, returning
Z_NEED_DATA or something the next one.  So no, the semantics here
(actual semantics) does NOT change.

/mjt
