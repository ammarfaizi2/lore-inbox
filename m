Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131038AbQLFBIt>; Tue, 5 Dec 2000 20:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131043AbQLFBIj>; Tue, 5 Dec 2000 20:08:39 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:31238 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131038AbQLFBIa>; Tue, 5 Dec 2000 20:08:30 -0500
Date: Tue, 5 Dec 2000 18:36:57 -0600
To: Roberto Ragusa <robertoragusa@technologist.com>
Cc: linux-kernel@vger.kernel.org, kressb@fsc-usa.com
Subject: Re: kernel panic in SoftwareRAID autodetection
Message-ID: <20001205183657.J6567@cadcamlab.org>
In-Reply-To: <14893.25967.936504.881427@notabene.cse.unsw.edu.au> <yam8375.1358.149393648@a4000>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <yam8375.1358.149393648@a4000>; from robertoragusa@technologist.com on Wed, Dec 06, 2000 at 01:08:27AM +0200
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Roberto Ragusa]
> BTW, here is a little patch regarding a silly problem I found
> about RAID partitions naming (/proc/partitions).
> No more "md8" "md9" "md:" "md;" ... but "md8" "md9" "md10" "md11" ...
> Well, this patch should work up to "md99".

This stuff *really* should be split out into the drivers.  Brian Kress
had a patch against test11 for this.  Brian?  You want to fold in this
fix?

> +		if (unit<10) {
> +			sprintf(buf, "%s%c", maj, '0' + unit);
> +			return buf;
> +		}
> +		else {
> +			sprintf(buf, "%s%c%c", maj, '0' + unit / 10, '0' + unit % 10);
> +			return buf;
> +		}

Errrm, that's ugly. (:  Use %d, unless I'm missing something:

			sprintf(buf, "%s%d", maj, unit);

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
