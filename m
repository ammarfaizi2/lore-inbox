Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289314AbSBEAYU>; Mon, 4 Feb 2002 19:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289315AbSBEAYM>; Mon, 4 Feb 2002 19:24:12 -0500
Received: from pc1-camc5-0-cust78.cam.cable.ntl.com ([80.4.0.78]:23751 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S289314AbSBEAYB>;
	Mon, 4 Feb 2002 19:24:01 -0500
Message-Id: <m16XtOG-000OVeC@amadeus.home.nl>
Date: Tue, 5 Feb 2002 00:23:16 +0000 (GMT)
From: arjan@fenrus.demon.nl
To: Oliver.Neukum@lrz.uni-muenchen.de
Subject: Re: current->state after kmalloc
cc: linux-kernel@vger.kernel.org
In-Reply-To: <16Xt8Y-1SQ44eC@fwd04.sul.t-online.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <16Xt8Y-1SQ44eC@fwd04.sul.t-online.com> you wrote:

> set_current_state(TASK_INTERRUPTIBLE);
> kmalloc(sizeof(struct x), GFP_KERNEL);

> what is current->state after kmalloc ?

undefined. If kmalloc slept and you survived (due to setting
TASK_INTERRUPTIBLE that's not guaranteed)  then it'll most likely be
TASK_RUNNING. 
If you depend on this your kernel code is broken in that has subtle
dependencies on unspecified behavior and will break whenever kmalloc changes
internal behavior.

Greetings,
   Arjan van de Ven

