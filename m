Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbVCJIOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbVCJIOA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 03:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbVCJIN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 03:13:59 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:43692
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262391AbVCJIMD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 03:12:03 -0500
Subject: Re: [patch 1/1] unified spinlock initialization
	arch/um/drivers/port_kern.c
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       user-mode-linux-devel@lists.sourceforge.net, domen@coderock.org,
       amitg@calsoftinc.com, gud@eth.net
In-Reply-To: <200503092052.24803.blaisorblade@yahoo.it>
References: <20050309094234.8FC0C6477@zion>
	 <20050309171231.H25398@flint.arm.linux.org.uk>
	 <200503092052.24803.blaisorblade@yahoo.it>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 09:12:00 +0100
Message-Id: <1110442320.29330.196.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-09 at 20:52 +0100, Blaisorblade wrote:
> > Are you sure this is really the best option in this instance?
> > Sometimes, static data initialisation is more efficient than
> > code-based manual initialisation, especially when the memory
> > is written to anyway.
> Agreed, theoretically, but this was done for multiple reasons globally, for 
> instance as a preparation to Ingo Molnar's preemption patches. There was 
> mention of this on lwn.net about this:
> 
> http://lwn.net/Articles/108719/

Those patches did only the conversion of

static spinlock_t lock = SPIN_LOCK_UNLOCKED;
       lock = SPIN_LOCK_UNLOCKED;
to
static DEFINE_SPINLOCK(lock);
       spin_lock_init(lock);

If you want to do static initialization inside of structures, then you
have to define a seperate MACRO similar to the static initialization of
list_head's inside of structures:

static struct sysfs_dirent sysfs_root = {
        .s_sibling      = LIST_HEAD_INIT(sysfs_root.s_sibling),

tglx


