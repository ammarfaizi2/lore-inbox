Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265487AbUIAKRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265487AbUIAKRX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 06:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265808AbUIAKRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 06:17:22 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:48071 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S265795AbUIAKRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 06:17:03 -0400
References: <courier.41359B53.00007549@softhome.net>
            <20040901095229.GA11908@devserv.devel.redhat.com>
In-Reply-To: <20040901095229.GA11908@devserv.devel.redhat.com> 
From: filia@softhome.net
To: Arjan van de Ven <arjanv@redhat.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
Date: Wed, 01 Sep 2004 04:16:59 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [212.18.200.6]
Message-ID: <courier.4135A19B.00007EA5@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven writes: 

> On Wed, Sep 01, 2004 at 03:50:11AM -0600, filia@softhome.net wrote:
>> Hi!  
>> 
>> Stop being arrogant.
>> Can you please elaborate on how to make Linux kernel support e.g. motion 
>> controllers? They do not fit *any* known to me driver interface. They have 
>> several axes, they have about twenty parameters (float or integer), and 
> 
> parameters nicely fit in sysfs. 
> 

 What about errors?
 "set di 200000" might fail for lots of reasons. 

>> they have several commands, a-la start, graceful stop, abrupt stop. Plus 
>> obviously diagnostics - about ten another commands with absolutely 
>> different parameters. And about ten motion monitoring commands. And this is 
>> one example I were need to program. 
> 
> a write() interface doesn't work???
> Hard to believe, you even call them commands.
> fd = open("/dev/funkydevice");
> write(fd, "start"); 
> 
> doesn't sound insane to me 
> 

 it doesn't, since you didn't tryed to make error handling. every thing can 
fail - this is control of mechanics - and it fails often and for a lot of 
reasons. Put here error handling (write(struct whatever) has to return 
another struct whatever2 filled with error description) and thread-safeness. 
Pluss some controllers do support multi-dimensional movements "start 
x,y,z,etc" - and you might have _several_ error structs. Atomicity is 
important for multi-dimensional moves too - move on given axes starts with 
single command. 

 hu? 

 I do not see much point in renaming ioctl() to write() all over the place - 
at least when people see ioctl() they understand that it is not standard 
functionality. write() will for sure confuse a lot of people. 

 --- with respect. best regards.
***    Philips @ Saarbruecken. 
