Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbTEFKVj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 06:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbTEFKVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 06:21:39 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:44198
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262498AbTEFKVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 06:21:38 -0400
Subject: Re: 2.5.68-mmX: Drowning in irq 7: nobody cared!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Shane Shrybman <shrybman@sympatico.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030505143006.29c0301a.akpm@digeo.com>
References: <1052141029.2527.27.camel@mars.goatskin.org>
	 <20030505143006.29c0301a.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052213733.28797.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 10:35:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-05 at 22:30, Andrew Morton wrote:
> Shane Shrybman <shrybman@sympatico.ca> wrote:
> >
> > Hi,
> > 
> > I am getting a lot of these in the logs. This is with the ALSA emu10k1
> > driver for a SB live card. This is a x86, UP, KT133 system with preempt
> > enabled. The system seems to be running fine.
> > 
> > handlers:
> > [<d8986540>] (gcc2_compiled.+0x0/0x390 [snd_emu10k1])
> > irq 7: nobody cared!
> 
> Beats me.  Does this fix it up?

With APIC at least it doesnt suprise me the least. The IRQ hack seems
extremely racey. Remember on most systems (especially with PIII type
APIC) IRQ delivery is asynchronous to the bus so you get

IRQ arrives
			sound card
			loop
				clean up IRQ
IRQ sent
				still more work, do it
			done
			HANDLED

IRQ arrives
			sound card
			Umm duh no work for me
			NOT HANDLED

		Whine

For anything where you get pairs of close IRQ's

