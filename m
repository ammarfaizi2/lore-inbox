Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268423AbTGIQrL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 12:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266068AbTGIQrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 12:47:11 -0400
Received: from fmr04.intel.com ([143.183.121.6]:55017 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S268423AbTGIQqy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 12:46:54 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] idle using PNI monitor/mwait
Date: Wed, 9 Jul 2003 10:01:27 -0700
Message-ID: <DC675A50D067E045B80AAEDCBD2648BD02B02E28@fmsmsx408.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] idle using PNI monitor/mwait
Thread-Index: AcNFqX3qi1nwW1fkQe2bDmwduQI3HQABEMPQACMeP6A=
From: "Mallick, Asit K" <asit.k.mallick@intel.com>
To: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Linus Torvalds" <torvalds@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
X-OriginalArrivalTime: 09 Jul 2003 17:01:28.0300 (UTC) FILETIME=[BCEA6AC0:01C3463B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

We are analyzing the performance of use of mwait in contention codes. We
do not have all the data yet and will let you know the benefit of use of
mwait in contention code.
Thanks,
Asit


> -----Original Message-----
> From: Nakajima, Jun 
> Sent: Tuesday, July 08, 2003 5:36 PM
> To: 'Linus Torvalds'
> Cc: linux-kernel@vger.kernel.org; Saxena, Sunil; Mallick, 
> Asit K; Pallipadi, Venkatesh
> Subject: RE: [PATCH] idle using PNI monitor/mwait
> 
> 
> That's right. If we have a lot of high-contention locks in 
> the kernel, we need to fix the code first, to get benefits 
> for the other architectures. 
> 
> "mwait" granularity (64-byte, for example) is given by the 
> cpuid instruction, and we did not use it because 1) it's 
> unlikely that the other fields of the task structure are 
> modified when it's idle, 2) the processor needs to check the 
> flag after mwait anyway, to avoid waking up with a false 
> signal caused by other break events (i.e. mwait is a hint).
> 
> Jun
> 
> > -----Original Message-----
> > From: Linus Torvalds [mailto:torvalds@osdl.org]
> > Sent: Tuesday, July 08, 2003 4:34 PM
> > To: Nakajima, Jun
> > Cc: linux-kernel@vger.kernel.org; Saxena, Sunil; Mallick, Asit K;
> > Pallipadi, Venkatesh
> > Subject: Re: [PATCH] idle using PNI monitor/mwait
> > 
> > 
> > On Tue, 8 Jul 2003, Nakajima, Jun wrote:
> > >
> > > Attached is a patch that enables PNI (Prescott New Instructions)
> > > monitor/mwait in kernel idle (opcodes are now public). 
> Basically MWAIT
> > > is similar to hlt, but you can avoid IPI to wake up the processor
> > > waiting. A write (by another processor) to the address 
> range specified
> > > by MONITOR would wake up the processor waiting on MWAIT.
> > 
> > How about spinlocks? Does it make sense to make the 
> contention code use
> > mwait too, or are the latencies too high? Not that we have a lot of
> > high-contention locks any more, so maybe it doesn't much matter.
> > 
> > Also, wasn't there some flag to set the "mwait" 
> granularity? I don't see
> > anything like that in the patch..
> > 
> > 		Linus
> 
> 
