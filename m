Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264791AbSJaJ4C>; Thu, 31 Oct 2002 04:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264797AbSJaJ4C>; Thu, 31 Oct 2002 04:56:02 -0500
Received: from 11.67.3.213.dial.bluewin.ch ([213.3.67.11]:42882 "EHLO
	k3.hellgate.ch") by vger.kernel.org with ESMTP id <S264791AbSJaJ4B>;
	Thu, 31 Oct 2002 04:56:01 -0500
Date: Thu, 31 Oct 2002 11:02:45 +0100
From: Roger Luethi <rl@hellgate.ch>
To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, sergeyssv@mail.ru,
       linux-kernel@vger.kernel.org
Subject: Re: VIA EPIA problem
Message-ID: <20021031100245.GA5207@k3.hellgate.ch>
Mail-Followup-To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, sergeyssv@mail.ru,
	linux-kernel@vger.kernel.org
References: <1036021926.6756.3.camel@irongate.swansea.linux.org.uk> <200210302343.g9UNhxW6012759@wildsau.idv.uni.linz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210302343.g9UNhxW6012759@wildsau.idv.uni.linz.at>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.44 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002 00:43:59 +0100, H.Rosmanith (Kernel Mailing List) wrote:
> okay. please note it's a workaround. but it worked at least for
> my board (and I have a via epia itx 500Mhz). this board seems to
> be the only one which had the problems with the vt6103 onboard
> ethernet-chip.

I remember going over some logs you sent me. As I said back then, the
proper fix will most certainly deal with the error that turned off the Tx
engine to begin with. Assuming that it's not a major "invisible error" bug
in some Rhine chips, it must be an error that is currently invisible to the
_driver_. Stands to reason :-).

My favorite suspect is currently byte 84 bit 3 in the configuration
registers. It does not exist in VT86C100A (which would explain why it's not
handled in Donald Becker's original code). According to VT6102 specs, it
indicates an error condition, according to VT6105 specs, it is reserved and
always reads 0.

The MAC you find on VIA EPIAs integrated into VT8231 is a VT6102, so that
might actually be the culprit. I haven't been able to reproduce the error
on a VT6102 based PCI-card, though.

As for the EPIA, my testing environment is somewhat limited since there
seems some trick involved in getting certain VIA hardware around here. My
usual contacts couldn't sell me a VIA EPIA, not even the P4PB400 (VT6105M
based), let alone the mysterious, fascinating Rhine-III based PCI-card [1].

If anybody knows a reliable VIA vendor who does international delivery I'd
be interested (off-list, of course, I'm not soliciting commercial email to
the list <g>).

Roger

PS: Seems to be a VIA OEM card with PCI strings 1106:3106 (rev 85)
    Subsystem: 1106:0105.
