Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280377AbRJaSKz>; Wed, 31 Oct 2001 13:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280374AbRJaSKm>; Wed, 31 Oct 2001 13:10:42 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:17100 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S280375AbRJaSKY>; Wed, 31 Oct 2001 13:10:24 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Hasch@t-online.de (Juergen Hasch)
To: linux-kernel@vger.kernel.org,
        Thomas =?iso-8859-1?q?Lang=E5s?= <tlan@stud.ntnu.no>,
        J Sloan <jjs@pobox.com>
Subject: Re: Intel EEPro 100 with kernel drivers
Date: Wed, 31 Oct 2001 19:10:49 +0100
X-Mailer: KMail [version 1.3]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011029021339.B23985@stud.ntnu.no> <3BDCD06E.8AF8FF69@pobox.com> <20011031090125.B10751@stud.ntnu.no>
In-Reply-To: <20011031090125.B10751@stud.ntnu.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <15yzpC-26N6dEC@fwd04.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 31. Oktober 2001 09:01 schrieb Thomas Langås:
> J Sloan:
> > We found that using the intel e100 driver
> > instead of the eepro100 eliminates these
> > errors - YMMV of course -
>
> I've now tried the Intel driver, no help, still get the NFS timeouts (the
> intel driver doesn't output anything to dmesg, so it's no way of telling if
> the same things occur as in the eepro100 stock-kernel driver).

I had some trouble with an Intel STL 2 board and the onboard EEPRO100.
Samba worked OK but it always got stuck on NFS transfers.

There was a bug in the older BMC firmware, so the eepro100 detected
some NFS frames as "TCO" packets.
(http://support.intel.com/support/motherboards/server/ta_353-1.htm)

If you use the e100 driver, you can look at 
/proc/net/PRO_LAN_ADAPTERS/eth0.info
If the "Tx_TCO_Packets" entry isn't zero after NFS times out,
this may be your problem.
With the eepro100 driver you will only see overruns with ifconfig.

If this is the case, you may want to check for a BMC (board management 
controller) software update.

...Juergen
