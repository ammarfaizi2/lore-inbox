Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276788AbRJCR5O>; Wed, 3 Oct 2001 13:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276807AbRJCR5E>; Wed, 3 Oct 2001 13:57:04 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:29839 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S276788AbRJCR4w>; Wed, 3 Oct 2001 13:56:52 -0400
To: linux-kernel@vger.kernel.org
Subject: [OOPS] reiserfs and tar
From: Stefan Nobis <stefan@snobis.de>
Organization: ESN - EDV-Beratung, Sicherheit, Netzbetreuung
Date: 03 Oct 2001 19:57:11 +0200
Message-ID: <87adz861zc.fsf@520075220525-0001.dialin.t-online.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Some days ago i had the silly idea to make a backup. I have a small server
with a IBM-DTLA-307045 harddisk and i wanted to backup some dirs in /home
(which is a reiserfs partition and exported via NFS -- i use the
kernel-server). The backup should be saved on another reiserfs partition on
the same harddisk:

Filesystem            Size  Used Avail Use% Mounted on
/dev/scsi/host0/bus0/target0/lun0/part2
                      167M   14M  143M   9% /
/dev/discs/disc1/part7
                       29G  2.7G   26G  10% /home
/dev/discs/disc1/part5
                      8.8G  132M  8.6G   2% /backup

I tried to backup not complete /home but about 900MB of it.

The server is an AMD K6-200 on a Gigabyte GA586 board with 128MB of memory, a
Adaptec AHA2940 SCSI-Controller and a Promise PDC20267 IDE-Controller to which
only the IBM harddisk is attachted (DMA activated:
  /sbin/hdparm -c1 /dev/discs/disc1/disc
  /sbin/hdparm -W 0 /dev/discs/disc1/disc ).

# hdparm -v /dev/discs/disc1/disc 

/dev/discs/disc1/disc:
 multcount    =  0 (off)
 I/O support  =  1 (32-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 23819/16/63, sectors = 90069840, start = 0

When i start the backup, tar reaches about 100MB archive size (sometimes only
50MB, sometime about 150MB) and then the kernel oopses:

Oct  3 19:02:41 mauzi kernel: Unable to handle kernel paging request at virtual address 00002107
Oct  3 19:02:41 mauzi kernel:  printing eip:
Oct  3 19:02:41 mauzi kernel: 00002107
Oct  3 19:02:41 mauzi kernel: *pde = 00000000
Oct  3 19:02:41 mauzi kernel: Oops: 0000
Oct  3 19:02:41 mauzi kernel: CPU:    0
Oct  3 19:02:41 mauzi kernel: EIP:    0010:[<00002107>]
Oct  3 19:02:41 mauzi kernel: EFLAGS: 00010287
Oct  3 19:02:41 mauzi kernel: eax: c4c6da20   ebx: c4c6da20   ecx: c4c6da20   edx: c5837000
Oct  3 19:02:41 mauzi kernel: esi: c1160dc0   edi: 00000000   ebp: c1160dc0   esp: c3a8dea8
Oct  3 19:02:41 mauzi kernel: ds: 0018   es: 0018   ss: 0018
Oct  3 19:02:41 mauzi kernel: Process tar (pid: 15124, stackpage=c3a8d000)
Oct  3 19:02:41 mauzi kernel: Stack: c0d81e2c 00001000 c0130152 c1160dc0 00001000 00000001 c1259fe0 c1160dc0 
Oct  3 19:02:41 mauzi kernel:        c0130647 c1160dc0 00002107 00001000 c1259fe0 c1160dc0 c0d81e2c 00000000 
Oct  3 19:02:41 mauzi kernel:        c01fe09c 00000000 00000001 c01fdf28 c0d81d80 c1160d80 00000000 c01fdf28 
Oct  3 19:02:42 mauzi kernel: Call Trace: [create_empty_buffers+22/76] [block_read_full_page+75/520] [__alloc_pages+61/452] [reiserfs:__insmod_reiserfs_S.text_L116592+34834/116672] [reiserfs:__insmod_reiserfs_S.text_L116592+24324/116672] 
Oct  3 19:02:42 mauzi kernel:    [do_generic_file_read+810/1220] [generic_file_read+126/404] [file_read_actor+0/96] [sys_read+149/204] [system_call+51/64] 
Oct  3 19:02:42 mauzi kernel: 
Oct  3 19:02:42 mauzi kernel: Code:  Bad EIP value.

I tried Kernel 2.4.10, 2.4.9 and 2.4.6 -- with all 3 version (all three
vanilla from kernel.org) the same error. Ah, /home was exported while making
the backup, but no client was working. Any ideas? (If you need more data,
please ask! I've no experience debugging the kernel.)

P.S. The oops is reproduceable.

-- 
Until the next mail...,
Stefan.
