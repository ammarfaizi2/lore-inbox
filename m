Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265325AbUAAIJt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 03:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265329AbUAAIJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 03:09:49 -0500
Received: from 202.46.136.7.interact.com.au ([202.46.136.7]:51313 "EHLO gaston")
	by vger.kernel.org with ESMTP id S265325AbUAAIJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 03:09:48 -0500
Subject: Re: How to avoid 'lost interrupt' messages post-resume?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1072932095.6722.22.camel@laptop-linux>
References: <1072932095.6722.22.camel@laptop-linux>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1072939036.768.39.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 01 Jan 2004 19:09:33 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-01 at 15:41, Nigel Cunningham wrote:
> Hi all.
> 
> I have Software Suspend successfully running under 2.4.23 on a dual
> Celeron at OSDL, with only one outstanding issue: sometimes, after
> copying back the original kernel, I see 'hda: lost interrupt' and after
> another pause 'hdb:lost interrupt' messages. Apart from that, everything
> works fine (the machine has just suspended for the 46th time on the
> trot). I'm wanting to know if there's something I can do to fix this
> issue.
> 
> Currently, prior to suspending, I set all irq affinities to CPU 0 (which
> does the suspend), save the state of the APICs and disable them and
> disable interrupts. At resume time, I again set the affinities to CPU 0
> and disable the APICs and interrupts prior to copying the original
> kernel back. After copying the original kernel back, I restore the
> original (pre-suspend) affinities and APIC settings & reenable
> interrupts (incomplete list). I'm no hardware expert, so feel free to
> tell me I'm doing something lame! Apart from these lost interrupts, all
> seems to work just fine.

You probably had a pending IDE request or something like that... IDE
in 2.4.x doesn't quite have the infrastructure to deal properly with
suspend & resume...

Ben.

