Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbVI3NUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbVI3NUc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 09:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbVI3NUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 09:20:32 -0400
Received: from fmr15.intel.com ([192.55.52.69]:27878 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030282AbVI3NUb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 09:20:31 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: em64t speedstep technology not supported in kernel yet?
Date: Fri, 30 Sep 2005 06:20:15 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6005DECA9D@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: em64t speedstep technology not supported in kernel yet?
Thread-Index: AcXFv5DssjASZp6kTXuBNe4fKUDjYgAARIQA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Dave Jones" <davej@redhat.com>
Cc: "Wes Felter" <wesley@felter.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Sep 2005 13:20:16.0554 (UTC) FILETIME=[B29730A0:01C5C5C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>-----Original Message-----
>From: Dave Jones [mailto:davej@redhat.com] 
>Sent: Friday, September 30, 2005 6:05 AM
>To: Pallipadi, Venkatesh
>Cc: Wes Felter; linux-kernel@vger.kernel.org
>Subject: Re: em64t speedstep technology not supported in kernel yet?
>
>On Fri, Sep 30, 2005 at 05:20:03AM -0700, Pallipadi, Venkatesh wrote:
> > 
> > >-----Original Message-----
> > >From: linux-kernel-owner@vger.kernel.org 
> > >[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Wes Felter
> > >Sent: Thursday, September 29, 2005 11:58 AM
> > >To: linux-kernel@vger.kernel.org
> > >Subject: Re: em64t speedstep technology not supported in 
>kernel yet?
> > >
> > >Richard Wohlstadter wrote:
> > >> Hello all,
> > >> 
> > >> We recently had Intel give our company a roadmap 
> > >presentation where they 
> > >> told us that their enhanced speedstep technology was 
> > >supported by linux 
> > >> kernels 2.6.9+.  I have since tried to get cpufreq speedstep 
> > >driver to 
> > >> work with no luck on our em64t Xeon 3.6g processors.  Intel 
> > >even has a 
> > >> webpage describing the technology and how to get it 
>working at url: 
> > >> 
>http://www.intel.com/cd/ids/developer/asmo-na/eng/195910.htm?prn=Y
> > >
> > >I think this is a BIOS problem; the BIOS needs to provide 
>the proper 
> > >ACPI frequency/voltage tables for cpufreq to use. You 
>might want to 
> > >harass your system/motherboard vendor.
> > >
> > >Alternately maybe you can find someone who can give you the 
> > >secret table and then you can just hardcode it into the driver.
> > 
> > Yes. Make sure speedstep is  supported and enabled in BIOS. 
>Typically,
> > there will be a BIOS config option under CPU section, 
>called Speedstep, 
> > Enhanced Speedstep or EIST or something like that. 
>
>The BIOS tables make no difference at all however to the 
>speedstep-centrino
>module  (which in retrospect really should have been 
>speedstep-est or something)
>as it has no OP() tables or cpu recognition for Xeons.
>
>		Dave

Actually, speedstep-centrino works in two modes. One OP() 
table based mode and the other ACPI table based mode. So, 
BIOS ACPI tables do matter for the second mode and things 
work without a static OP table.

Also, OP() table based modes is not really scalable as one 
has to enter new tabled for every new model and also not 
complete as it cannot take ACPI events (say different 
P-states for battery or AC on laptop, which may not matter 
that much for Xeon...). That's the reason we want to have 
ACPI/BIOS based speedstep as much as possible. Of course 
there will always be broken BIOSes which we have 
to workaround....

In this particular case though, for Xeon with Enhanced Speedstep, 
acpi-cpufreq should be the driver of choice as there is a need 
for coordination of HT siblings, which happen in BIOS at the 
moment with most BIOSes. That is the reason, I want to make 
sure BIOS supports Enhanced Speedstep in this case.

Thanks,
Venki
