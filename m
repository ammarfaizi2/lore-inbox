Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbTLLXcy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 18:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbTLLXcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 18:32:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:27881 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262719AbTLLXcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 18:32:51 -0500
Message-Id: <200312122332.hBCNWWZ08245@mail.osdl.org>
Date: Fri, 12 Dec 2003 15:32:29 -0800 (PST)
From: markw@osdl.org
Subject: Re: more dbt-2 results hyperthreading on linux-2.6.0-test11
To: jun.nakajima@intel.com
cc: piggin@cyberone.com.au, mingo@redhat.com, linux-kernel@vger.kernel.org,
       pgsql-hackers@postgresql.org
In-Reply-To: <7F740D512C7C1046AB53446D372001736187A9@scsmsx402.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jun,

DBT-2 is a fair use implementation of the TPC-C (OLTP), if you're
familiar with that.

I have 14 drives attached through 1 megaraid raid controller, and 52
drives connected through 4 channels on 2 mylex raid controllers, all in
a raid-0 configuration.  I am using LVM2 on both sets of drives.

iostat tells me that each of the 14 drives attached through the raid
controller are utilized < 2%, while each of the other 52 drives seem to
peak at about 48% in one of the hyperthreaded cases (274).  I'm not too
familiar with the umpteen other columns that iostat reports, but that
suggests to me I have a fair amount of i/o headroom. Unfortunitely, I
don't believe I can get my hands on any addition drives or
controllers...

Mark


On 12 Dec, Nakajima, Jun wrote:
> I'm not familiar with this particular workload, but noticed higher idle
> and wait time with HT enabled, compared to HT-disabled case. This kind
> of symptom often indicated insufficient I/O bandwidth from my
> experience, and faster systems (with more threads) tend to show lower
> throughput because you end up measuring disk seek time of more I/O
> requests. Can you add more disk controller(s) and disks?
> 
> Jun
>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>> owner@vger.kernel.org] On Behalf Of markw@osdl.org
>> Sent: Friday, December 12, 2003 2:28 PM
>> To: piggin@cyberone.com.au
>> Cc: mingo@redhat.com; linux-kernel@vger.kernel.org; pgsql-
>> hackers@postgresql.org
>> Subject: more dbt-2 results hyperthreading on linux-2.6.0-test11
>> 
>> Hi Nick,
>> 
>> Here are the results of the comparisons I said I would do.
>> 
>> no-hyperthreading:
>> 	http://developer.osdl.org/markw/dbt2-pgsql/282/
>> 	- metric 2288.43
>> 	- baseline
>> 
>> hyperthreading:
>> 	http://developer.osdl.org/markw/dbt2-pgsql/278/
>> 	- metric 1944.42
>> 	- 15% throughput decrease
>> 
>> hyperthreading w/ Ingo's C1 patch:
>> 	http://developer.osdl.org/markw/dbt2-pgsql/277/
>> 	- metric 1978.39
>> 	- 13.5% throughput decrease
>> 
>> hyperthreading w/ Nick's w26 patch:
>> 	http://developer.osdl.org/markw/dbt2-pgsql/274/
>> 	- metric 1955.91
>> 	- 14.5% throughput decrease
>> 
>> It looks like there is some marginal benefit to your or Ingo's patches
>> with a workload like DBT-2.  I probably don't understand enough about
>> hyperthreading, but I wonder if there's something PostgreSQL can do to
>> take advantage of hyperthreading
>> 
>> Anyway, each link has pointers to readprofile and annotated oprofile
>> assembly output (if you find that useful.)  I haven't done enough
> tests
>> to have an idea of the error margin, but I wouldn't be surprised if
> it's
>> at least 1%.
>> 
>> Let me know if there's anything else you'd like me to try.
>> 
>> Thanks,
>> Mark

