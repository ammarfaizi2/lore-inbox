Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbTKCRWx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 12:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263297AbTKCRWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 12:22:52 -0500
Received: from [62.233.185.126] ([62.233.185.126]:260 "EHLO
	aclaptop.unregistered.futuro.pl") by vger.kernel.org with ESMTP
	id S263277AbTKCRWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 12:22:51 -0500
From: Szymon =?iso-8859-2?q?Aceda=F1ski?= <accek@poczta.gazeta.pl>
To: Ruben Puettmann <ruben@puettmann.net>
Subject: Re: Synaptics losing sync
Date: Mon, 3 Nov 2003 18:13:24 +0100
User-Agent: KMail/1.5
References: <N7gI.1K3.9@gated-at.bofh.it> <200311021048.33698.accek@poczta.gazeta.pl> <20031103132557.GD27206@puettmann.net>
In-Reply-To: <20031103132557.GD27206@puettmann.net>
MIME-Version: 1.0
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200311031813.24701.accek@poczta.gazeta.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 November 2003 14:25, you wrote:
> On Sun, Nov 02, 2003 at 10:48:33AM +0100, Szymon Aceda?ski wrote:
>
>                 hy,
>
> > "Losing too many ticks" exists when I'm running with cpufreq
> > [p4_clockmod] and clock=tsc (default). This is because of rescaling TSC
> > pitch by cpufreq, I think. If I specify in bootloader clock=hpet, problem
> > disappears. [Am I doing right?]
>
> If I boot with clock=hpet the cpu MHz in cat /proc/cpuinfo is 0.

Oh, yes. HPET timer needs ACPI support to work (also HPET is not present on 
many machines). You can probably find 'Warning: clock= override failed' in 
your dmesg. The default timer is then set to PIT. Determination of CPU clock 
when using PIT is not implemented in the kernel, so it's reported as zero in 
/proc/cpufreq. You may also find some patches around the LKML adding support 
for ACPI timer, but it needs ACPI itself. I didn't try it.

	Szymon
