Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266316AbUIIQsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266316AbUIIQsm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 12:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266391AbUIIQqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 12:46:35 -0400
Received: from pD9517510.dip.t-dialin.net ([217.81.117.16]:59525 "EHLO
	undata.org") by vger.kernel.org with ESMTP id S266349AbUIIQpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 12:45:05 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
From: Thomas Charbonnel <thomas@undata.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark_H_Johnson@raytheon.com, Ingo Molnar <mingo@elte.hu>,
       Lee Revell <rlrevell@joe-job.com>, Free Ekanayaka <free@agnula.org>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, luke@audioslack.com, free78@tin.it
In-Reply-To: <1094682656.12371.28.camel@localhost.localdomain>
References: <OF08E1ED49.F0799581-ON86256F09.0070E65F-86256F09.0070E6A7@raytheon.com>
	 <1094682656.12371.28.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1094748286.18782.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 09 Sep 2004 18:44:46 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote :
> On Mer, 2004-09-08 at 21:33, Mark_H_Johnson@raytheon.com wrote:
> > >.... Please disable IDE DMA and see
> > >what happens (after hiding the PIO IDE codepath via
> > >touch_preempt_timing()).
> > 
> > Not quite sure where to add touch_preempt_timing() calls - somewhere in the
> > loop in ide_outsl and ide_insl? [so we keep resetting the start /end
> > times?]
> 
> If you haven't done hdparm -u1 that may be a reason you want to touch
> these. To defend against some very bad old h/w where a stall in the I/O
> stream to the disk causes corruption we disable IRQ's across the
> transfer in PIO mode by default.
> 

I had the exact same problem showing in the output of latencytest, and
enabling unmaskirq on the drive being stressed solved it, thanks !

See this for the problem :
http://www.undata.org/~thomas/unmaskirq_0/index.html
and this for the (impressive) results :
http://www.undata.org/~thomas/unmaskirq_1/index.html

Thomas


