Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265079AbUAKUU0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 15:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265083AbUAKUU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 15:20:26 -0500
Received: from main.gmane.org ([80.91.224.249]:45766 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265079AbUAKUUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 15:20:22 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: yoann <informatique-nospam@mistur.org>
Subject: Re: 2.6.1: data corrupton when recieving files > 1GB over network
Date: Sun, 11 Jan 2004 21:16:22 +0100
Message-ID: <btsaum$g7f$1@sea.gmane.org>
References: <5.1.0.14.2.20040111161640.014ad6c0@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: fr, fr-fr, en
In-Reply-To: <5.1.0.14.2.20040111161640.014ad6c0@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found a strange behavior with md5sum and nfs.

I've a nfs server (mistur) under debian woody 2.4.18, and a client 
(vaka) under debian sid  2.6.1-mm2 or 2.4.18-bf2.4 (onlu for test)

Linux vaka 2.6.1-mm2 #1 Sat Jan 10 19:16:02 CET 2004 i686 GNU/Linux
Linux vaka 2.4.18-bf2.4 #1 Son Apr 14 09:53:28 CEST 2002 i686 GNU/Linux 
 
                                                          Linux mistur 
2.4.18-1-686 #4 Sat Nov 29 10:18:26 EST 2003 i686 unknown

vaka   : dpkg 1.10.18
mistur : dpkg 1.9.21

nfs export :

path on client  ->  path on server
/mnt/multimedia -> /mnt/multimedia
/mnt/tmp        -> /tmp

I've done some test with md5sum on the iso of woody 3.0r0 CD1

same file : /mnt/multimedia/iso

- mistur local (ext3) 2.4.18-1-686 :
   ca679b3b8e28be00b98b007611384958  /mnt/multimedia/iso/woody-cd1.iso

- vaka remote (nfs) 2.4.18-bf2.4 :
   ea34f974bdcfb2a678a97afb1fb4077d  /mnt/multimedia/iso/woody-cd1.iso

- vaka remote (nfs) 2.6.1-mm2 :
   ca679b3b8e28be00b98b007611384958  /mnt/multimedia/iso/woody-cd1.iso
   2798b3e2b97ca8082049c9207c291ebb  /mnt/multimedia/iso/woody-cd1.iso

copy on vaka in /usr/src/test/ using nfs

- vaka local (ext3) 2.4.18-bf2.4 :
   287ffb166b1e32a75ad106ceffb1dc3f  /usr/src/test/woody-cd1.iso

- vaka local (ext3) 2.6.1-mm2 :
   287ffb166b1e32a75ad106ceffb1dc3f  /usr/src/test/woody-cd1.iso

copy on mistur in /mnt/tmp using nfs

- vaka remote (nfs) 2.4.18-bf2.4 :
   102fbde335166ccd980f672370fc3a4b  /mnt/tmp/test/woody-cd1.iso

- vaka remote (nfs) 2.6.1-mm2 :
   bd52d79225a863e484c2d1815b5c5b7c  /mnt/tmp/test/woody-cd1.iso

- mistur local (ext3) 2.4.18-1-686 :
   287ffb166b1e32a75ad106ceffb1dc3f  /tmp/test/woody-cd1.iso 


all copy was done under 2.6.1-mm2 kernel

I could do more test, all under 2.4.X and all under 2.6.X
- copy with nfs, with ftp,...
- using différent versiob of md5sum

but, not enouph time now

anyway seem to have a problem

Yoann

Hans Spath a écrit :
> Hello,
> 
> When I transfer files to my linux 2.6.1 box their content changes 
> (tested via md5 sums).
> 
> I transfered a 1,8 GB (mpeg) file serveral times to this machine by 
> using either pure-ftpd (upload) or wget (download) on that machine. I 
> got a different md5sum each time. Same problem with a 1,4 GB (zip) file, 
> but *not* with a 0,7 GB (mpeg) file.
> 
> When I boot the machine with Knoppix 3.2 (Linux 2.4.21-xfs) and upload 
> the 1,8 GB file to it's ftpd (same target harddisk/partition/directory), 
> the file is ok.
> 
> When I dupplicate the correctly recieved file with dd or cp under Linux 
> 2.6.1 there is no corruption, too.
> 
> I don't know what tools I should use to determine at what positions 
> these corruptions start and how much is corrupted. But I think about the 
> first 1 GB is transfered correctly (diff needs some time before it says 
> "Binary files test-2.6.mpeg and test-2.4.mpeg differ")
> 
> Kernel is built without module support.
> 
> 
> [ Some lines from dmesg ]
> Linux version 2.6.1 (stob@netbrake) (gcc version 2.95.4 20011002 (Debian 
> prerelease)) #5 Sat Jan 10 01:40:00 CET 2004
> CPU: Intel Pentium III (Katmai) stepping 02
> agpgart: Detected VIA Apollo Pro 133 chipset
> eth0: RealTek RTL8139 at 0xe3818000, 00:00:21:d5:a6:48, IRQ 10
> eth0:  Identified 8139 chip type 'RTL-8139B'
> hda: Maxtor 98196H8, ATA DISK drive
> hda: max request size: 128KiB
> hda: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, 
> UDMA(33)
>  hda: hda1
> EXT3 FS on hda1, internal journal
> 
> [ Output of scripts/ver_linux ]
> Linux netbrake 2.6.1 #5 Sat Jan 10 01:40:00 CET 2004 i686 unknown
> Gnu C                  2.95.4
> Gnu make               3.80
> util-linux             2.12
> mount                  2.12
> module-init-tools      implemented
> e2fsprogs              1.34
> Linux C Library        2.2.5
> Dynamic linker (ldd)   2.2.5
> Procps                 3.1.15
> Net-tools              1.60
> Console-tools          0.2.3
> Sh-utils               2.0.11
> 



