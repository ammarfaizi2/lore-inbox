Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264763AbUGSH1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264763AbUGSH1k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 03:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264767AbUGSH1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 03:27:40 -0400
Received: from ms-2.rz.RWTH-Aachen.DE ([134.130.3.131]:54496 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S264763AbUGSH1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 03:27:38 -0400
Date: Mon, 19 Jul 2004 09:27:32 +0200
From: Alexander Gran <alex@zodiac.dnsalias.org>
Subject: Re: fixing usb suspend/resuming
In-reply-to: <40F962B6.3000501@pacbell.net>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org
Message-id: <200407190927.38734@zodiac.zodiac.dnsalias.org>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
X-Ignorant-User: yes
References: <200405281406.10447@zodiac.zodiac.dnsalias.org>
 <200406011614.32726@zodiac.zodiac.dnsalias.org> <40F962B6.3000501@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Samstag, 17. Juli 2004 19:32 schrieb David Brownell:
>> I'm not clear on the intended relationship between PCI device state
> numbers and ACPI device states in Linux ... but it's clear from the
> specs (ACPI ch2, the mostly-generic bit) that ACPI "3" != PCI "3".

ermm, ok. It is even more complicated. Section 2 of the ACPI specs speaks of 
Global Power states and device power states. 
So we ge the follwing, with G= ACPI Global power state, S = (ACPI?) Sleep 
State, D = ACPI Device power state,
G3 = Mechanical off = everything D3
G2=S5=soft off = everything D3
G1=S4 = Hibernation = everything D3
G1=S3/S2=Sleeping = parts in D2/D1/(D0?)
G0=S0=Working = evrything in D0

/proc/acpi/sleep talks about the S states, so when I want STR, which is S3 i 
echo 3 > /proc/acpi/sleep.
The PCI state would also be 3 for most devices, I think. Pci state 1 or 2 
cannot be expected to be supported.

> I'm suspecting that something is mistranslating between ACPI
> power state numbering and PCI power state numbering

ACK.

> I'd _certainly_ expect that the numbers passed to PCI suspend
> and resume calls would match the PCI state numbers, not the
> ACPI numbers!  But those numbers aren't documented in the
> Linux sources, so probably different people are making rather
> different assumptions.  After all, "3 == 3" and "2 == 2".
>
> That's all different from the ACPI system power states, too.
> (Which is what I'd expect /proc/acpi/sleep to affect.)

I think that file doesn't expect Global power states, as thats only on, 
sleeping, off, but sleep states. However I don't see the translation into PCI 
sleep states either. But there must be some translation, as a 3 is translatet 
into a 2 here (which than failes..)

I suppose some cleanup and documentation is required here.

regards
Alex

- -- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA+3fp/aHb+2190pERArKfAJ4mShRA2zHafuPrsWKTPVVFUumHQwCfYb3M
9x0AqFQqhhPILjYDEnxlXH4=
=d/FA
-----END PGP SIGNATURE-----

