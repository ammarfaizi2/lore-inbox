Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbTGILPI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 07:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265976AbTGILPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 07:15:07 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:23216
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265974AbTGILPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 07:15:05 -0400
Subject: Re: [PATCH] Readd BUG for SMP TLB IPI
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030709124915.3d98054b.ak@suse.de>
References: <20030709124915.3d98054b.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057750022.6255.41.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Jul 2003 12:27:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-09 at 11:49, Andi Kleen wrote:
> Adding an ACK for this path is also no good, because then the SMP flusher would
> need to detect this case and "retransmit" the IPI, otherwise it would hang too
> in the loop waiting for other CPUs. But nobody has ever seen such a hang, so it's safe
> to assume that all hardware guarantees it cannot happen.

We have recorded retransmitted IPI's on some boards (notably the
infamous BP6). They do happen. Early 2.4 had a fix for handling the
replay case too, but someone lost it and BP6 boards no longer work as
reliably.

An IPI can be retried and the retry for dual PII at least seems to hit
all the CPUs. Even on a 2 CPU box this has been observed - I assume
because the error was raised by the IO APIC when it got a garbled IPI.

Go ask Intel if you doubt it.

