Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274957AbTHAVwZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 17:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274965AbTHAVwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 17:52:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:13777 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274957AbTHAVwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 17:52:18 -0400
Message-Id: <200308012151.h71LpnR05998@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Grant Grundler <grundler@parisc-linux.org>
cc: Andi Kleen <ak@suse.de>, davem@redhat.com, alan@lxorguk.ukuu.org.uk,
       James.Bottomley@SteelEye.com, axboe@suse.de, suparna@in.ibm.com,
       linux-kernel@vger.kernel.org, alex_williamson@hp.com,
       bjorn_helgaas@hp.com, cliffw@osdl.org
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II 
In-Reply-To: Message from Grant Grundler <grundler@parisc-linux.org> 
   of "Tue, 29 Jul 2003 20:31:47 MDT." <20030730023147.GA31757@dsl2.external.hp.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Aug 2003 14:51:49 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jul 28, 2003 at 01:15:13PM +0200, Andi Kleen wrote:
> > Run it with 100-500 users (reaim -f workfile... -s 100 -e 500 -i 100) 
> > I tested with ext3 on a single SCSI disk.
> 
> andi, davem, jens,
> sorry for the long delay. Here's the data for ZX1 using u320 HBA
> (LSI 53c1030) and ST373453LC disk (running U160 IIRC).
> If you need more runs on this config, please ask.
> 
> Executive summary: < %1 difference for this config.
> 
> I'd still like to try a 53c1010 but don't have any installed right now.
> I suspect 53c1010 is alot less efficient at retrieving SG lists
> and will see a bigger difference in perf.
> 
> 
> One minor issue when starting re-aim-7, but not during the run:
> 
> reaim(343): floating-point assist fault at ip 4000000000017a81, isr 0000020000000008                                                                            
> reaim(343): floating-point assist fault at ip 4000000000017a61, isr 0000020000000008
> 
> 
> For the record, I retrieved source from:
>     http://umn.dl.sourceforge.net/sourceforge/re-aim-7/reaim-0.1.8.tar.gz
> 
> This should be renamed to osdl-aim-7 (or something like that).
> The name space collision is unfortunate and annoying.

Apoligies, the naming was not good.
I'll attempt to change it. ( i like osdl-aim-7 )
In the meantime, you can also get the source from

bk://developer.osdl.org/reaim
cliffw

> 
> hth,
> grant
> 
> 
> 
> 
> #define BIO_VMERGE_BOUNDARY     0 /* (ia64_max_iommu_merge_mask + 1) */
> iota:/mnt# reaim -f /mnt/usr/local/share/reaim/workfile.new_dbase -s100 -e 500 -i 100
> 
> REAIM Workload
> Times are in seconds - Child times from tms.cstime and tms.cutime
> 
> Num     Parent   Child   Child  Jobs per   Jobs/min/  Std_dev  Std_dev  JTI
> Forked  Time     SysTime UTime   Minute     Child      Time     Percent 
> 100     110.25   12.67   206.35  5605.19    56.05      3.48     3.29     96   
> 200     219.07   25.56   411.93  5642.06    28.21      7.83     3.73     96   
> 300     327.59   38.23   615.83  5659.46    18.86      12.79    4.09     95   
> 400     436.66   51.19   821.30  5661.19    14.15      18.34    4.42     95   
> 500     548.21   65.76   1029.15 5636.54    11.27      23.34    4.47     95   
> Max Jobs per Minute 5661.19
> iota:/mnt#
> 
> 
> 
> #define BIO_VMERGE_BOUNDARY     (ia64_max_iommu_merge_mask + 1)                 
> 
> iota:/mnt# PATH=$PATH:/mnt/usr/local/bin       
> iota:/mnt# reaim -f /mnt/usr/local/share/reaim/workfile.new_dbase -s100 -e 500 -i 100
> 
> REAIM Workload
> Times are in seconds - Child times from tms.cstime and tms.cutime
> 
> Num     Parent   Child   Child  Jobs per   Jobs/min/  Std_dev  Std_dev  JTI
> Forked  Time     SysTime UTime   Minute     Child      Time     Percent 
> 100     108.72   12.47   203.78  5684.17    56.84      4.46     4.32     95   
> 200     217.64   25.59   408.90  5679.16    28.40      8.65     4.16     95   
> 300     326.48   37.88   613.62  5678.81    18.93      13.80    4.44     95   
> 400     434.87   50.53   817.64  5684.46    14.21      17.40    4.18     95   
> 500     544.69   65.23   1022.92 5672.92    11.35      21.53    4.12     95   
> Max Jobs per Minute 5684.46
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


