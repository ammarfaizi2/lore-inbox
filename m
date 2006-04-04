Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWDDWLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWDDWLA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 18:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWDDWLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 18:11:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28289 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750782AbWDDWLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 18:11:00 -0400
Date: Tue, 4 Apr 2006 15:09:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zan Lynx <zlynx@acm.org>
Cc: linux-kernel@vger.kernel.org, rl@hellgate.ch,
       "John W. Linville" <linville@tuxdriver.com>
Subject: Re: 2.6.17-rc1-mm1
Message-Id: <20060404150953.41d7e04e.akpm@osdl.org>
In-Reply-To: <1144187618.26812.7.camel@localhost>
References: <20060404014504.564bf45a.akpm@osdl.org>
	<1144187618.26812.7.camel@localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zan Lynx <zlynx@acm.org> wrote:
>
> On Tue, 2006-04-04 at 01:45 -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc1/2.6.17-rc1-mm1/
> 
> Has anyone seen this yet?
> 
> BUG: scheduling while atomic: mii-tool/0x00000001/2968
>  <c02db7f7> schedule+0x43/0x540   
>  <c02dc617> schedule_timeout+0x7a/0x95
>  <c011d687> process_timeout+0x0/0x5   
>  <c011e8a4> msleep+0x1a/0x1f
>  <e09100c9> rhine_disable_linkmon+0x40/0xf1 [via_rhine]   
>  <e09101a6> mdio_read+0x1f/0xab [via_rhine]
>  <e08c7443> generic_mii_ioctl+0x6c/0x13f [mii]   
>  <e0911900> netdev_ioctl+0x2e/0x4e [via_rhine]
>  <e09118d2> netdev_ioctl+0x0/0x4e [via_rhine]   
>  <c02890a7> dev_ifsioc+0x3b8/0x3d2
>  <c0289438> dev_ioctl+0x34e/0x47a    
>  <c027fc63> sock_ioctl+0x0/0x1c0
>  <c015b694> do_ioctl+0x1c/0x5d  
>  <c015b917> vfs_ioctl+0x242/0x255
>  <c015b954> sys_ioctl+0x2a/0x42  
>  <c02dd80f> sysenter_past_esp+0x54/0x75
> 
> The system also has Intel Ethernet Pro 100 and SiS900 Ethernet
> controllers, but only the VIA Rhine driver does this.

netdev_ioctl() does spin_lock_irq(), so the mdelay->msleep conversion (now
in mainline) was insufficient.

Someone needs to turn on those nice debugging options...

hmm, according to git-whatchanged, this bug has been in there since October
last year.  Weird that it hasn't been spotted before now.
