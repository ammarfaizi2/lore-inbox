Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbTFCRuZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 13:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbTFCRuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 13:50:24 -0400
Received: from mail-nb00s0.nbnet.nb.ca ([198.164.200.23]:640 "EHLO
	mail-nb00s0.nbnet.nb.ca") by vger.kernel.org with ESMTP
	id S261454AbTFCRuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 13:50:06 -0400
Message-ID: <C65F89D1AC0BB54B865127151A24DA7810F74CFF@nbexchm2.aliant.icn>
From: "Shaw, Marco" <Marco.Shaw@aliant.ca>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Linux paging and swapping (2.4.18)
Date: Tue, 3 Jun 2003 15:03:51 -0300 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(First, my apologies for using a Windows email client which will typically format things badly.)

I've been trying to understand Linux paging.  Does anyone have any good online links, some 
'hidden treasure' of some kind of presentation on Linux 2.4 MM, or any recent books?

Yes, reading the source is best, but I'm years away from being able to read C proficiently.

My underlying problem is I have a system with daily average 'pages in'/second between 0.02-56.21, and
'pages out'/second between 49.89-66.15 in a summary below.  I'm trying to figure out if this is an
issue, and what might be the cause.  In the meantime, I'm trying to get a better understanding
of Linux MM at a higher level.

Marco


-----Original Message-----
From: Shaw, Marco 
Sent: Thursday, May 29, 2003 2:05 PM
To: 'linux-raid@vger.kernel.org'
Subject: RE: Heavy paging, but no swap being used.--MORE INFO

I was asked what I meant by "heavy page in/page out", and I'll do my best...

We have a monitoring system that believes anything over 10 for pages/second could be a problem, and 
20 is really bad.

I've gathered this from one of my systems, where: 
Pgs_in=pages_in (average for day) 
Pgs_in_max=pags_in_maximum (maximum value for day) 
Pgs_out=pages_out (average for day) 
Pgs_out_max=pags_out_maximum (maximum value for day)

Some output from one of our Linux systems:
sample_date	pgs_in  pgs_in_max	pgs_out pgs_out_max
5/16/2003	0.07	5.68	53.32	159.54
5/17/2003	0.04	3.27	49.89	167.2
5/18/2003	0.09	5.74	50.57	159.61
5/19/2003	0.02	0.04	51.55	160.07
5/20/2003	25.86	657.06	57.06	166.05
5/21/2003	56.21	970.79	66.15	156.4
5/22/2003	10.48	1371.75	58.27	168.07
5/23/2003	0.33	39.9	56.77	148.58
5/24/2003	0.03	0.26	56.2	162.94
5/25/2003	0.02	0.49	56.45	166.74
5/26/2003	0.05	1.13	65.62	173.82
5/27/2003	36.8	754.51	64	203.06

Hence that difficult question of what is the norm?  I'm trying to figure out if I have 
a problem Or this is 'normal' for the system: a dual-CPU 1.4GHz PIII with 4GB of RAM.  
The OS is on a local Hardware RAID card, but other data/apps are on a SAN attached 
software RAID0 device.

Marco

> -----Original Message-----
> From: Shaw, Marco
> Sent: Thursday, May 29, 2003 11:31 AM
> To: 'linux-raid@vger.kernel.org'
> Subject: Heavy paging, but no swap being used.
> 
> 
> RedHat 7.2 with 2.4.18-18.7.xbigmem using RedHat's software
> RAID package.
> 
> I've been seeing quite a bit of page in/page out going on,
> and have been looking around.
> 
> With the 2.4 kernel, when would one expect to see swap usage?
>  I'm assuming the 2.4 memory works a bit like Solaris where 
> one should expect to see physical memory usage relatively 
> high, and that's a good/normal thing, but I don't see any 
> swap utilization at all, which concerns me.  I may have 
> misconfigured something...
> 
> How can I pin-point, if possible, whether the paging is
> related to the use of software RAID?
> 
> Marco
> 
> # more raidtab
> raiddev /dev/md0
>         raid-level              0
>         nr-raid-disks           2
>         persistent-superblock   1
>         chunk-size              32
>         device                  /dev/sdc1
>         raid-disk               0
>         device                  /dev/sdd1
>         raid-disk               1
> 
> # free
>             total       used       free     shared    buffers 
>     cached
> Mem:       3874464    3843256      31208          0     
> 381844    3084184
> -/+ buffers/cache:     377228    3497236
> Swap:      2048248          0    2048248
> 
> # sar -r
> Linux 2.4.18-18.7.xbigmem 05/29/2003
> 
> 12:00:00 AM kbmemfree kbmemused  %memused kbmemshrd kbbuffers
>  kbcached kbswpfree kbswpused  %swpused
> 12:10:00 AM     33956   3840508     99.12         0    381020 
>   3085476   2048248         0      0.00
> 
> # swapon -s
> Filename                        Type            Size    Used  
>   Priority
> /dev/sda6                       partition       2048248 0       -1
> 
> # more /etc/fstab
> LABEL=/                 /                       ext3    
> defaults        1 1
> LABEL=/boot             /boot                   ext3    
> defaults        1 2
> none                    /dev/pts                devpts  
> gid=5,mode=620  0 0
> LABEL=/home             /home                   ext3    
> defaults        1 2
> none                    /proc                   proc    
> defaults        0 0
> none                    /dev/shm                tmpfs   
> defaults        0 0
> LABEL=/tmp              /tmp                    ext3    
> defaults        1 2
> LABEL=/usr              /usr                    ext3    
> defaults        1 2
> LABEL=/var              /var                    ext3    
> defaults        1 2
> /dev/md0 /hosting ext3 defaults,usrquota 0 0
> /dev/sda6               swap                    swap    
> defaults        0 0
> /dev/cdrom              /mnt/cdrom              iso9660 
> noauto,owner,kudzu,ro 0
> 0
> /dev/fd0                /mnt/floppy             auto    
> noauto,owner,kudzu 0 0
> 
> 
> # sar -B
> Linux 2.4.18-18.7.xbigmem 05/29/2003
> 
> 12:00:00 AM  pgpgin/s pgpgout/s  activepg  inadtypg  inaclnpg
>  inatarpg ...
> Average:         0.02     55.34    561672    225090    115799 
>    180512
> 
