Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWANVpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWANVpg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 16:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWANVpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 16:45:35 -0500
Received: from flock1.newmail.ru ([212.48.140.157]:20101 "HELO
	flock1.newmail.ru") by vger.kernel.org with SMTP id S1751298AbWANVpe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 16:45:34 -0500
From: Andrey Borzenkov <arvidjaar@newmail.ru>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [lm-sensors] 2.6.15: lm90 0-004c: Register 0x13 read failed (-1)
Date: Sun, 15 Jan 2006 00:45:25 +0300
User-Agent: KMail/1.9.1
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
References: <200601142223.35838.arvidjaar@newmail.ru> <20060114222032.1c2ff252.khali@linux-fr.org>
In-Reply-To: <20060114222032.1c2ff252.khali@linux-fr.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601150045.30942.arvidjaar@newmail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 15 January 2006 00:20, Jean Delvare wrote:
> Hi Andrey,
>
> > Vanilla 2.6.15 on Toshiba Portege 4000. I get constant messages in dmesg:
> >
> > i2c_adapter i2c-0: Error: command never completed
> > lm90 0-004c: Register 0x1 read failed (-1)
> > i2c_adapter i2c-0: Error: command never completed
> > lm90 0-004c: Register 0x14 read failed (-1)
> > i2c_adapter i2c-0: Error: command never completed
> > lm90 0-004c: Register 0x8 read failed (-1)
> > i2c_adapter i2c-0: Error: command never completed
> > lm90 0-004c: Register 0x0 read failed (-1)
> >
> > for quite a number of registers. Apparently I can read sensors just fine
> > still I am uneasy seeing those.
>
> Before 2.6.15, the lm90 driver did not handle read errors in any way,
> so they were probably already there, you simply were not aware of it.
> However, I guess that you already had the "command never completed"
> errors? These come from the i2c-ali1535 bus driver.
>

Before 2.6.15 I run Mandriva kernel 2.6.12-12mdk. I do not remember them but 
may be I just never actually looked in dmesg :)

> It would be possible to add a retry-on-failure mechanism in the lm90
> driver. However, the real problem is more likely in the i2c-ali1535
> driver so fixing this one driver would be preferable.
>
> > eeprom-i2c-0-50
> > Adapter: SMBus ALI1535 adapter at ef00
> > Memory type:            SDR SDRAM DIMM
> > Memory size (MB):       256
> >
> > adm1032-i2c-0-4c
> > Adapter: SMBus ALI1535 adapter at ef00
> > M/B Temp:    +43°C  (low  =   -65°C, high =  +127°C)
> > CPU Temp:  +47.6°C  (low  = +43.0°C, high = +51.0°C)   ALARM
> > M/B Crit:   +127°C  (hyst =  +122°C)
> > CPU Crit:   +100°C  (hyst =   +95°C)
>
> Do you also have "command never completed" errors without an associated
> error from the lm90 driver?

yes, on boot.

> This would suggest that the eeprom driver 
> too is triggering errors, which in turn would confirm that we need to
> fix the i2c-ali1535 driver rather than adding a workaround to the lm90
> driver.
>
> It looks like the i2c-ali1535 driver as it exists in the lm_sensors CVS
> repository (for Linux 2.4 kernels) did receive a major change in March
> 2005. These changes were supposed to "fix stability problems" (by
> adding delay loops pretty much everywhere). They were never ported to
> the Linux 2.6 version of the driver. Maybe we should try doing so now.
>
> This is a 400 lines patch, porting it won't be trivial, I am not
> familiar with this driver myself and I don't have a chip to test my
> changes on, so if someone else wants to take his/her chance, go. If
> not, I'll do it.
>
> Andrey, will you be able to test a i2c-ali1535 patch if we come up with
> one?

Yes. Send me a patch (or give a link) and I'll try what I can do to port it. I 
ask if I have a question :)

BTW that reminds me - I actually have two 256M modules. Sensors show just one. 
Both are from Toshiba so it is unlikely that one does not have SPD - any idea 
why eeprom does not find second one? Oh, and it was the same when I had two 
128M modules so it is unlikely caused by modules.

thank you for reply

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDyXD6R6LMutpd94wRAsIqAJwP5CdEisSKsA/iGqv2ouZ58xLe8ACgvRIY
WfuwZrsE996ZEtSoYvElgnQ=
=SSCR
-----END PGP SIGNATURE-----
