Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbULFPem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbULFPem (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 10:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbULFPel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 10:34:41 -0500
Received: from mx1.elte.hu ([157.181.1.137]:64721 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261535AbULFPee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 10:34:34 -0500
Date: Mon, 6 Dec 2004 16:34:14 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.32-0
Message-ID: <20041206153414.GB23729@elte.hu>
References: <OF783C60D6.A87E04B2-ON86256F62.004E56E5@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF783C60D6.A87E04B2-ON86256F62.004E56E5@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.201, required 5.9,
	BAYES_00 -4.90, SORTED_RECIPS 2.70
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> >i'm not sure what point you are trying to make, but 'low RT load' in
> >this context means up to a load of 1.0. (i.e. one or less tasks running
> >on average)

> I am not quite so sure that is a good assumption with our real time
> system either. [...]

I implemented this feature with your workload in mind. This is what i
wrote:

> > on low RT load (the common case) the scheduler behaves like the
> > stock scheduler - the new logic only kicks in if a CPU runqueue has
> > 2 or more RT tasks running at once.

'the common case' == ordinary (non-RT) Linux boxes! When i implement
scheduler features i'm always trying to make them as generic as
possible, i.e. this feature too is structured to be as upstream
mergeable as possible. For that purpose the change had to be
low-overhead in the common, non-RT case. It is easy to hack the
scheduler to fix some RT issue but break the generic scheduler - this
solution is not meant to be such a hack.

	Ingo
