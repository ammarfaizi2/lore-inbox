Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268097AbTCAC52>; Fri, 28 Feb 2003 21:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268212AbTCAC52>; Fri, 28 Feb 2003 21:57:28 -0500
Received: from fmr02.intel.com ([192.55.52.25]:4301 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S268097AbTCAC51> convert rfc822-to-8bit; Fri, 28 Feb 2003 21:57:27 -0500
content-class: urn:content-classes:message
Subject: RE: [BUG] 2.5.63: ESR killed my box!
Date: Fri, 28 Feb 2003 19:07:44 -0800
Message-ID: <DC675A50D067E045B80AAEDCBD2648BD2F2C3E@fmsmsx408.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG] 2.5.63: ESR killed my box!
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcLeURVl/AucJyFTSoG5Ora7YzHpRwBCtTvQABCgV/A=
From: "Mallick, Asit K" <asit.k.mallick@intel.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "William Lee Irwin III" <wli@holomorphy.com>,
       "Rusty Russell" <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <mingo@redhat.com>, "Mikael Pettersson" <mikpe@csd.uu.se>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
X-OriginalArrivalTime: 01 Mar 2003 03:07:45.0232 (UTC) FILETIME=[BB247D00:01C2DF9F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I want to correct the cumulative part:

> 
> It is the real value. Error interrupt is generated when any 
> bit is set in the real value (error bits) and does not use 
> visible ESR. However, the ESR (latch) bits are cumulative and 
> if the ESR is not cleared (using 2 writes) when we handle the 
> interrupt the read of ESR status will also contain the errors 
> for the previous error. So, the interrupt handler also should 
> use the clear and read current state as you mentioned.

The error interrupt is generated based on the real error bits and
readable ESR bits does not affect the interrupt generation (did verify
with the architects). We need the back-to-back write only to make the
readable ESR to get 0 on a read. So, the interrupt handler should be
able to use the write to ESR and read of ESR to get the current error
status.

Thanks,
Asit

