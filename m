Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUCVXHK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 18:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUCVXHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 18:07:10 -0500
Received: from alt.aurema.com ([203.217.18.57]:61333 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261389AbUCVXHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 18:07:04 -0500
Message-ID: <405F70F6.5050605@aurema.com>
Date: Tue, 23 Mar 2004 10:04:22 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Micha Feigin <michf@post.tau.ac.il>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
References: <20040311141703.GE3053@luna.mooo.com>	<1079198671.4446.3.camel@laptop.fenrus.com>	<4053624D.6080806@BitWagon.com>	<20040313193852.GC12292@devserv.devel.redhat.com>	<40564A22.5000504@aurema.com>	<20040316063331.GB23988@devserv.devel.redhat.com>	<40578FDB.9060000@aurema.com>	<20040320102241.GK2803@devserv.devel.redhat.com>	<405C2AC0.70605@stesmi.com> <20040322223456.GB2549@luna.mooo.com>
In-Reply-To: <20040322223456.GB2549@luna.mooo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Micha Feigin wrote:
> On Sat, Mar 20, 2004 at 12:28:00PM +0100, Stefan Smietanowski wrote:
> 
>>>>>there is one. Nothing uses it
>>>>>(sysconf() provides this info)
>>>>
>>>>Seems to me that it would be fairly trivial to modify those programs 
>>>>(that should use this mechanism but don't) to use it?  So why should 
>>>>they be allowed to dictate kernel behaviour?
>>>
>>>
>>>quality of implementation; for example shell scripts that want to do
>>>echo 500 > /proc/sys/foo/bar/something_in_HZ
>>>...
>>>or /etc/sysctl.conf or ...
>>>
>>
>>Then write a simple program already. How hard is it to write a program
>>that does a sysconf() and returns (as ascii of course) just the
>>value of HZ? Then do some trivial calculation off of that.
>>
>>HZ=$(gethz)
>>
>>If your 500 was 5 seconds, do
>>
>>TIME=$[HZ*5]
>>echo $TIME > /proc/sys/foo/bar/something_in_HZ
>>
> 
> 
> Will this be USER_HZ or kernel HZ?
> Someone earlier suggested it would be USER_HZ which would make it
> pointless.

It has to be whatever enables user space to correctly interpret values 
sent to user space as "ticks".  That means USER_HZ and it's not useless 
as it enables USER_HZ to be different and/or change without breaking 
programs that use values expressed in "ticks".

> 
> 
>>I mean, come on.
>>
>>Then you include it in the default distro of choice so that
>>everybody can use it and there you are.
>>
>>If someone doesn't have "gethz" then they can download it.
>>
>>// Stefan
>>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

