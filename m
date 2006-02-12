Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbWBLXxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWBLXxz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 18:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWBLXxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 18:53:55 -0500
Received: from fsmlabs.com ([168.103.115.128]:20682 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1751493AbWBLXxy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 18:53:54 -0500
X-ASG-Debug-ID: 1139788431-27666-119-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Sun, 12 Feb 2006 15:58:31 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Marko <letterdrop@gmx.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
X-ASG-Orig-Subj: Re: How getting a pointer on the per-cpu struct tss_struct??
Subject: Re: How getting a pointer on the per-cpu struct tss_struct??
In-Reply-To: <20060213002706.50e5289c.letterdrop@gmx.de>
Message-ID: <Pine.LNX.4.64.0602121552520.10777@montezuma.fsmlabs.com>
References: <20060213002706.50e5289c.letterdrop@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.8641
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006, Marko wrote:

> But when I try to compile this, I get the warning:
> 
> 	*** Warning: "per_cpu__init_tss" [/home/..../module.ko]
> 	undefined!
> 
> and according to this warning an error, when I try to load the module:
> 
> 	insmod: error inserting 'module.ko': -1 Unknown symbol in module

init_tss isn't exported, you would need to do 
EXPORT_PER_CPU_SYMBOL(init_tss).

Also a suggestion, you should use __get_cpu_var instead of per_cpu e.g.

	struct tss_struct *t;
	/* if you don't need cpu variable just preempt_disable */
	int cpu = get_cpu();
	t = __get_cpu_var(init_tss);
...
	put_cpu();
