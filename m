Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVE3EEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVE3EEj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 00:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVE3EEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 00:04:38 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:6501 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261512AbVE3EEf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 00:04:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZEwAk7qa8g4kKARPuSJPOqP913f1IiIy8XIre+LS7Jke1UBrtLB4yBrESUgSPcqaE7iZ1ejO3lgowNWAc+VByrsbrZ6R8VvagoXiDv6TrDJWRAGut5P2eZqhdmMIa6VBXezTAk9Y4EysY4akDb9lcWHLbFSilzaehlJeNxiujpw=
Message-ID: <311601c905052921046692cd3e@mail.gmail.com>
Date: Sun, 29 May 2005 22:04:34 -0600
From: "Eric D. Mudama" <edmudama@gmail.com>
Reply-To: "Eric D. Mudama" <edmudama@gmail.com>
To: Greg Stark <gsstark@mit.edu>
Subject: Re: [PATCH] SATA NCQ support
Cc: Jens Axboe <axboe@suse.de>, Matthias Andree <matthias.andree@gmx.de>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com
In-Reply-To: <87oeatxtw4.fsf@stark.xeocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050527070353.GL1435@suse.de>
	 <20050527131842.GC19161@merlin.emma.line.org>
	 <20050527135258.GW1435@suse.de> <429732CE.5010708@gmx.de>
	 <20050527145821.GX1435@suse.de> <87oeatxtw4.fsf@stark.xeocode.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 May 2005 23:41:31 -0400, Greg Stark <gsstark@mit.edu> wrote:
> I would be interested to see those benchmarks people were posting earlier
> claiming 30-40% difference retested with write caching disabled. I suspect
> disabling write caching will demolish the non-NCQ performance but have a much
> smaller effect on NCQ-enabled performance.
> 
> Currently Postgres strongly recommends SCSI drives and the belief is that it's
> the tagged command queuing that allows SCSI drives to perform well without
> resorting to data integrity destroying write caching.

If used properly, I don't feel write cache "destroys" data integrity,
you just need to get your power failure tolerance elsewhere.

ATA has a limitation of 32 tags, so queued write cache off won't beat
unqueued write cache on in any modern drive.

The real reason most SCSI drives do so well uncached is they use huge
magnets with short, stiff actuators, smaller platters, and they spin
significantly faster.  NCQ certainly helps, but spending more money on
mechanics makes a significant difference.  Pick up a SCSI drive and an
ATA drive, you'll feel the SCSI weighs seemingly twice as much.

--eric
