Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbTJVS6r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 14:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263489AbTJVS6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 14:58:47 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:31210 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263459AbTJVS6o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 14:58:44 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Stuart_Hayes@Dell.com
Subject: Re: IDE "logical" geometry & partition tables (problem with 2.4 kerne l, also seems to apply to 2.6)
Date: Wed, 22 Oct 2003 21:03:10 +0200
User-Agent: KMail/1.5.4
Cc: Andries Brouwer <aeb@cwi.nl>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <CE41BFEF2481C246A8DE0D2B4DBACF4F128A38@ausx2kmpc106.aus.amer.dell.com>
In-Reply-To: <CE41BFEF2481C246A8DE0D2B4DBACF4F128A38@ausx2kmpc106.aus.amer.dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310222103.10493.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Your analysis is correct from IDE side,
Andries cc:ed to say more about partition handling side...

thanks,
--bartlomiej

On Wednesday 22 of October 2003 00:00, Stuart_Hayes@Dell.com wrote:
> Bart --
>
> I have discovered a problem with how Linux determines IDE disk "logical"
> (BIOS) geometry.  It only happens under certain unlikely conditions, but I
> think it is worthy of attention.  Please let me know if you see a problem
> with my analysis!
>
> If an IDE hard drive has no partition table when Linux is booted, *and* if
> the hard drive is on a PCI IDE controller (a controller that isn't at I/O
> address 1f0h), *and* if the drive doesn't support 48-bit addressing, Linux
> will just use the geometry that is reported by the drive in with the
> "identify device" command, rather than getting the geometry used by the IDE
> BIOS by doing an int13 function 8 call.  If a partition table is then
> created on the drive using this geometry, the CHS values in the partition
> table will not be correct.
>
> This will cause the drive not to boot if an MBR is used that does CHS
> addressing (rather than LBA addressing)--or if the IDE BIOS doesn't support
> the int13 extentions that allow LBA addressing.
>
> If the drive is on an IDE controller that's at 1F0h (like the primary
> channel on CSB5/ICH5 south bridge controllers), Linux seems to get the
> correct geometry from the BIOS tables (I believe the 2.6 kernel doesn't
> even do this).  Also, if the drive supports 48-bit addressing, Linux
> assumes 255 heads/63 sectors, which is probably correct for all PCI IDE
> controllers. Or, if the drive has an existing partition table, Linux is
> typically able to figure out the correct geometry to use by looking at that
> table.
>
> I would think that the best solution might be either to use an int13
> function 8 call, or assuming 255 heads 63 sectors, if the drive geometry
> can't be read from the BIOS table or figured out from an existing partition
> table.  The geometry reported by the drive itself is almost certain to be
> different from the BIOS geometry.

