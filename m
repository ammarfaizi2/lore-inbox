Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129624AbRBWPHJ>; Fri, 23 Feb 2001 10:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129279AbRBWPGs>; Fri, 23 Feb 2001 10:06:48 -0500
Received: from dnscache.uknet.spacesurfer.com ([213.253.36.77]:41733 "HELO
	blackhole.uknet.spacesurfer.com") by vger.kernel.org with SMTP
	id <S129272AbRBWPGg>; Fri, 23 Feb 2001 10:06:36 -0500
Message-ID: <3A967D27.803F4C8F@spacesurfer.com>
Date: Fri, 23 Feb 2001 15:09:27 +0000
From: Patrick Mackinlay <patrick@spacesurfer.com>
Reply-To: patrick@spacesurfer.com
Organization: SpaceSurfer Ltd.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problems with reiserfs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When 2.4.1 was released I reported a kernel oops with reiserfs, I got no
response.
The problem still persists with kernel 2.4.2. I am using mkreiserfs v2
(3.6.25) and tried on different ide hards disks as well as on a software
raid 0 partition, I also tried with and without CONFIG_REISERFS_CHECK
defined, the oops always happens.

My system is a dual pentium 500, 256M memory, IDE:
IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
The system has been running flawlessly with 2.2 kernels for months.

This is how I caused the first oops:
Created 2Gig reiserfs partition on /dev/md0 (raid0)
mount /dev/md0 /mnt/md0
Mount took 3-5 seconds
cp -ax / /mnt/md0
Only the /bin directory (not the contents!) was copied and then cp core
dumped. syslog reports an oops, however the system is still usable but
mount/umount/sync is not possible on any filesystems.

kernel oops report:
>>EIP; d2cf9db8 <[reiserfs]create_virtual_node+298/490>   <=====
Trace; d2cfc053 <[reiserfs]dc_check_balance_leaf+53/150>
Trace; d2cfc975 <[reiserfs]fix_nodes+115/450>
Trace; d2d062ac <[reiserfs]reiserfs_cut_from_item+1fc/430>
Trace; d2d152f0 <[reiserfs]reiserfs_mounted_fs_count+0/4>
Trace; d2d0686e <[reiserfs]reiserfs_do_truncate+32e/470>
Trace; d2d18044 <.bss.end+1165/???
Trace; d2cf8567 <[reiserfs]reiserfs_truncate_file+b7/1a0>
Trace; d2d0fa24 <[reiserfs].rodata.start+11e4/678e>
Trace; d2d141af <[reiserfs].rodata.start+596f/678e>
Trace; d2cf9382 <[reiserfs]reiserfs_file_release+1d2/380>
Trace; d2cf94cf <[reiserfs]reiserfs_file_release+31f/380>
Trace; d2d0fb8c <[reiserfs].rodata.start+134c/678e>
Trace; d2d141af <[reiserfs].rodata.start+596f/678e>
Trace; c0128230 <file_read_actor+0/60>
Trace; c0135e47 <fput+37/e0>
Trace; c0134d56 <filp_close+a6/b0>
Trace; c0134dbb <sys_close+5b/70>
Trace; c0109127 <system_call+33/38>
Code;  d2cf9db8 <[reiserfs]create_virtual_node+298/490>
00000000 <_EIP>:
Code;  d2cf9db8 <[reiserfs]create_virtual_node+298/490>   <=====
   0:   8b 40 14                  mov    0x14(%eax),%eax   <=====
Code;  d2cf9dbb <[reiserfs]create_virtual_node+29b/490>
   3:   ff d0                     call   *%eax
Code;  d2cf9dbd <[reiserfs]create_virtual_node+29d/490>
   5:   89 c2                     mov    %eax,%edx
Code;  d2cf9dbf <[reiserfs]create_virtual_node+29f/490>
   7:   8b 06                     mov    (%esi),%eax
Code;  d2cf9dc1 <[reiserfs]create_virtual_node+2a1/490>
   9:   83 c4 10                  add    $0x10,%esp
Code;  d2cf9dc4 <[reiserfs]create_virtual_node+2a4/490>
   c:   01 c2                     add    %eax,%edx
Code;  d2cf9dc6 <[reiserfs]create_virtual_node+2a6/490>
   e:   89 16                     mov    %edx,(%esi)
Code;  d2cf9dc8 <[reiserfs]create_virtual_node+2a8/490>
  10:   8b 83 8c 01 00 00         mov    0x18c(%ebx),%eax

-- 
Patrick Mackinlay                                patrick@spacesurfer.com
ICQ: 59277981                                        tel: +44 7050699851
                                                     fax: +44 7050699852
SpaceSurfer Limited                          http://www.spacesurfer.com/
