Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbVJVSkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbVJVSkj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 14:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbVJVSkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 14:40:39 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:33934 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751178AbVJVSki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 14:40:38 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Vladimir Lazarenko <vlad@lazarenko.net>
Subject: Re: sata_nv + SMP = broken?
Date: Sat, 22 Oct 2005 20:40:52 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Marc Perkel <marc@perkel.com>,
       Jeff Garzik <jgarzik@pobox.com>
References: <4358C417.9000608@lazarenko.net> <200510212238.25614.rjw@sisk.pl> <435A032C.7070302@lazarenko.net>
In-Reply-To: <435A032C.7070302@lazarenko.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510222040.53500.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday, 22 of October 2005 11:15, Vladimir Lazarenko wrote:
> >>>Yesterday I've tried launching various kernels on Ahtlon64 Dual-core 
> >>>X2 3800+ with MSI Neo4 Platinum SLI motherboard.
> >>>
> >>>The results were a total catastrophica failure. As soon as I enable 
> >>>SMP in the kernel, the sata driver would randomly hang after a bit of 
> >>>disk activity.
> >>>
> >>>Whenever apic is enabled, the system won't even be able to boot up 
> >>>completely, and will hang VERY soon. Whenever I disable apic, the 
> >>>system is able to bootup, but when the software mirror that I use will 
> >>>try to resync for 2-3-10 mins, it will throw up a message and freeze 
> >>>again.
> >>>
> >>>Whenever I disable apic AND lapic, the system is able to bootup AND 
> >>>work, however after same 5-10 minutes it start spitting messages, 
> >>>which are somewhat different thou and don't hang the system completely 
> >>>but render it rather unusable anyway.
> >>>
> >>>As soon as I disable SMP - everything works like a charm.
> >>>
> >>I too am running an Athlon X2 using sata_nv. I have an ASUS motherboard. 
> >>But what I noticed was that the problem went away if I used 2 gigs of 
> >>ram instead of 4 gigs. When you use the whole 4 gigs there is some 
> >>memory mapping going on and I thought perhaps the problem was related to 
> >>the sata_nv not liking the memory mapped over the 4gig barrier.
> > 
> > That's possible.  Unfortunately I cannot verify this, since there are 2GB of
> > RAM in my box.
> > 
> > I remeber someone having a problem with sata_nv DMAing over 2GB of RAM,
> > so there may be something wrong with it.
> 
> On a second thought. Why would that only occur in SMP mode? Since now 
> the box is with 3G ram, no SMP and it works like a charm. If I enable 
> SMP - the hell breaks loose.

It looks like an obscure issue.  Apparently, to trigger it you need _both_
more that 2GB of RAM and SMP.

OTOH, today I played with Tyan Thunder K8WE, based on the Nvidia
CK8-04 chipset (not that much different to the regular Nforce4) in
a 2-processor configuration and 8GB of RAM, and it had no issues at all
(I installed SuSE 9.3 with the distro kernel on it).  Anyway its SATA
controller is handled by the sata_nv driver, so the problem you describe
does not seem to be software-related.

I guess it's a hardware problem with the single-processor Nforce4 chipset
and a dual-core CPU.  Still I have no idea what exactly it may be.

[Jeff, could you please say if this is a known problem?]

Greetings,
Rafael
