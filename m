Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbSKSCKQ>; Mon, 18 Nov 2002 21:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbSKSCKP>; Mon, 18 Nov 2002 21:10:15 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:29098 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261346AbSKSCKP>;
	Mon, 18 Nov 2002 21:10:15 -0500
Message-ID: <3DD99EA6.4010000@us.ibm.com>
Date: Mon, 18 Nov 2002 18:15:02 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Pfiffer <andyp@osdl.org>, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Linuxbios <linuxbios@clustermatic.org>
Subject: Re: [ANNOUNCE][CFT] kexec for v2.5.48 && kexec-tools-1.7 
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com>	<m1vg349dn5.fsf@frodo.biederman.org> <1037055149.13304.47.camel@andyp>	<m1isz39rrw.fsf@frodo.biederman.org> <1037148514.13280.97.camel@andyp>	<m1k7jb3flo.fsf_-_@frodo.biederman.org>	<m1el9j2zwb.fsf@frodo.biederman.org> <m11y5j2r9t.fsf_-_@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> kexec is a set of systems call that allows you to load another kernel
> from the currently executing Linux kernel.  The current implementation
> has only been tested, and had the kinks worked out on x86, but the
> generic code should work on any architecture.
> 
> Could I get some feed back on where this work and where this breaks.
> With the maturation of kexec-tools to skip attempting bios calls,
> I expect a new the linux kernel to load for most people.  Though I
> also expect some device drivers will not reinitialize after the reboot.

I give it a big thumbs-up.  Between the NUMAQs and the big xSeries 
machines, we have a lot of slow rebooters.  The 16GB intel boxes take 
at about 5 minutes to get back to the bootloader after a reboot, and 
the 4 and 8-quad NUMAQ's take closer to 10.

The IBM machines I've tried it on are a 4-way and 8-way PIII.  They 
both have aic7xxx cards and the 8-way has a ServeRAID 4 controller. 
They have a collection of acenic, e1000, pcnet32 and eepro100 net 
cards.  All seem to work just fine.

The NUMAQ is another story, though.  I get nothing after "Starting new 
kernel".  But, I wasn't expecting much.  The NUMAQ is pretty weird 
hardware and god knows what is actually happening.  I'll try it some 
more when I'm more confident in what I'm doing.

What's the deal with "FIXME assuming 64M of ram"?  I was a little 
surprised when my 16GB machine started to OOM as I did a "make -j8 
bzImage" :)  Why is it that you need the memory size at load time?
-- 
Dave Hansen
haveblue@us.ibm.com

