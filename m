Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbUKDOtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbUKDOtp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 09:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbUKDOtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 09:49:45 -0500
Received: from dialin-212-144-169-006.arcor-ip.net ([212.144.169.6]:38336 "EHLO
	karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S262245AbUKDOta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 09:49:30 -0500
In-Reply-To: <eGbz1eL6.1099573353.4166380.khali@gcu.info>
References: <eGbz1eL6.1099573353.4166380.khali@gcu.info>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-49-1013475611"
Message-Id: <B55F1204-2E70-11D9-BF00-000A958E35DC@fhm.edu>
Content-Transfer-Encoding: 7bit
Cc: "LKML" <linux-kernel@vger.kernel.org>
From: Daniel Egger <degger@fhm.edu>
Subject: Re: dmi_scan on x86_64
Date: Thu, 4 Nov 2004 15:49:19 +0100
To: "Jean Delvare" <khali@linux-fr.org>
X-Pgp-Agent: GPGMail 1.0.2
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-49-1013475611
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 04.11.2004, at 14:02, Jean Delvare wrote:

> The (admittedly limited) documentation [1] I have for the S2875 states
> that only 3 of the 6 fan headers have their tachometer pin wired. This
> matches the W83627HF hardware monitoring chip capabilities, which is 
> why
> I see no evidence of any kind of multiplexing on that board.

Ah, I start to make sense of what exactly you're doing.

> Not all SMBus clients are hardware monitoring chips. The fact that
> sensors-detect didn't recognize it would even suggest that your unknown
> chip isn't. What you see may be about anything, including
> pseudo-clients used for the SMBus protocol itself.

> Feel free to submit a dump (using i2cdump) of that unknown chip if you
> want me to comment on it.

egger@ulli:~$ sudo i2cdetect -l
i2c-2   unknown         SMBus2 AMD8111 adapter at c400          
Algorithm unavailable
i2c-1   dummy           ISA main adapter                        ISA bus 
algorithm
i2c-0   unknown         SMBus AMD756 adapter at 50e0            
Algorithm unavailable

egger@ulli:~$ sudo i2cdetect 2
WARNING! This program can confuse your I2C bus, cause data loss and 
worse!
I will probe file /dev/i2c-2.
I will probe address range 0x03-0x77.
Continue? [Y/n] y
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX

egger@ulli:~$ sudo i2cdump 2 8
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and 
worse!
I will probe file /dev/i2c-2, address 0x8, mode byte
Continue? [Y/n] y
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX

Anything else I can try?

Servus,
       Daniel

--Apple-Mail-49-1013475611
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQYpBbzBkNMiD99JrAQK0/Af/RsnxWBP7eCc4GB9hMbTA7cIpO4PMMmwJ
CkyM2sfkn4irpFMQEqmNVilS55te7YW2uglwy2i2u2hhEvPyZiQs8o2QQYgTlZCi
SLC5OuJpdJkd0WZg+JLRUyQd2HmryXDJ8y2G+kcr05SPRUlU0BXcckp7VyaHyYjY
6J2j677+MfO5+ao/HzPm0E/oEc0ITu12K41ByMTLrtmeLK+uOzMXcsbt3fKP1aNM
qsiNaOfll7Ct1pd2/v25ElJjipZsyqWJmd/YAEivA9rovBRlf91MZBiPwaFAN91x
1zISE4VGJj8LD7wDbJTdh8769GFI3nSQMqMZ1hD9puDAcbvz9t44HQ==
=HWh4
-----END PGP SIGNATURE-----

--Apple-Mail-49-1013475611--

