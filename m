Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbUKDNIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbUKDNIT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 08:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbUKDNIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 08:08:19 -0500
Received: from zone3.gcu-squad.org ([217.19.50.74]:62473 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S262209AbUKDNIQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 08:08:16 -0500
Date: Thu, 4 Nov 2004 14:02:36 +0100 (CET)
To: degger@fhm.edu
Subject: Re: dmi_scan on x86_64
X-IlohaMail-Blah: khali@gcu.info
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <eGbz1eL6.1099573353.4166380.khali@gcu.info>
In-Reply-To: <1214282D-2E5B-11D9-BF00-000A958E35DC@fhm.edu>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "LKML" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/11/2004, Daniel Egger wrote:

> The sensors conf for the S2875 provided by Tyan only displays
> 3 FAN RPM values while the board has at least 4. At the moment I'm
> using 3 fans with tacho signal but can only determine 2 values, the
> third value is constantly 0.

The (admittedly limited) documentation [1] I have for the S2875 states
that only 3 of the 6 fan headers have their tachometer pin wired. This
matches the W83627HF hardware monitoring chip capabilities, which is why
I see no evidence of any kind of multiplexing on that board.

> Also the setup puzzles me a bit; why would Tyan pack several SMBus
> setups into a single motherboard but only connect devices to one
> of them. Actually sensors-detect claims that there is one
> unrecognized client on the "unused" SMBus.

Not all SMBus clients are hardware monitoring chips. The fact that
sensors-detect didn't recognize it would even suggest that your unknown
chip isn't. What you see may be about anything, including
pseudo-clients used for the SMBus protocol itself.

Feel free to submit a dump (using i2cdump) of that unknown chip if you
want me to comment on it.

As a side note, Tyan actually has a long history of embedding more than
one hardware monitoring chip in their high-end server boards. This makes
full sense when the board has plenty of fan headers and supports several
CPU. The S4882 for example has 6 hardware monitoring chips, and this is
one reason why the SMBus had to be multiplexed (4 of these chips use the
same address).

[1] ftp://ftp.tyan.com/datasheets/d_s2875_120.pdf

Jean
