Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261434AbREXLMx>; Thu, 24 May 2001 07:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261459AbREXLMo>; Thu, 24 May 2001 07:12:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29707 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261434AbREXLMd>;
	Thu, 24 May 2001 07:12:33 -0400
Date: Thu, 24 May 2001 12:11:52 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Rodrigo Ventura <yoda@isr.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch to put IDE drives in sleep-mode after an halt
Message-ID: <20010524121152.A11086@flint.arm.linux.org.uk>
In-Reply-To: <lx4rubc8kq.fsf@pixie.isr.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <lx4rubc8kq.fsf@pixie.isr.ist.utl.pt>; from yoda@isr.ist.utl.pt on Thu, May 24, 2001 at 12:03:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2001 at 12:03:49PM +0100, Rodrigo Ventura wrote:
>         I am submitting a patch to kernel/sys.c that walks through all
> IDE drives (#ifdef CONFIG_BLK_DEV_IDE, of course), and issues a
> "sleep" command (as code in hdparam) to each one of them right before
> the kernel halts. Here goes the diff:

I'm not going to comment on the idea, just the implementation.  Eww.

First point is that this has no business being in kernel/sys.c - it
belongs in the ide layer, not the generic kernel.

Secondly, you have this wonderous reboot notifier list which you can
arbitarily register functions with throughout the kernel, and they
will get called prior to halt/reboot.  You should be using this, via
the register_reboot_notifier() hooks.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

