Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315619AbSFTVon>; Thu, 20 Jun 2002 17:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315546AbSFTVom>; Thu, 20 Jun 2002 17:44:42 -0400
Received: from chfdns02.ch.intel.com ([143.182.246.25]:22480 "EHLO
	melete.ch.intel.com") by vger.kernel.org with ESMTP
	id <S315627AbSFTVok>; Thu, 20 Jun 2002 17:44:40 -0400
Message-ID: <01BDB7EEF8D4D3119D95009027AE99951B0E63E9@fmsmsx33.fm.intel.com>
From: "Griffiths, Richard A" <richard.a.griffiths@intel.com>
To: lse-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: FW: [Lse-tech] Re: ext3 performance bottleneck as the number of s
	pindles  gets large
Date: Thu, 20 Jun 2002 14:44:39 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The bonnie++ version is 1.02a

-----Original Message-----
From: Griffiths, Richard A 
Sent: Thursday, June 20, 2002 2:37 PM
To: 'Andrew Morton'
Subject: RE: [Lse-tech] Re: ext3 performance bottleneck as the number of
spindles gets large


Kernel has highmem disabled so only 1 of the 2GB is seen. Setup is 4 adaptec
PCI SCSI HBAs. Three are 39160 dual port, and one is a 29160LP single port.
All four adapters are supposed to 160MB/s.  The dual ports used only channel
A, so they were effectively single port.  
The external drive enclosures are dual bus with 6 18GB Seagates (model
ST318452LC 15K rpm) on each bus for a total of 24 drives.  Each drive was
created as a single 18GB ext3 file system.  

The mount structure is four directories represent the four controllers
{/mnt/c0 /mnt/c1 /mnt/c2 /mnt/c3} and under each of those are six
directories were the individual file systems are mounted  {t0-t5}.  So, for
a run of 2 controllers with two drives against a 300MB file, an environment
variable is set from /mnt thus: l=`find c[1,2] -name t[0,3] -print`.
An echo of $l shows "c1/t0 c1/t3 c2/t0 c2/t3"
Then fire off multiple iterations of bonnie++ backgrounded with a for loop:
for i in $l
do
cd $i
bonnie++ -d . -r 0 -n 0 -u root -f -m `hostname` -s 300 >LM_2x2_300MB &
cd ../..
done


Richard
-----Original Message-----
From: Andrew Morton [mailto:akpm@zip.com.au]
Sent: Thursday, June 20, 2002 2:12 PM
To: Gross, Mark
Cc: 'Dave Hansen'; 'Russell Leighton'; mgross@unix-os.sc.intel.com;
Linux Kernel Mailing List; lse-tech@lists.sourceforge.net; Griffiths,
Richard A
Subject: Re: [Lse-tech] Re: ext3 performance bottleneck as the number of
spindles gets large


"Gross, Mark" wrote:
> 
> ...
> The workload is http://www.coker.com.au/bonnie++/ (one of the newer
versions
> ;)
>

Please tell me exactly how you're using it: how many filesystems, how
many controllers, disk topology, physical memory, size of filesystems,
etc.  Sufficient for me to be able to reproduce it and find out what
is happening.

Also: what is your best-case aggregate bandwidth?  Platter-speed of disks
multiplied by number of disks, please?

Thanks to the BKL you've effectively got 1.3 to 1.5 CPUs, but we should be
able to saturate six or eight disks on a uniprocessor kernel.  It's
possible that we're looking at the wrong thing.

-
