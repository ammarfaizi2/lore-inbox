Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbULMUcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbULMUcO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 15:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbULMUbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 15:31:09 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:6278 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262351AbULMUW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 15:22:58 -0500
Message-Id: <200412132022.iBDKMkIR031878@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Thomas Bettler <bettlert@student.ethz.ch>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cpufreq: shouldn't scaling_min_freq be lower? 
In-Reply-To: Your message of "Mon, 06 Dec 2004 13:34:47 GMT."
             <1102340086.13485.31.camel@localhost.localdomain> 
From: Valdis.Kletnieks@vt.edu
References: <200412052306.07460.bettlert@student.ethz.ch> <E1Cb5lT-0007vk-00@chiark.greenend.org.uk> <200412060029.49366.bettlert@student.ethz.ch>
            <1102340086.13485.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_379611842P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 13 Dec 2004 15:22:46 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_379611842P
Content-Type: text/plain; charset=us-ascii

On Mon, 06 Dec 2004 13:34:47 GMT, Alan Cox said:
> On Sul, 2004-12-05 at 23:29, Thomas Bettler wrote:
> > > Windows tends to use a combination of CPU scaling and throttling to get
> > > the processor that slow. Take a look at
> > > /proc/acpi/processor/*/throttling
> > 
> > Is there a throttle daemon for Linux? It would be great to use this.
> 
> There are a few. cpuspeed for example

Sorry for the late follow-up.  The 'cpuspeed' shipped by Fedora Core as
part of kernel-utils doesn't seem to understand throttling, it only does
frequency stepping.  So although I *have*:

[/proc/acpi/processor/CPU0]2 cat power 
active state:            C2
default state:           C1
bus master activity:     00000000
states:
    C1:                  promotion[C2] demotion[--] latency[000] usage[00000010]
   *C2:                  promotion[--] demotion[C1] latency[050] usage[03754116]
    C3:                  <not supported>
[/proc/acpi/processor/CPU0]2 cat throttling 
state count:             8
active state:            T0
states:
   *T0:                  00%
    T1:                  12%
    T2:                  25%
    T3:                  37%
    T4:                  50%
    T5:                  62%
    T6:                  75%
    T7:                  87%

I can basically only tell the CPU to go at 1.2Ghz or 1.6Ghz.

Right now, I use:
cpuspeed -d -p 10 50 -t /proc/acpi/thermal_zone/THM/temperature 85 -a /proc/acpi/ac_adapter/AC/state
which is *almost* OK, thought if further power savings were to be obtained by
dropping it to somewhere in the T5-T7 range if we're at low speed and *still*
not using much CPU, that would be nice (modulo the usual considerations about
latency for T5->T0 transitions for a "Intel(R) Pentium(R) 4 Mobile CPU 1.60GHz"-
I realize other chipsets will have other latencies..)


--==_Exmh_379611842P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBvfoVcC3lWbTT17ARArl8AJ9E9dWJ2MWLZO+ggLiq8yTjx9HwHwCgo8k6
e34cQedWgddgEzqp4T5FP9g=
=M9mQ
-----END PGP SIGNATURE-----

--==_Exmh_379611842P--
