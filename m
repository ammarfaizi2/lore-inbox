Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbUCYXY6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 18:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbUCYXY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 18:24:58 -0500
Received: from alt.aurema.com ([203.217.18.57]:17064 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S263646AbUCYXYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:24:54 -0500
Message-ID: <406369A1.7090905@aurema.com>
Date: Fri, 26 Mar 2004 10:22:09 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Micha Feigin <michf@post.tau.ac.il>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
References: <1079198671.4446.3.camel@laptop.fenrus.com> <4053624D.6080806@BitWagon.com> <20040313193852.GC12292@devserv.devel.redhat.com> <40564A22.5000504@aurema.com> <20040316063331.GB23988@devserv.devel.redhat.com> <40578FDB.9060000@aurema.com> <20040320102241.GK2803@devserv.devel.redhat.com> <405C2AC0.70605@stesmi.com> <20040322223456.GB2549@luna.mooo.com> <405F70F6.5050605@aurema.com> <20040325174053.GB11236@mail.shareable.org>
In-Reply-To: <20040325174053.GB11236@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Peter Williams wrote:
> 
>>>Will this be USER_HZ or kernel HZ?
>>>Someone earlier suggested it would be USER_HZ which would make it
>>>pointless.
>>
>>It has to be whatever enables user space to correctly interpret values 
>>sent to user space as "ticks".  That means USER_HZ and it's not useless 
>>as it enables USER_HZ to be different and/or change without breaking 
>>programs that use values expressed in "ticks".
> 
> 
> It is, however, useless for the _other_ reasons userspace needs to
> know kernel HZ, including as I mentioned userspace timer granularity.

Theoretically, which I know can be a pain, user space timer granularity 
should be in USER_HZ as, theoretically, this is the only one user space 
is supposed to know about.  Because of this, in my view, HZ and USER_HZ 
should be the same or USER_HZ should be greater than HZ.

> 
> (Btw, that usage would be better as a period rather than a frequency,
> so that a "tickless" kernel can report zero).

_SC_CLK_TCK is a POSIX.1 definition and can't be changed.  But I don't 
think that there's any impediment to adding new parameters that can be 
reported by sysconf().

> 
> The fundamental problem is that there are two values,  and both values
> have programs which can usefully use them.
> 
> How hard can it be to export both?
> 

Making HZ == USER_HZ would also solve the problem.

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

