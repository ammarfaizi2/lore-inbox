Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbUKILbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUKILbm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 06:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbUKILbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 06:31:42 -0500
Received: from mx2.elte.hu ([157.181.151.9]:37086 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261497AbUKILLc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 06:11:32 -0500
Date: Tue, 9 Nov 2004 13:13:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Amit Shah <amit.shah@codito.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RT-V0.7.22 Bug with fbdev and e100
Message-ID: <20041109121330.GA23533@elte.hu>
References: <200411091623.51495.amit.shah@codito.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411091623.51495.amit.shah@codito.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Amit Shah <amit.shah@codito.com> wrote:

> drivers/video/console/fbcon.c:fbcon_cursor needs additional locking?

this issue is a bit different. The problem is that the irq warning
message (which is harmless) is printed from an atomic context. In the
next release i'll try something different: simply dont print to the
fbcon if the kernel is in an atomic context. This will reduce the
utility of fbcon when debugging kernel crashes, but it should avoid this
assert (and potential problems resulting out of it). Other types of
consoles (serial, text, netconsole) will still try to output everything,
independently of atomicity. (of these, only netconsole wants to
reschedule.)

	Ingo
