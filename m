Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWC2Hqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWC2Hqo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 02:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWC2Hqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 02:46:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:64573 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751162AbWC2Hqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 02:46:43 -0500
Date: Wed, 29 Mar 2006 09:46:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Dan Aloni <da-x@monatomic.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Status of NCQ in libata
Message-ID: <20060329074650.GT8186@suse.de>
References: <20060326192749.GA3643@localdomain> <20060327072945.GC8186@suse.de> <442A0980.6060403@gmail.com> <20060329074352.GA29915@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060329074352.GA29915@localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29 2006, Dan Aloni wrote:
> On Wed, Mar 29, 2006 at 01:13:52PM +0900, Tejun Heo wrote:
> > Jens Axboe wrote:
> > >On Sun, Mar 26 2006, Dan Aloni wrote:
> > >>Hello,
> > >>
> > >>I'd like to know about the current status of NCQ support in libata,
> > >>whether anyone is actively working on it, where I should find a 
> > >>development branch (there's no ncq branch anymore in libata-dev.git
> > >>it seems) and when an upstream merge should be expected.
> > >
> > >You can give it a spin in the 'ncq' branch in the block layer git repo:
> > >
> > >git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-2.6-block.git
> > >
> > >Only one real bit needs to get merged in libata for ncq to be submitted,
> > >and that is Tejun's eh rework. Once that is in, ncq becomes a fairly
> > >small patch and can probably go straight in.
> > >
> > >AHCI is still the only supported controller, once NCQ is merged I'm sure
> > >a few others will follow.
> > >
> > 
> > Patches going out later today. :) I've just ported the NCQ stuff over it 
> > and about to test it. As I have the doc and hardware NCQ support for 
> > sata_sil24 will soon follow.
> 
> Good to see it's going well. I'm considering to implement NCQ/TCQ for 
> sata_mv (I have the necessary resources for it), so I'm hoping that I'd be 
> able to base my efforts on the current ncq branch without worrying too 
> much about interface changes.

As seen from the low level sata driver, there isn't much interface to
change. Basically you just want to signal a higher queueing depth, which
will enable the SCSI layer to queue a higher number of ios at any time.
The rest is up to you, how you actually talk to the hardware. Then
there's error handling, I don't think much will change there after
Tejuns merge either.

So if you started off the 'ncq' branch in the block repo, you should be
able to pretty much cary your sata_mv changes straight over. Any change
needed would be to accomodate other libata changes, not ncq.

-- 
Jens Axboe

