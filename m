Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263855AbTLARrK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 12:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTLARrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 12:47:10 -0500
Received: from [66.35.79.110] ([66.35.79.110]:2463 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S263855AbTLARrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 12:47:08 -0500
Date: Mon, 1 Dec 2003 05:49:19 -0800
From: Tim Hockin <thockin@hockin.org>
To: Nicolas =?iso-8859-1?Q?Castagn=E9?= <nicolas.castagne@imag.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: a few question on threads affinity and CPU shielding.
Message-ID: <20031201134919.GA10663@hockin.org>
References: <D7F95611-2425-11D8-9C79-000393C76CA6@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D7F95611-2425-11D8-9C79-000393C76CA6@imag.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 01, 2003 at 06:43:16PM +0100, Nicolas Castagné wrote:
> I  was very pleased that some patches for controlling CPU affinities  
> were merged in the 2.5 (and 2.6) releases of the kernel.
> 
> Where may I find precisions on the patches that are now included ?

> - is there also a patch to shield cpu against the scheduler ?

I have a patch around that does this (against RedHat's backported O(1)).
Forward porting it should be no more difficult that creating it in the first
place :)  I was waiting until after 2.6.x was more stable to offer it.

> - is there also a patch to shield cpu against all interruptions  
> (especially hard clock interrups) ?

This could be added to my patch.

What my patch added was a sched_setprocstate() syscall, which lets you set a
CPU's run state.  Currently I support:

ENABLED - run any task
RESTRICTED - run only tasks with (cpus_allowed == 1 << cpu)
ISOLATED - run only tasks with
	(cpus_allowed == 1 << cpu && cpus_allowed_mask == 1 << cpu)

Tim
