Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264978AbTFCMZy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 08:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264979AbTFCMZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 08:25:54 -0400
Received: from camus.xss.co.at ([194.152.162.19]:57092 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S264978AbTFCMZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 08:25:41 -0400
Message-ID: <3EDC96EA.5020906@xss.co.at>
Date: Tue, 03 Jun 2003 14:39:06 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Haumer <andreas@xss.co.at>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: system clock speed too high?
References: <3EDBA83B.5050406@xss.co.at> <1054582573.7494.51.camel@dhcp22.swansea.linux.org.uk> <3EDC7052.9060109@xss.co.at> <3EDC8DC0.7090009@xss.co.at>
In-Reply-To: <3EDC8DC0.7090009@xss.co.at>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Andreas Haumer wrote:
[...]
> *) Hyperthreading "disabled"
> *) MPS 1.4 Support "disabled"
> *) BIOS Update "disabled"
> *) Plug & Play "yes" (this makes it even worse: linux crashes
>                eventually as it gets confused by IRQ setting)
>

I've found it:

It's BIOS setting "USB legacy support", which I had on
"Auto" (default setting).

As soon as I disable "USB legacy support", system time
is now in sync with wall clock time!

root@setup:~ {508} $ ntpdate ntp.xss.co.at; sleep 60; ntpdate ntp.xss.co.at
 3 Jun 14:35:32 ntpdate[1141]: adjust time server 194.152.162.17 offset 0.005909 sec
 3 Jun 14:36:32 ntpdate[1146]: adjust time server 194.152.162.17 offset -0.002158 sec

Uaaahhhhhhhh!!!!!

Linux also now reports an interesting error on bootup, which
isn't there when booting with "USB legacy support=Auto"

[...]
..MP-BIOS bug: 8254 timer not connected to IO-APIC
[...]

(This is 2.4.21-rc6-ac1 booting with "acpi=off")

What the hell does USB legacy support have to do with all this???
This is weird!

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+3JbkxJmyeGcXPhERAmzLAJ48RMa7o6Zn0Ko6YxFn4y5UVeGl+wCgwQwN
DSjZtxe4QDEL8I812fz2h1U=
=8zBV
-----END PGP SIGNATURE-----

