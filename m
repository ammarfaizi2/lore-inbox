Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272716AbTG3Em6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 00:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272731AbTG3Em6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 00:42:58 -0400
Received: from dsl2.external.hp.com ([192.25.206.7]:24595 "EHLO
	dsl2.external.hp.com") by vger.kernel.org with ESMTP
	id S272716AbTG3Em5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 00:42:57 -0400
Date: Tue, 29 Jul 2003 22:42:56 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Andi Kleen <ak@suse.de>
Cc: Grant Grundler <grundler@parisc-linux.org>, davem@redhat.com,
       alan@lxorguk.ukuu.org.uk, James.Bottomley@SteelEye.com, axboe@suse.de,
       suparna@in.ibm.com, linux-kernel@vger.kernel.org,
       alex_williamson@hp.com, bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
Message-ID: <20030730044256.GA1974@dsl2.external.hp.com>
References: <20030708213427.39de0195.ak@suse.de> <20030708.150433.104048841.davem@redhat.com> <20030708222545.GC6787@dsl2.external.hp.com> <20030708.152314.115928676.davem@redhat.com> <20030723114006.GA28688@dsl2.external.hp.com> <20030728131513.5d4b1bd3.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728131513.5d4b1bd3.ak@suse.de>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 01:15:13PM +0200, Andi Kleen wrote:
> Run it with 100-500 users (reaim -f workfile... -s 100 -e 500 -i 100) 

jejb was wondering if 4k pages would cause different behaviors becuase
of file system vs page size (4k vs 16k).  ia64 uses 16k by default.
I've rebuilt the kernel with 4k page size and VMERGE != 0.
The substantially worse performance feels like a rat hole because
of 4x pressure on CPU TLB.

Ideally, we need a workload to test BIO code without a file system.
Any suggestions?

grant


iota:/mnt# reaim -f /mnt/usr/local/share/reaim/workfile.new_dbase -s100 -e 500 -i 100
REAIM Workload                                                                  
Times are in seconds - Child times from tms.cstime and tms.cutime               

Num     Parent   Child   Child  Jobs per   Jobs/min/  Std_dev  Std_dev  JTI     
Forked  Time     SysTime UTime   Minute     Child      Time     Percent         
100     118.90   21.17   214.03  5197.78    51.98      4.52     3.98     96     
200     236.75   42.54   429.94  5220.63    26.10      9.43     4.16     95     
300     354.94   64.47   644.80  5223.34    17.41      14.47    4.27     95     
400     474.50   87.01   861.09  5209.66    13.02      24.76    5.59     94     
500     594.26   109.80  1077.00 5199.78    10.40      25.36    4.49     95     
Max Jobs per Minute 5223.34                                                     
iota:/mnt# 

