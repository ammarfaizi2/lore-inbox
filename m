Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133099AbRECT6q>; Thu, 3 May 2001 15:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133097AbRECT6b>; Thu, 3 May 2001 15:58:31 -0400
Received: from pyongsan.compgen.com ([158.155.0.1]:54540 "EHLO
	panmunjom.compgen.com") by vger.kernel.org with ESMTP
	id <S133095AbRECT6J>; Thu, 3 May 2001 15:58:09 -0400
From: "Eric Z. Ayers" <Eric.Ayers@intec-telecom-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15089.47157.268005.262050@gargle.gargle.HOWL>
Date: Thu, 3 May 2001 15:57:41 -0400 (EDT)
To: Pavel Machek <pavel@suse.cz>
Cc: Doug Ledford <dledford@redhat.com>,
        Max TenEyck Woodbury <mtew@cds.duke.edu>,
        Eric.Ayers@intec-telecom-systems.com,
        James Bottomley <James.Bottomley@steeleye.com>,
        "Roets, Chris" <Chris.Roets@compaq.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: Linux Cluster using shared scsi
In-Reply-To: <20010502230357.A9507@bug.ucw.cz>
In-Reply-To: <200105011445.KAA01117@localhost.localdomain>
	<3AEEDFFC.409D8271@redhat.com>
	<15086.60620.745722.345084@gargle.gargle.HOWL>
	<3AF025AE.511064F3@redhat.com>
	<3AF04648.73F5BFCE@cds.duke.edu>
	<3AF0483C.49C8CF90@redhat.com>
	<20010502230357.A9507@bug.ucw.cz>
X-Mailer: VM 6.72 under 21.1 (patch 8) "Bryce Canyon" XEmacs Lucid
Reply-To: Eric.Ayers@intec-telecom-systems.com
X-Face: (3Y\Z;G!Ce[Q\WBgGFLgcaL%v[kJ'@9s`Qn1<)EEL5tSW7IDvX[{APQ5]eY}uF}%qbD[-@N
 !5]S!%o0*DbAB?~o%tca^?3@zU~"fQ@MTiClP>w%`Y8oG&6|:>2F=bhnf2>bPedqw-.T>U-BaI`F>1
 QY@?oGJ0.lV?b@0HgvaOt>=0,/@,=(kE"J++vO?K"3ve@,"sunF0HnU|h&|:}%|P6%BohO_*mAHJ#g
 EHc;_'bXG|kCLMSF`:/O_F0fuJ:j2^C\NJ(:$izN@mbXQo(IL,<P@2U+(Z`@>BO.7<]wT?:5.A<$C
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek writes:
 > Hi!
 > 
 > > > > ...
 > > > >
 > > > > If told to hold a reservation, then resend your reservation request once every
 > > > > 2 seconds (this actually has very minimal CPU/BUS usage and isn't as big a
 > > > > deal as requesting a reservation every 2 seconds might sound).  The first time
 > > > > the reservation is refused, consider the reservation stolen by another machine
 > > > > and exit (or optionally, reboot).
 > > > 
 > > > Umm. Reboot? What do you think this is? Windoze?
 > > 
 > > It's the *only* way to guarantee that the drive is never touched by more than
 > > one machine at a time (notice, I've not been talking about a shared use drive,
 > > only one machine in the cluster "owns" the drive at a time, and it isn't for
 > > single transactions that it owns the drive, it owns the drive for as long as
 > > it is alive, this is a limitation of the filesystes currently available in
 > > mainstream kernels).  The reservation conflict and subsequent reboot also
 > > *only* happens when a reservation has been forcefully stolen from a
 > >machine. 
 > 
 > I do not believe reboot from kernel is right approach. Tell init with
 > special signal, maybe; but do not reboot forcefully. This is policy;
 > doing reboot might be right answer in 90% cases; that does not mean
 > you should do it always.
...

However distateful it sounds, there is precedent for the
behavior that Doug is proposing in commercial clustering
implementations.  My recollection is that both Compaq TruCluster and
HP Service Guard have logic that will panic the kernel when a disk is
"stolen" from under a running service and there is a "network
partition" in the cluster.

A network partition occurs when multiple machines in the cluster are
runnig, but the HA software agents on two nodes can't communicate via
the network to arbitrate which node should be the owner of the disk. 

-Eric
--
Eric Z. Ayers				              Lead Software Engineer
Phone:  +1 404-705-2864                    Computer Generation, Incorporated
Fax:    +1 404-705-2805                     an Intec Telecom Systems Company
Web:    http://www.intec-telecom-systems.com/
Email:  eric.ayers@intec-telecom-systems.com
Postal: Bldg G 4th Floor, 5775 Peachtree-Dunwoody Rd, Atlanta, GA 30342 USA
