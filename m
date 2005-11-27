Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbVK0TmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbVK0TmX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 14:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbVK0TmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 14:42:22 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:26498
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750807AbVK0TmW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 14:42:22 -0500
Subject: Re: 2.6.15-rc2-mm1: kernel BUG at kernel/timer.c:213
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200511271951.55262.bero@arklinux.org>
References: <200511271951.55262.bero@arklinux.org>
Content-Type: text/plain
Organization: linutronix
Date: Sun, 27 Nov 2005 20:47:48 +0100
Message-Id: <1133120868.32542.329.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-11-27 at 19:51 +0100, Bernhard Rosenkraenzer wrote:
> This happens when modprobe-ing rt2500 (http://rt2400.sf.net/) -- since the 
> same driver works perfectly on older kernels, the timer rework may be at 
> fault (didn't have a lot of time to look into this yet)

------------[ cut here ]------------
> kernel BUG at kernel/timer.c:213!
> 
        BUG_ON(!timer->function);

The caller of __mod_timer did not fill in the function member.

I decoded the conglomeration of characters which seems to be the driver
source - shudder - and actually the init code of the driver initializes
the TuningTimer after register_netdev, which leads to a race with the
hotplug code. "Working perfectly" on older kernels is just by chance not
by design.

	tglx


