Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263557AbUJ2Wct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263557AbUJ2Wct (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 18:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbUJ2Wax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 18:30:53 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:4916 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S263530AbUJ2WSi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 18:18:38 -0400
Subject: Re: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP
	kernel
From: Paul Fulghum <paulkf@microgate.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Tim_T_Murphy@Dell.com, Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041029212029.I31627@flint.arm.linux.org.uk>
References: <4B0A1C17AA88F94289B0704CFABEF1AB0B4CC4@ausx2kmps304.aus.amer.dell.com>
	 <20041029212029.I31627@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1099088289.5965.2.camel@at2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 29 Oct 2004 17:18:09 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 15:20, Russell King wrote:
> At a guess, you've enabled "low latency" setting on this port ?

Ah, that would explain the problem better than
the code path I saw (flip buffer full).
The problem is still the same: calling the flip
work routine from the ISR, which calls through
N_TTY receive_buf->flush_chars->start_tx.

-- 
Paul Fulghum
paulkf@microgate.com


