Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVFNBMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVFNBMJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 21:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVFNBMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 21:12:09 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:34310 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S261246AbVFNBMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 21:12:03 -0400
Message-ID: <42AE3C91.4090904@tuxrocks.com>
Date: Mon, 13 Jun 2005 20:10:25 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian Leber <christian@leber.de>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2/2] lzma support: lzma compressed kernel image
References: <20050607214128.GB2645@core.home> <20050612223150.GA26370@core.home>
In-Reply-To: <20050612223150.GA26370@core.home>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christian Leber wrote:
> Building the lzma tool cut and paste style:
> 
> mkdir build-lzma
> wget http://www.7-zip.org/dl/lzma417.tar.bz2
> tar xjf lzma417.tar.bz2
> cd SRC/7zip/Compress/LZMA_Alone/
> make
> cp lzma ../../../../../
> cd ../../../../../

Other than the coding style issues which need to be addressed, the
patches appear to work as advertised.  lzma reduced my kernel by
approximately 25%, so I'd say it looks promising.

I do have a gripe about the need for the external lzma program when
building the kernel.  gzip can reasonably be expected to be on people's
systems, but lzma is (currently, at least) rather obscure, and isn't
likely to be on very many systems.

I think one or more of the following ought to happen:
- - Modify the help text in the Kconfig option to show people how to
obtain, compile, and install lzma (and warn them they'll need to install
it).
- - Detect that the lzma application isn't present, and fall back to gzip
(with a warning) if lzma fails.
- - If we can embed the decompressor into the boot-time kernel, can't we
put a compressor into the kernel source, and avoid the need for the
external program?
- - ...

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCrjyRaI0dwg4A47wRAk3PAKCZiMzdEP1UefLN3ETO/c64zrjedACfaz+T
RSAM/qgCehDj2Gs6e03T3RY=
=oIaY
-----END PGP SIGNATURE-----
