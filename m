Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266870AbUIAP3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266870AbUIAP3W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 11:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266890AbUIAP3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:29:22 -0400
Received: from upco.es ([130.206.70.227]:13035 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S266870AbUIAP2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:28:20 -0400
Date: Wed, 1 Sep 2004 17:28:17 +0200
From: Romano Giannetti <romano@dea.icai.upco.es>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Driver retries disk errors.
Message-ID: <20040901152817.GA4375@pern.dea.icai.upco.es>
Mail-Followup-To: Romano Giannetti <romano@dea.icai.upco.es>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040830163931.GA4295@bitwizard.nl> <1093952715.32684.12.camel@localhost.localdomain> <20040831135403.GB2854@bitwizard.nl> <1093961570.597.2.camel@localhost.localdomain> <20040831155653.GD17261@harddisk-recovery.com> <1093965233.599.8.camel@localhost.localdomain> <20040831170016.GF17261@harddisk-recovery.com> <1093968767.597.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1093968767.597.14.camel@localhost.localdomain>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 05:12:50PM +0100, Alan Cox wrote:
> 
> > (1) Imagine an application doing a linear read on a file with an 8
> > block read ahead and the last block being bad. The kernel will try to
> > read that bad block 16 times, but because the IDE driver also has 8
> > retries, the kernel will try to read that bad block *64* times. It
> > usually takes an IDE drive about 2 seconds to figure out a block is
> > bad, so the application gets stuck for 2 minutes in that single bad
> > block.
> 
> Right now I know of no way to tell which is readahead for a failed
> command or of telling the block layer to forget them. Fix this at the
> block layer and IDE can abort the readahead sequence happily enough
> because IDE is too dumb to have issued further commands to the drive at
> this point.

Just a question from a kernel-almost-illiterate. Could this explain the
behavior of my laptop yesterday, reading a damaged DVD? I had to wait almost
one full minute of retry until being able to kill xine... 

If maintaining the retries, it could be nice to allow at least kill -9
between them. I do not know if that's foolish and/or impossible, so please
do not bash too hard... 

Have a nice day,
            Romano 


-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
