Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292389AbSBPPeW>; Sat, 16 Feb 2002 10:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292383AbSBPPeD>; Sat, 16 Feb 2002 10:34:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41732 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292392AbSBPPd4>;
	Sat, 16 Feb 2002 10:33:56 -0500
Message-ID: <3C6E7BE1.8F1769F7@mandrakesoft.com>
Date: Sat, 16 Feb 2002 10:33:53 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: CML2 feedback (was Re: Disgusted with kbuild developers)
In-Reply-To: <20020215135557.B10961@thyrsus.com><200202151929.g1FJTaU03362@pc1-camc5-0-cust78.cam.cable.ntl.com><20020215141433.B11369@thyrsus.com><20020215195818.A3534@pc1-camc5-0-cust78.cam.cable.ntl.com><20020215145421.A12540@thyrsus.com><20020215124255.F28735@work.bitmover.com><20020215153953.D12540@thyrsus.com> <1013811711.807.1066.camel@phantasy> <OE193Qime2yO9QJsWhz00006b54@hotmail.com> <3C6DE7DC.59A92A6D@mandrakesoft.com> <20020216095039.L23546@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> What problems do you have with CML1?  Name them and I will make sure
> they are not issues in CML2.
> 
> I've been begging for feedback for many months.  Pleases *get specific*.
> Instead of muttering that Eric refuses to listen, *give me something
> to listen to*!

(cc'ing Linus)

1) Remove global dependencies.
> source "arch/um/rules.cml"
> source "arch/i386/rules.cml"
> source "arch/alpha/rules.cml"
> source "arch/sparc/rules.cml"
[...]

All symbols should not be included on every config run.  The
architectures currently create their own master rules file, which then
selectively includes other config files.  You break this and remove
control (and flexibility) by enforcing something globally which was
previously done on a per-arch basis.


2) As discussed in December (as well as before and after that thread),
the --eventual-- direction to go is that a single file will contain all
meta information about a driver or set of drivers.  Config.help entries,
Config.in entries, Makefile rules, etc.  The idea is to group
information about a particular object in the same location.  So,
considering (a) that Config.help now exists and (b) this eventual
direction, splitting up rules and symbols into completely separate files
is not the greatest idea... when we eventually want to integrate rules
and symbols.


Take a look at what we find in Donald Becker's virgin source tree, in
winbond-840.c:
> /* Automatically extracted configuration info:
> probe-func: winbond840_probe
> config-in: tristate 'Winbond W89c840 Ethernet support' CONFIG_WINBOND_840
> 
> c-help-name: Winbond W89c840 PCI Ethernet support
> c-help-symbol: CONFIG_WINBOND_840
> c-help: The winbond-840.c driver is for the Winbond W89c840 chip.
> c-help: This chip is named TX9882 on the Compex RL100-ATX board.
> c-help: More specific information and updates are available from 
> c-help: http://www.scyld.com/network/drivers.html
> */

All the information is in one location.  Now, Linus said not to embed
this information in the source, but put it in a metadata file.  But
other than that, this is a small and simple example of what the metadata
config files might eventually look like.


So, my own personal opinion is that CML2 should follow these suggestions
:)

Regards,

	Jeff



-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
