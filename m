Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbVLHPbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbVLHPbR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 10:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVLHPbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 10:31:17 -0500
Received: from iona.labri.fr ([147.210.8.143]:4057 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S932172AbVLHPbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 10:31:16 -0500
Message-ID: <4398516F.1020101@labri.fr>
Date: Thu, 08 Dec 2005 16:29:51 +0100
From: Emmanuel Fleury <emmanuel.fleury@labri.fr>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to enable/disable security features on mmap() ?
References: <43983EBE.2080604@labri.fr>  <1134051272.2867.63.camel@laptopd505.fenrus.org>  <43984154.5050502@labri.fr>  <43984595.1090406@labri.fr> <1134053349.2867.65.camel@laptopd505.fenrus.org> <4398493E.50508@labri.fr> <Pine.LNX.4.61.0512081011020.32448@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0512081011020.32448@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> 
> In reference to the random-stack patch....
> 
> Executing the following program on linux-2.6.13.4:
> 
> #include <stdio.h>
> 
> int main()
> {
>      int foo;
>      printf("%p\n", &foo);
>      return 0;
> }
> 
> ... a few thousand times and sorting its output shows
> the stack varies from:
>  	0xbf7fe144 -> 0xbffff674
> 
> Isn't this too much?  I thought the random-stack patch was
> only supposed to vary it a page or 64k at most. This looks
> like some broken logic because it varies almost 8 megabytes!
> No wonder some of my user's database programs sometimes seg-fault
> and other times work perfectly fine. I think this is incorrect
> and shows a serious bug (misbehavior).

Well, there are some other strangeness (especially when running on a
x86_64 architecture). See:

http://dept-info.labri.fr/~fleury/LS05/download/papers/notes_on_ASLR.txt

The ASLR should take advantage of the 64 bits wide address pointers but
doesn't. It behaves as on a 32bits architecture. I didn't find why (must
be a good reason though but I'm just puzzled).

Moreover, the libc location (and all other dynamic libs) is not
randomized under x86_64. I have no explanation for this. :-/

Regards
-- 
Emmanuel Fleury

I worry about my child and the Internet all the time, even though
she's too young to have logged on yet. Here's what I worry about.
I worry that 10 or 15 years from now, she will come to me and say
'Daddy, where were you when they took freedom of the press away
 from the Internet?'.
  -- Mike Godwin
