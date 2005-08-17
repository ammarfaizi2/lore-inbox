Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbVHQNUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVHQNUs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 09:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbVHQNUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 09:20:48 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:37980 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S1751121AbVHQNUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 09:20:48 -0400
Message-ID: <430339AA.2050007@suse.com>
Date: Wed, 17 Aug 2005 09:20:42 -0400
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: yhlu <yhlu.kernel@gmail.com>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       jerome lacoste <jerome.lacoste@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Marie-Helene Lacoste <manies@tele2.fr>
Subject: Re: 2.6.12.3 clock drifting twice too fast (amd64)
References: <5a2cf1f6050816031011590972@mail.gmail.com>	 <Pine.LNX.4.62.0508161103360.7101@schroedinger.engr.sgi.com>	 <430273F3.2000204@suse.com> <86802c4405081623483284908e@mail.gmail.com>
In-Reply-To: <86802c4405081623483284908e@mail.gmail.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/mixed;
 boundary="------------040708060704060802030604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040708060704060802030604
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

fyhlu wrote:
> Me too. If use latest kernel mouse is dead.
> 
> By the way, did you solve the battery problem in Linux. "Can not read
> battery status"

Yes. It's a problem with the DSDT. Install pmtools (for iasl - the acpi
compiler) and grab
ftp://ftp.suse.com/pub/people/jeffm/acpi/Acer_Ferrari_4000.DSDT.asl

You'll need to enable ACPI_CUSTOM_DSDT to do use it, or if you're on a
SUSE system (sorry, I don't know if/which other systems support this),
you can enable a new DSDT by including it in the init{rd,ramfs}. (See
the -a option to mkinitrd)

The attached script will turn your AML file into a character array for
use with ACPI_CUSTOM_DSDT.

There are other issues that need to be worked out in the DSDT, and since
I'm not an ACPI guru (or even anything beyond a casual observer), this
may take some time. Specifically, I get this ...
nsxfeval-0251 [06] acpi_evaluate_object  : Handle is NULL and Pathname
is relative
... for several paths, which a bit of debugging tells me is _PR[0-3]
from the root node. Unfortunately, there is no instance of _PR[0-3] in
the DSDT asl file.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFDAzmpLPWxlyuTD7IRAhupAJ9rAXNZAX3tzHxCzwYuPUE1LO/ivwCghvTT
8uaZtso9gnu9FGk8Imjk94k=
=Iesw
-----END PGP SIGNATURE-----

--------------040708060704060802030604
Content-Type: application/x-perl;
 name="file2string.pl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="file2string.pl"

#!/usr/bin/perl

my $i = 0;
my $vname = "file2string";

$vname = $ARGV[0] if ($#ARGV >= 0);

print "const char $vname" . "[] = {";

while (<STDIN>) {
	foreach (split //, $_) {
		if (($i++ % 12) == 0) {
			print "\n\t";
		}
		printf ("0x%02x, ", ord $_);
	}
}

print "\n};\n";

--------------040708060704060802030604--
