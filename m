Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264183AbUFXKZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbUFXKZg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 06:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264198AbUFXKZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 06:25:36 -0400
Received: from zero.aec.at ([193.170.194.10]:20743 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264183AbUFXKZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 06:25:35 -0400
To: Yusuf Goolamabbas <yusufg@outblaze.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: finish_task_switch high in profiles in 2.6.7
References: <2ayz2-1Um-15@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 24 Jun 2004 12:25:32 +0200
In-Reply-To: <2ayz2-1Um-15@gated-at.bofh.it> (Yusuf Goolamabbas's message of
 "Thu, 24 Jun 2004 11:20:20 +0200")
Message-ID: <m3n02tz203.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yusuf Goolamabbas <yusufg@outblaze.com> writes:

> Hi, I have a fairly busy mailserver which also has a simple iptables
> ruleset (blocking some IP's) running 2.6.7 with the deadline i/o
> scheduler. vmstat was reporting that system time was around 80%. I did
> the following

How many context switches do you get in vmstat?

Most likely you just have far too many of them. readprofile will attribute
most of the cost to finish_task_switch, because that one reenables the 
interrupts (and the profiling only works with interrupts on)

Too many context switches are usually caused by user space.

-Andi 

