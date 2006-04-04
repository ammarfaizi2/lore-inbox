Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbWDDWm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWDDWm5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 18:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWDDWm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 18:42:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30091 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750825AbWDDWm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 18:42:56 -0400
Date: Tue, 4 Apr 2006 15:38:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: ebiederm@xmission.com, bunk@stusta.de, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net, fastboot@osdl.org
Subject: Re: 2.6.17-rc1-mm1: KEXEC became SMP-only
Message-Id: <20060404153848.55c4811a.akpm@osdl.org>
In-Reply-To: <4432F469.1040405@vmware.com>
References: <20060404014504.564bf45a.akpm@osdl.org>
	<20060404162921.GK6529@stusta.de>
	<m1acb15ja2.fsf@ebiederm.dsl.xmission.com>
	<4432B22F.6090803@vmware.com>
	<m1irpp41wx.fsf@ebiederm.dsl.xmission.com>
	<4432C7AC.9020106@vmware.com>
	<20060404132546.565b3dae.akpm@osdl.org>
	<4432ECF1.8040606@vmware.com>
	<20060404151904.764ad9f4.akpm@osdl.org>
	<4432F469.1040405@vmware.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden <zach@vmware.com> wrote:
>
> Do weak symbols work with all tool chains?
> 

I hope so.  `grep weak */*.c'.

> >   
> >> 2) You don't need #ifdef SUBARCH_FUNC_FOO goo to do this (renaming 
> >> voyager_halt -> default)
> >>     
> >
> > Why would one need that?  Isn't it simply a matter of renaming
> > machine_halt() to subarch_machine_halt() everywhere?
> >   
> 
> No - if you rename machine_halt to subarch_machine_halt, you again can't 
> add a new subarch interface without changing all subarchitectures.  If I 
> add voyager_smp_bless_voyage(), I now need to add #define 
> visws_smp_bless_voyage default_smp_bless_voyage, ... or did you mean 
> subarch_machine_halt literally?

Yes, I meant subarch_machine_halt() literally.

> > I'm just looking for the simplest option here.  Eric has identified a code
> > maintainability problem - it'd be good to fix that, but we shouldn't add
> > runtime cost/complexity unless we actually gain something from it.
> >   
> 
> I think weak symbols are the best approach, if they indeed work with all 
> tool chains.

They do.
