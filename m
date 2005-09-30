Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbVI3C5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVI3C5i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 22:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVI3C5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 22:57:37 -0400
Received: from web34109.mail.mud.yahoo.com ([66.163.178.107]:37458 "HELO
	web34109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932222AbVI3C5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 22:57:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=WJ/tytDjytpwXQCAO7nUA9xQqSsVsryD0KPDkr210NuQ2ZMGe2VK7pZ9wdZXNvY7X0wH55Hm3e1J8il4vF7a2GrzwXpTWdaHoHhVtl0SoV0ypXsw5f8NY3l8fP00PZfe5PJvh2cmBfEJvy5Id6TboD85UKnshd1aI0TS+Uh8b94=  ;
Message-ID: <20050930025736.63518.qmail@web34109.mail.mud.yahoo.com>
Date: Thu, 29 Sep 2005 19:57:36 -0700 (PDT)
From: Wilson Li <yongshenglee@yahoo.com>
Subject: Re: Slow loading big kernel module in 2.6 on PPC platform
To: Samuel Masham <Samuel.Masham@jp.sony.com>,
       Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "Yamaguchi, Yohei" <Yohei.Yamaguchi@jp.sony.com>,
       Tim Bird <tim.bird@am.sony.com>
In-Reply-To: <200509291030.39024.Samuel.Masham@jp.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Samuel Masham <Samuel.Masham@jp.sony.com> wrote:

> > Wilson Li wrote:
> > > Hi,
> > > 
> > > I am trying to port several third party kernel modules from
> > kernel
> > > 2.4 to 2.6 on a ppc (MPC824x) platform. For small size of
> > modules, it
> > > works perfectly in 2.6. But there's one huge kernel module
> which
> > size
> > > is about 2.7M bytes (size reported by lsmod after insmod), and
> it
> > > takes about 90 seconds to load this module before init_module
> > starts.
> > > I did not notice there's such obvious delay in 2.4 kernel.
> 
> I assume you are on a slow ppc32 platform.
> 
> The time taken is a function of the number of symbols, you can work
> around it 
> as shown in the patch below. Obviously this is just an example
> patch and is
> NOT signed off for anything but reading :)
> 
> I would really like do some work on a pre-link for modules but
> don't really know 
> where to start.
> 
> Any hints?
> 
> Samuel
> 
> ps Not subscribed, just  so please cc me
> 

Here's my two cents.

1. Add time-consuming get_plt_size() functionality to
scripts/mod/modpost.c (per arch), and calculate the size when
scripts/mod/modpost is called to generate mymodule.mod.c during
making of kernel module.

2. How to pass this info down to sys_init_module() in kernel? Maybe
we can add a special section in mymodule.mod.c. So this info will be
part of mymodule.ko and parsed by sys_init_module() later.

Then it won't make too much impact on the build process.

Sounds easy;-) Hopefully it'll work.

Wilson Li







	
		
______________________________________________________ 
Yahoo! for Good 
Donate to the Hurricane Katrina relief effort. 
http://store.yahoo.com/redcross-donate3/ 

