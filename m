Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263058AbUC2Ssa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 13:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263063AbUC2Ssa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 13:48:30 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:25492 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S263058AbUC2Sq6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 13:46:58 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Date: Mon, 29 Mar 2004 10:46:50 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [PATCH] speed up SATA
In-Reply-To: <20040329113641.GE1453@openzaurus.ucw.cz>
Message-ID: <Pine.LNX.4.58.0403291042370.19679@dlang.diginsite.com>
References: <4066021A.20308@pobox.com> <20040329113641.GE1453@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel, when you say that 32MB would be 1 second is that due to the limits
of the SATA bus or are you baseing this on a particular drive?

if you are basing it on a current single SATA drive (7200rpm 8MB cache,
etc) consider that if you are writing to a solid state drive or to an
array that presents itself as a single SATA drive then the transaction can
happen MUCH faster.

if this is a limit of the SATA interface bitrate, consider that over the
last several years EVERY interface has seen it's bitrate climb
significantly, frequently with little (if any) fundamentalchange to the
drivers nessasary to run things.

David Lang

On Mon, 29 Mar 2004, Pavel Machek wrote:

> Date: Mon, 29 Mar 2004 13:36:42 +0200
> From: Pavel Machek <pavel@suse.cz>
> To: Jeff Garzik <jgarzik@pobox.com>
> Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
>      Andrew Morton <akpm@osdl.org>
> Subject: Re: [PATCH] speed up SATA
>
> Hi!
>
> > Things seem to be looking pretty good, so it's now time to turn on
> > lba48-sized transfers.  Most SATA disks will be lba48 anyway, even
> > the ones smaller than 137GB, for this and other reasons.
> >
> > With this simple patch, the max request size goes from 128K to
> > 32MB... so you can imagine this will definitely help performance.
> > Throughput goes up.  Interrupts go down.  Fun for the whole family.
>
> 32MB is one second if everything goes okay... That will be horrible for latency, right?
> --
> 64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
