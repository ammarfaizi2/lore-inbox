Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129092AbRBLXMZ>; Mon, 12 Feb 2001 18:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129075AbRBLXMN>; Mon, 12 Feb 2001 18:12:13 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:12814 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129092AbRBLXME>;
	Mon, 12 Feb 2001 18:12:04 -0500
Date: Tue, 13 Feb 2001 00:11:23 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "H. Peter Anvin" <hpa@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: LILO and serial speeds over 9600
Message-ID: <20010213001123.D17129@almesberger.net>
In-Reply-To: <3A885F72.ED9ADAE8@transmeta.com> <E14SRPp-0008J1-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14SRPp-0008J1-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Feb 12, 2001 at 10:25:47PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Explain 'controlled buffer overrun'.

That's probably the ability to send new data even if there's unacked old
data (e.g. because the receiver can't keep up or because we've had losses).

Such a feature would be mainly useful in cases where data becomes useless
if too old, e.g. VoIP. Ironically, for the console, the opposite may be
true: if the kernel all of a sudden starts vomiting printks, the relevant
information is more likely to be at the beginning than at the end.

One advantage of TCP would be that such an implementation is more likely
to get congestion control right, so it would be safer to use over the
Internet. (And using UDP wouldn't make this any easier.) Also, when using
TCP, it's more likely that some reasonable session management is built
into the design.

BTW, as far as the boot loader is concerned: any of the Linux boots Linux
designs should nicely solve this, with the possible exception of
environments where a legacy OS needs to be booted. Reminds me that I should
find some time besides traffic control to work a bit on bootimg ...

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
