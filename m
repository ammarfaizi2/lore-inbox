Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262527AbVCIXQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbVCIXQt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbVCIXPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:15:50 -0500
Received: from fire.osdl.org ([65.172.181.4]:53996 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262529AbVCIWv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:51:59 -0500
Date: Wed, 9 Mar 2005 14:50:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: blaisorblade@yahoo.it, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, domen@coderock.org,
       amitg@calsoftinc.com, gud@eth.net
Subject: Re: [patch 1/1] unified spinlock initialization
 arch/um/drivers/port_kern.c
Message-Id: <20050309145044.764bc056.akpm@osdl.org>
In-Reply-To: <20050309224259.J25398@flint.arm.linux.org.uk>
References: <20050309094234.8FC0C6477@zion>
	<20050309171231.H25398@flint.arm.linux.org.uk>
	<200503092052.24803.blaisorblade@yahoo.it>
	<20050309224259.J25398@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
>  I'm not convinced about the practicality of converting all static
>  initialisations to code-based initialisations though

This is the first one I recall seeing.  All the other conversions were replacing

	static spinlock_t lock = SPIN_LOCK_UNLOCKED;

with
	static DEFINE_SPINLOCK(lock);

and replacing

	{
		lock = SPIN_LOCK_UNLOCKED;
	}

with

	{
		spin_lock_init(lock);
	}

