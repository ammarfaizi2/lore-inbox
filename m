Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289064AbSAGArM>; Sun, 6 Jan 2002 19:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289063AbSAGArC>; Sun, 6 Jan 2002 19:47:02 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:64523 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S289062AbSAGAqt>; Sun, 6 Jan 2002 19:46:49 -0500
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: [2.4.17/18pre] VM and swap - it's really unusable
Date: Sun, 6 Jan 2002 16:47:05 -0800
Message-ID: <HBEHIIBBKKNOBLMPKCBBGEHLEFAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <E16NJ7R-0006Iq-00@the-village.bc.nu>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're right ... no one does an *out-of-core* 2D FFT using VM. What I am
saying is that a large page cache can turn an *in-core* 2D FFT -- a 4 GB
case on an 8 GB machine, for example -- into an out-of-core one!

One other data point: on my stock Red Hat 7.2 box with 512 MB of RAM, I ran
a Perl script that builds a 512 MByte hash, a second Perl script which
creates a 512 MByte disk file, and the check pass of FFTW concurrently. As I
expected, the two Perl scripts competed for RAM and slowed down FFTW. What
was even more interesting, though, was that the VM apparently functions
correctly in this instance. All three of the processes were getting CPU
cycles. And I never saw "kswapd" or "kupdated" take over the system.

Although the page cache did get large at one point, once the hash builder
got to about 400 MBytes in size, the "cached" piece shrunk to about 10
MBytes and most of the RAM got allocated to the hash builder, as did
appropriate amounts of swap. In short, the kernel in Red Hat 7.2 with under
1 GByte of memory is behaving well under memory pressure. It looks like it's
kernels beyond that one that have the problems, and also systems with more
than 1 GByte. If I had the money, I'd stuff some more RAM in the machine and
see if I could isolate this a little further. If anyone wants my Perl
scripts, which are trivial, let me know.
--
M. Edward Borasky
znmeb@borasky-research.net
http://www.borasky-research.net

