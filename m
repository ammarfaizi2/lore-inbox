Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbTFJU1H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbTFJUZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:25:32 -0400
Received: from exchange-1.umflint.edu ([141.216.3.48]:5432 "EHLO
	Exchange-1.umflint.edu") by vger.kernel.org with ESMTP
	id S262427AbTFJUYO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 16:24:14 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Wrong number of cpus detected/reported
Date: Tue, 10 Jun 2003 16:35:01 -0400
Message-ID: <37885B2630DF0C4CA95EFB47B30985FB020EC148@exchange-1.umflint.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Wrong number of cpus detected/reported
Thread-Index: AcMvimoOj071YWouTKyORwhfqJR5EgABCRhA
From: "Lauro, John" <jlauro@umflint.edu>
To: <xyko_ig@ig.com.br>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As someone else mentioned, it is probably hyper threading.  Run 'top'
and see if you get per cpu stats.  If it is hyperthreading, you should
be able to disable it in the BIOS.

IMO, hyperthreading is evil on an SMP box.  The system doesn't know
that not all CPUs are not created equal, and so if you have 4 CPU
intensive processes, then you have a good chance that 2 of the
processes will run at a reduced rate on the same CPU and one (or 2)
CPUs stay mostly idle...  All my benchmarks gave lower performance
with hyperthreading enabled.  I forget the kernel version, but I think
it was 2.4.20, might have been 2.4.18.

On a single CPU box, hyperthreading is probably a plus. I wonder if
2.5 handles hyperthreading any better. 

> -----Original Message-----
> From: José Francisco Ribeiro Neto [mailto:xyko@ipiranga.com.br]
> Sent: Tuesday, June 10, 2003 2:51 PM
> To: linux-kernel@vger.kernel.org
> Subject: Wrong number of cpus detected/reported
> Importance: High
> 
> Hi,
> 
> first of all please apologize me because I didn't subscribe the
list. I
> really even don't know if this list is the appropriate place to have
my
> question discussed but I didn't found any better one.
> 
> I installed a RedHat 7.1 system on a 4 way 1.4 Gz Compaq DL580
server
> with kernel 2.4.2 and everything goes right. Because of some other
> prerequisite needs I had to upgrade the kernel to 2.4.9-34.
> 
> After the upgrade the system is reporting that the machine has 8 cpu
> instead of 4. I have been looking for some kind of information on
the
> Internet (www.google.com/linux) about that but I didn't have
success.
> 
> Does anybody can tell me if I will face some major problem and why
the
> system is detecting (or only reporting) the wrong number of cpus ?
There
> is anything that I can do to have my system detecting the right
number
> of cpus ?
> 
> Attached there are a tar.gz file containing :
> 
> nohup.out => standard output from make bzImage
> modules.out => standard output from make modules
> modules.err => standard error from make modules
> cpuinfo => /proc/cpuinfo
> 
> The kernel was compiled using the kernel.....-enterprise config from
> /usr/src/linux-2.4/configs (smp=yes, highmem=64M)
> 
> Thanks in advance.
