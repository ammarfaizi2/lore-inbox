Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933064AbWFZVYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933064AbWFZVYo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 17:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933063AbWFZVYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 17:24:43 -0400
Received: from ccerelbas02.cce.hp.com ([161.114.21.105]:52198 "EHLO
	ccerelbas02.cce.hp.com") by vger.kernel.org with ESMTP
	id S933053AbWFZVYm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 17:24:42 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Fastboot] [RFC] [PATCH 2/2] kdump: cciss driver initialization issue fix
Date: Mon, 26 Jun 2006 16:24:41 -0500
Message-ID: <E717642AF17E744CA95C070CA815AE550E17E1@cceexc23.americas.cpqcorp.net>
In-Reply-To: <m1veqnrae7.fsf@ebiederm.dsl.xmission.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Fastboot] [RFC] [PATCH 2/2] kdump: cciss driver initialization issue fix
Thread-Index: AcaZVbprHIukD8gCTjy30bCUIenKyQAAEEwA
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: <vgoyal@in.ibm.com>, "Maneesh Soni" <maneesh@in.ibm.com>,
       "Andrew Morton" <akpm@osdl.org>, <Neela.Kolli@engenio.com>,
       <linux-scsi@vger.kernel.org>, <fastboot@lists.osdl.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Jun 2006 21:24:42.0077 (UTC) FILETIME=[F01CC8D0:01C69966]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Eric W. Biederman [mailto:ebiederm@xmission.com] 
> Sent: Monday, June 26, 2006 2:21 PM
> To: Miller, Mike (OS Dev)
> Cc: vgoyal@in.ibm.com; Maneesh Soni; Andrew Morton; 
> Neela.Kolli@engenio.com; linux-scsi@vger.kernel.org; 
> fastboot@lists.osdl.org; linux-kernel@vger.kernel.org
> Subject: Re: [Fastboot] [RFC] [PATCH 2/2] kdump: cciss driver 
> initialization issue fix
> 
> >> "Miller, Mike (OS Dev)" <Mike.Miller@hp.com> writes:
> >> 
> >> > Thanks Eric, that helps me understand. Section 8.2.2 of the
> >> open cciss
> >> > spec supports a reset message. Target 0x00 is the
> >> controller. We could
> >> > add this to the init routine to ensure the board is made 
> sane again 
> >> > but this would drastically increase init time under normal
> >> circumstances.
> >> 
> >> Where does the init time penalty come from? How large is the init 
> >> penalty?  I suspect it is from waiting for the scsi disks 
> to spin up.
> >> But I am just guessing in the dark.
> >
> > The penalty is in the firmware and self-test operations.
> 
> Ok.  Reasonable. Roughly long does that take? 1 millisecond? 1 second?
> 1 minute? 1 hour? 

Sorry, roughly 30 to 40 seconds. Maybe longer if the controller thinks
there's something wrong with the disks. Typically the disks are always
spinning so that delay is not an issue.

> 
> >> > And I suspect this is a hard reset, also. Not sure if that would 
> >> > negatively impact kdump. If there were some condition we 
> could test 
> >> > against and perform the reset when that condition is met it
> >> would not
> >> > impact 99.9% of users.
> >> 
> >> I am wondering if it is possible to look at the controller 
> and see if 
> >> it is in a bad state, (i.e. in some state besides just 
> coming out of 
> >> reset) and if so issue a reset.  If this really is a long 
> operation 
> >> that would be the ideal way to handle it.
> >
> > It's not really in a bad state at this time, is it? Maybe some 
> > commands hanging around.
> 
> Not bad as in broken.  But bad as in unexpected.  If it is 
> just a matter of outstanding commands we might even be able 
> to just ask the adapter to cancel all of the at initialization time.

We can't detect unexpected but we can discard everything at init.

> >
> > I was informed of the crashboot command line parameter. I can 
> > implement that as a test.
> 
> Sounds like a start.
> 
> >> Although it might simply be appropriate to handle commands 
> completing 
> >> you didn't start.  I am not at all familiar with that particular 
> >> piece of hardware so I can't make a good guess on what needs to 
> >> happen there.
> >
> > Not sure about doing this.
> 
> Well I would certainly print a warning.
> 
> Eric
> 
> 
