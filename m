Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTLLW5p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 17:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbTLLW5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 17:57:45 -0500
Received: from fmr06.intel.com ([134.134.136.7]:28568 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262591AbTLLW5m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 17:57:42 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: more dbt-2 results hyperthreading on linux-2.6.0-test11
Date: Fri, 12 Dec 2003 14:56:46 -0800
Message-ID: <7F740D512C7C1046AB53446D372001736187A9@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: more dbt-2 results hyperthreading on linux-2.6.0-test11
Thread-Index: AcPA/8lW6YQCivatQT+YK3xfK+XnjQAAeWTg
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: <markw@osdl.org>, <piggin@cyberone.com.au>
Cc: <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
       <pgsql-hackers@postgresql.org>
X-OriginalArrivalTime: 12 Dec 2003 22:56:47.0427 (UTC) FILETIME=[388C0930:01C3C103]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not familiar with this particular workload, but noticed higher idle
and wait time with HT enabled, compared to HT-disabled case. This kind
of symptom often indicated insufficient I/O bandwidth from my
experience, and faster systems (with more threads) tend to show lower
throughput because you end up measuring disk seek time of more I/O
requests. Can you add more disk controller(s) and disks?

Jun
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of markw@osdl.org
> Sent: Friday, December 12, 2003 2:28 PM
> To: piggin@cyberone.com.au
> Cc: mingo@redhat.com; linux-kernel@vger.kernel.org; pgsql-
> hackers@postgresql.org
> Subject: more dbt-2 results hyperthreading on linux-2.6.0-test11
> 
> Hi Nick,
> 
> Here are the results of the comparisons I said I would do.
> 
> no-hyperthreading:
> 	http://developer.osdl.org/markw/dbt2-pgsql/282/
> 	- metric 2288.43
> 	- baseline
> 
> hyperthreading:
> 	http://developer.osdl.org/markw/dbt2-pgsql/278/
> 	- metric 1944.42
> 	- 15% throughput decrease
> 
> hyperthreading w/ Ingo's C1 patch:
> 	http://developer.osdl.org/markw/dbt2-pgsql/277/
> 	- metric 1978.39
> 	- 13.5% throughput decrease
> 
> hyperthreading w/ Nick's w26 patch:
> 	http://developer.osdl.org/markw/dbt2-pgsql/274/
> 	- metric 1955.91
> 	- 14.5% throughput decrease
> 
> It looks like there is some marginal benefit to your or Ingo's patches
> with a workload like DBT-2.  I probably don't understand enough about
> hyperthreading, but I wonder if there's something PostgreSQL can do to
> take advantage of hyperthreading
> 
> Anyway, each link has pointers to readprofile and annotated oprofile
> assembly output (if you find that useful.)  I haven't done enough
tests
> to have an idea of the error margin, but I wouldn't be surprised if
it's
> at least 1%.
> 
> Let me know if there's anything else you'd like me to try.
> 
> Thanks,
> Mark
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
