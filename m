Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWC2W15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWC2W15 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 17:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWC2W15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 17:27:57 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:51908 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751058AbWC2W14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 17:27:56 -0500
Subject: Re: BUG: ide related "soft lockup detected on CPU"
From: Lee Revell <rlrevell@joe-job.com>
To: Brice Figureau <brice+lklm@daysofwonder.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1143641235.15002.51.camel@localhost.localdomain>
References: <1143641235.15002.51.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 17:27:49 -0500
Message-Id: <1143671270.13933.45.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-29 at 16:07 +0200, Brice Figureau wrote:
> Hi,
> 
> I just encountered the following traces in my logs on a mail server.
> The server is a mono Xeon HT running an highmem SMP 2.6.15.1 kernel.
> The server uses a md raid1 array of several partitions of two PATA hard
> disk.
> 
> First evidence:
> at 19:05 I got the following:
> 
> kernel: hdc: irq timeout: status=0xd0 { Busy }
> kernel: ide: failed opcode was: 0xe7
> kernel: hdc: status timeout: status=0xd0 { Busy }
> kernel: ide: failed opcode was: unknown
> kernel: hdc: DMA disabled
> kernel: hdc: drive not ready for command
> kernel: ide1: reset: success
> 
> then the BUG: exactly two hours later:
> 
> kernel: BUG: soft lockup detected on CPU#0!
> kernel:
> kernel: Pid: 8, comm:             events/0
> kernel: EIP: 0060:[ide_pio_sector+193/247] CPU: 0
> kernel: EIP is at ide_pio_sector+0xc1/0xf7

Almost certainly a hardware problem - your disk stopped responding and
the kernel dropped from DMA to PIO mode, which did not seem to help.

Check the drives, cooling, cabling.

Lee

