Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSHFTSr>; Tue, 6 Aug 2002 15:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315358AbSHFTSr>; Tue, 6 Aug 2002 15:18:47 -0400
Received: from chaos.analogic.com ([204.178.40.224]:63108 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315337AbSHFTSm>; Tue, 6 Aug 2002 15:18:42 -0400
Date: Tue, 6 Aug 2002 15:24:54 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: linux-kernel@vger.kernel.org, abraham@2d3d.co.za
Subject: Re: ethtool documentation
In-Reply-To: <Pine.LNX.4.33L2.0208060834030.10089-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.3.95.1020806151104.25149A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2002, Randy.Dunlap wrote:

> 
> Abraham vd Merwe <abraham@2d3d.co.za> wrote:
> | What is the difference between the supported and advertising fields?
> | What is MII? (as in the SUPPORTED_MII feature?).
> 
> MII:  (is this a serious question ?):
> [from a National Semi. ethernet repeater design Application Note]
> The Medium Independent Interface, as specified in the IEEE 802.3u/D5.3
> standard, is designed to support the PHY/MAC interface.
> 
> | > ETHTOOL_GEEPROM
> | > ETHTOOL_SEEPROM
> | >
> | >   Get/set EEPROM data.  These commands expect a 'struct ethtool_eeprom
> | >   *'
> | >   argument.  This struct has a magic number, an offset and length
> | >   pair, and a
> | >   data field.  If the offset+length are longer than the maximum size,
> | >   the extra is silently ignored.
> |
> | Wouldn't it have been better to make this 'n character device which can
> | be read from / written to just like a normal file (/dev/nvram-like
> | interface) -
> | that way applications can actually use unused eeprom space.
> 
> I wouldn't care for this.  There's nothing 'normal' about this
> EEPROM space, and apps generally won't know where there might be
> some 'unused eeprom space'.
> 
> -- 
> ~Randy


The EEPROM (SEEPROM) on these NICS is used to contain the startup
configuration bits and the IEEE Station Address. This must be a
unique number that is assigned so that there is no other such
number in (preferably) the world, and certainly in the LAN.
If you let a user write to this area, you will allow the user
to destroy the connectivity on a LAN.

If you provide an ioctl() to write new SEEPROM contents, it had
better be disabled in code that user's (any, including root)
can execute because, if caught, your company may lose it's IEEE
Station Addresses and never again be allowed to configure Ethernet
Controllers.

Because of this, there is no such thing as 'unused eeprom space' in
the Ethernet Controllers. Be careful about putting this weapon in
the hands of the 'public'. All you need is for one Linux Machine
on a LAN to end up with the same IEEE Station Address as another
on that LAN and connectivity to everything on that segment will
stop. You do this once at an important site and Linux will get a
very black eye.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

