Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWFFXLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWFFXLK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 19:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWFFXLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 19:11:10 -0400
Received: from sc-outsmtp2.homechoice.co.uk ([81.1.65.36]:32774 "HELO
	sc-outsmtp2.homechoice.co.uk") by vger.kernel.org with SMTP
	id S1751332AbWFFXLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 19:11:09 -0400
Subject: Re: [linuxsh-dev] [Alsa-devel] [PATCH] Add support for Yamaha
	AICA	sound on	SEGA Dreamcast
From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Paul Mundt <lethal@linux-sh.org>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       linux-sh <linuxsh-dev@lists.sourceforge.net>
In-Reply-To: <s5hslmimvh5.wl%tiwai@suse.de>
References: <1149201071.9032.13.camel@localhost.localdomain>
	 <1149334788.9065.5.camel@localhost.localdomain>
	 <s5hslmimvh5.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 00:10:48 +0100
Message-Id: <1149635448.5154.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 12:25 +0200, Takashi Iwai wrote:

> 
> As Paul already pointed, the platform_device things must be fixed.
> Also, better to clean up the code directly accessing hardcoded
> addresses.

Working on that, some new code in my personal CVS now - but I suspect it
will be the weekend before that gets fully fixed.


> 
> Another big concern is that spu_dma_work is initialized/rewritten
> dynamically in spu_begin_dma() and aica_period_elapsed() via
> INIT_WORK() and PREPARE_WOR().  This looks pretty strange and may be
> racy.

Actually, the two macros INIT_WORK and PREPARE_WORK use the same work
queue but ask it to schedule the execution of two different (if very
similar) functions start_spu_dma() - which does the initial transfer and
more_spu_dma - which tops up the dma transfers.

So I think I've got that right.

