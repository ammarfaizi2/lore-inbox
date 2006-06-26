Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWFZQw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWFZQw6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWFZQwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:52:33 -0400
Received: from ccerelbas02.cce.hp.com ([161.114.21.105]:21738 "EHLO
	ccerelbas02.cce.hp.com") by vger.kernel.org with ESMTP
	id S1750860AbWFZQwA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:52:00 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Fastboot] [RFC] [PATCH 2/2] kdump: cciss driver initialization issue fix
Date: Mon, 26 Jun 2006 11:51:52 -0500
Message-ID: <E717642AF17E744CA95C070CA815AE550E1555@cceexc23.americas.cpqcorp.net>
In-Reply-To: <m1lkrjub2m.fsf@ebiederm.dsl.xmission.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Fastboot] [RFC] [PATCH 2/2] kdump: cciss driver initialization issue fix
Thread-Index: AcaZPvfm5+G/Lt2WQKmIjkpcjo6+6AAAL7YQ
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: <vgoyal@in.ibm.com>, "Maneesh Soni" <maneesh@in.ibm.com>,
       "Andrew Morton" <akpm@osdl.org>, <Neela.Kolli@engenio.com>,
       <linux-scsi@vger.kernel.org>, <fastboot@lists.osdl.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Jun 2006 16:51:53.0201 (UTC) FILETIME=[D3808610:01C69940]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: Eric W. Biederman [mailto:ebiederm@xmission.com] 
> Sent: Monday, June 26, 2006 11:38 AM
> To: Miller, Mike (OS Dev)
> Cc: vgoyal@in.ibm.com; Maneesh Soni; Andrew Morton; 
> Neela.Kolli@engenio.com; linux-scsi@vger.kernel.org; 
> fastboot@lists.osdl.org; linux-kernel@vger.kernel.org
> Subject: Re: [Fastboot] [RFC] [PATCH 2/2] kdump: cciss driver 
> initialization issue fix
> 
> "Miller, Mike (OS Dev)" <Mike.Miller@hp.com> writes:
> 
> > All,
> > Sorry to come in late and top post. I've been out of the office and 
> > I'm trying to get to the gist of this issue.
> > Exactly what is the problem? I'm not familiar with kdump so I don't 
> > have a clue about what's going on.
> > There are a couple of reset features supported by _some_ cciss 
> > controllers. I'd have to go back to the open spec to see 
> whats in the 
> > public domain. We're trying to get the open spec updated and more 
> > complete but we're waiting on the lawyers. :(
> 
> 
> kdump or taking crash dumps using the kexec on panic 
> mechanism could be called a drivers worst nightmare.  In the 
> latest distros this is becoming the way crash dump style 
> information is captured.
> 
> Because the initial kernel is broken we do a jump into 
> another kernel that is sufficient to record a crash dump.  
> That second kernel initializes the hardware from whatever 
> random state the first kernel left the drivers in.  That 
> first kernel is not permitted to do any device shutdown activities.
> 
> The problem is that a command the running instance of the 
> driver did not initiate completes.  At least if I read Vivek 
> patch 2/2 correctly.
> 
> So we have three options.
> - reset the card during initialization.
> - handle the case of a command we did not initiate completing.
> - mark the driver/card as impossibly hopeless for use in a crash
>   dump scenario.
> 
> 
> Eric

Thanks Eric, that helps me understand. Section 8.2.2 of the open cciss
spec supports a reset message. Target 0x00 is the controller. We could
add this to the init routine to ensure the board is made sane again but
this would drastically increase init time under normal circumstances.
And I suspect this is a hard reset, also. Not sure if that would
negatively impact kdump. If there were some condition we could test
against and perform the reset when that condition is met it would not
impact 99.9% of users.

Thoughts, comments, flames?

mikem
