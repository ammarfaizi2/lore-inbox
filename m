Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUJESm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUJESm3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 14:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUJESm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 14:42:29 -0400
Received: from mx2.elte.hu ([157.181.151.9]:4256 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264665AbUJESku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 14:40:50 -0400
Date: Tue, 5 Oct 2004 20:42:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm2-T1
Message-ID: <20041005184226.GA10318@elte.hu>
References: <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu> <32799.192.168.1.5.1096994246.squirrel@192.168.1.5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32799.192.168.1.5.1096994246.squirrel@192.168.1.5>
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


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> Still the same ugliness here with T1. As before, there goes some info
> attached, which I could collect while barely up and running.

the dmesg info shows you had a crash early on, in khubd:

 Badness in remove_proc_entry at fs/proc/generic.c:688
  [<c018c8e8>] remove_proc_entry+0x152/0x15a
  [<f8b8e116>] uhci_hcd_init+0x116/0x133 [uhci_hcd]
  [<c0135f0e>] sys_init_module+0x1df/0x2da
  [<c01044ed>] sysenter_past_esp+0x52/0x71
 usb 3-1: new low speed USB device using address 2
 Unable to handle kernel paging request at virtual address a49c0e0c

i believe this is a crash present in -mm too. In theory such a crash
could mess up the kernel so best would be if you could try a kernel with
USB disabled? Hopefully none of your critical devices is on USB ...

	Ingo
