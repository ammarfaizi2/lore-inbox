Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270826AbUJUTGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270826AbUJUTGq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 15:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270837AbUJUTGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 15:06:44 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:57763
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S270826AbUJUTFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 15:05:32 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
In-Reply-To: <41780687.8030408@cybsft.com>
References: <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
	 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
	 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
	 <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
	 <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu>
	 <20041021132717.GA29153@elte.hu>  <4177FADC.6030905@cybsft.com>
	 <1098384016.27089.42.camel@thomas>  <41780687.8030408@cybsft.com>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1098385049.27089.51.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 21 Oct 2004 20:57:29 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 20:57, K.R. Foley wrote:
> > I guess, you don't have a tulip network card in your box, as the module
> > is removed.
> > 
> > The question is, if it got registered correctly before the removal.
>
> Actually I do have the tulip card in the box and I am pulling this stuff 
> from the logs over that connection now. Here are the next lines from the 
> log that might help.

Not really. We must figure out, why sys_delete_module is called. 

[<e09a7767>] tulip_cleanup+0x17/0x1b [tulip] (16)
[<c0139801>] sys_delete_module+0x121/0x150 (12)   <<--------
[<c01531a1>] sys_munmap+0x51/0x60 (64)
[<c0116a20>] do_page_fault+0x0/0x660 (16)
[<c0106719>] sysenter_past_esp+0x52/0x71 (16)

> Oct 21 12:33:22 porky kernel: tulip 0000:04:0a.0: Device was removed 
> without pro
> perly calling pci_disable_device(). This may need fixing.

This one is a result of the BUG()

tglx


