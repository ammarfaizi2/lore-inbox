Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751878AbWJIOjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbWJIOjT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbWJIOjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:39:19 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:43942 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1751878AbWJIOjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:39:18 -0400
Message-ID: <452A5F14.2020907@s5r6.in-berlin.de>
Date: Mon, 09 Oct 2006 16:39:16 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
CC: linux-kernel@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH] Minor coding style fix
References: <452913DB.4010409@gmail.com> <9a8748490610080829r54053e14ud8c7b02c8f39476c@mail.gmail.com> <452932F5.7090601@gmail.com>
In-Reply-To: <452932F5.7090601@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh Kumar K.V wrote:
> As per Documentation/CodingStyle 
> 
> "Functions can return values of many different kinds, and one of the
> most common is a value indicating whether the function succeeded or
> failed.  Such a value can be represented as an error-code integer
> (-Exxx = failure, 0 = success) or a "succeeded" boolean (0 = failure,
> non-zero = success)."
> 
> That means if the function need to indicate success it should be made
> to return 0.

The wording is 'can', not 'should' or 'shall'. The current agreement is
however that do_something()-named functions indeed 'should' return <0
for "failure" and 0 for "success" while is_something()-named functions
'should' return non-0 for "yes" and 0 for "no". But there is no rule
without exceptions: Some functions like copy_to_user() return >0 in
situations which can be considered a "failure" because this positive
value has further meaning.

But back to your patch: I am not aware of an agreement on how to write a
check for zero or a check for nonzero.

> I don't see any other value being returned from init_srcu_struct.

True.

> Also having a consistent style of if() check make code reading easier.

Also true. However (a) there is no kernel-wide consistency about this
and (b) the style used in the file which you are patching is
	if (do_something_returning_negative_errors() < 0)
E.g.
http://www.linux-m32r.org/lxr/http/source/kernel/sys.c?v=2.6.19-rc1#L1070

And here <0 and !0 are actually different:
http://www.linux-m32r.org/lxr/http/source/kernel/sys.c?v=2.6.19-rc1#L852

However, kernel/sys.c is not entirely consequent:
http://www.linux-m32r.org/lxr/http/source/kernel/sys.c?v=2.6.19-rc1#L1336
and the other calls to copy_{from,to}_user would have to be
	if (copy_to_user(a, b, s) != 0)
or > 0 to follow the style of the above mentioned ifs to 100%. But
that's nitpicking. :-)
-- 
Stefan Richter
-=====-=-==- =-=- -=---
http://arcgraph.de/sr/
