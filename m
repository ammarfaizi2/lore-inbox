Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129100AbQKMURr>; Mon, 13 Nov 2000 15:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129103AbQKMUR2>; Mon, 13 Nov 2000 15:17:28 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:56845 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129100AbQKMURV>; Mon, 13 Nov 2000 15:17:21 -0500
Date: Mon, 13 Nov 2000 13:46:30 -0600
To: Torsten.Duwe@caldera.de
Cc: Francis Galiegue <fg@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Modprobe local root exploit
Message-ID: <20001113134630.C18203@wire.cadcamlab.org>
In-Reply-To: <14864.5656.706778.275865@ns.caldera.de> <Pine.LNX.4.21.0011131744100.594-100000@toy.mandrakesoft.com> <14864.6812.849398.988598@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14864.6812.849398.988598@ns.caldera.de>; from duwe@caldera.de on Mon, Nov 13, 2000 at 05:45:16PM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Torsten Duwe]
> >>>>> "Francis" == Francis Galiegue <fg@mandrakesoft.com> writes:
> 
>     >> + if ((*p & 0xdf) >= 'a' && (*p & 0xdf) <= 'z') continue;
> 
>     Francis> Just in case... Some modules have uppercase letters too :)
> 
> That's what the &0xdf is intended for...

It's wrong, then: you've converted to uppercase, not lowercase.

request_module is not a fast path.  Do it the obvious, unoptimized way:

  if ((*p < 'a' || *p > 'z') &&
      (*p < 'A' || *p > 'Z') &&
      (*p < '0' || *p > '9') &&
      *p != '-' && *p != '_')
    return -EINVAL;

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
