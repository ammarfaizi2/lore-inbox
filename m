Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSGIKLA>; Tue, 9 Jul 2002 06:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313202AbSGIKK7>; Tue, 9 Jul 2002 06:10:59 -0400
Received: from realimage.realnet.co.sz ([196.28.7.3]:15596 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S313190AbSGIKK6>; Tue, 9 Jul 2002 06:10:58 -0400
Date: Tue, 9 Jul 2002 12:31:30 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Dave Hansen <haveblue@us.ibm.com>
Cc: dan carpenter <error27@email.com>,
       <kernel-janitor-discuss@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: lock_kernel check...
In-Reply-To: <3D2AA802.2020705@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0207091228250.4869-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2002, Dave Hansen wrote:

> It isn't absoulutely a bad thing to return while you have a lock held. 
>     It might be hard to understand, or even crazy, but not immediately 
> wrong :)
> 
> // BKL protects both "a", and io port 0xF00D
> bar()
> {
> 	lock_kernel();
> 	return inb(0xF00D);
> }
> 
> int a;
> foo()
> {
> 	a = bar();
> 	a--;
> 	unlock_kernel();
> }

But broken nonetheless, that kinda thing just looks ugly. Especially when 
someone tries to call bar multiple times or consecutively or with the lock 
already held or...

	Zwane Mwaikambo

-- 
function.linuxpower.ca

