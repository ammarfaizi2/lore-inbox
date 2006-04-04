Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWDDUaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWDDUaK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 16:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWDDUaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 16:30:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13518 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750853AbWDDUaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 16:30:08 -0400
Date: Tue, 4 Apr 2006 13:25:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: ebiederm@xmission.com, bunk@stusta.de, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net, fastboot@osdl.org
Subject: Re: 2.6.17-rc1-mm1: KEXEC became SMP-only
Message-Id: <20060404132546.565b3dae.akpm@osdl.org>
In-Reply-To: <4432C7AC.9020106@vmware.com>
References: <20060404014504.564bf45a.akpm@osdl.org>
	<20060404162921.GK6529@stusta.de>
	<m1acb15ja2.fsf@ebiederm.dsl.xmission.com>
	<4432B22F.6090803@vmware.com>
	<m1irpp41wx.fsf@ebiederm.dsl.xmission.com>
	<4432C7AC.9020106@vmware.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden <zach@vmware.com> wrote:
>
> > If this is really a prelude to introducing more subarchitectures we
>  > need to fix the infrastructure, so it is obvious what is going on.
>  > I would really like to see a machine vector, so we could compile in
>  > multiple subarchitectures at the same time.  That makes building
>  > a generic kernel easier, and the requirement that the we need
>  > to build a generic kernel makes the structure of the subarchiteture
>  > hooks hierarchical and you wind up with code whose dependencies
>  > are visible.  Instead of the current linker and preprocessor magic.
>  > Functions named hook are impossible to comprehend what they
>  > are supposed to do while reading through the code.
>  >   
> 
>  I see your point.  Are you thinking of something like:
> 
>  struct subarch_hooks subarch_hook_vector = {
>       .machine_power_off = machine_power_off,
>       .machine_halt = machine_halt,
>       .machine_irq_setup = machine_irq_setup,
>       .machine_subarch_setup = machine_subarch_probe
>       ...
>  };
> 
>  And machine_subarch_probe can dynamically change this vector if it 
>  confirms that the platform is appropriate?

I don't recall anyone expressing any desire for the ability to set these
things at runtime.  Unless there is such a requirement I'd suggest that the
best way to address Eric's point is to simply rename the relevant functions
from foo() to subarch_foo().

