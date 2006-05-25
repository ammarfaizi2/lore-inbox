Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965183AbWEYNfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965183AbWEYNfA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 09:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965179AbWEYNfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 09:35:00 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:16903 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S965183AbWEYNfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 09:35:00 -0400
Date: Thu, 25 May 2006 15:34:27 +0200
From: Willy TARREAU <willy@w.ods.org>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@kvack.org>, Grant Coady <grant_lkml@dodo.com.au>,
       Jari Ruusu <jariruusu@users.sourceforge.net>,
       Chris Wright <chrisw@sous-sol.org>
Subject: [ANNOUNCE] Linux-2.4.32-hf32.5
Message-ID: <20060525133427.GA22727@w.ods.org>
References: <20060507131034.GA19198@exosec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060507131034.GA19198@exosec.fr>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is the fifth hotfix for 2.4.32 and older kernels. There are 8 new
fixes, among which 1 security fix, 1 possible panic and one potential
memory leak, and 5 minor bugs :

 - 2.4.32-CVE-2006-2444-netfilter-snmp-nat-mem-corruption-1 (Patrick McHardy)
 - 2.4.32-memleak-on-corrupted-ext3-journal-1                 (Theodore Ts'o)
 - 2.4.32-avoid-panic-on-corrupted-ext3-journal-1             (Willy Tarreau)
 - 2.4.32-fix-usb-fdd-without-partitions-1                 (Gilles Espinasse)
 - 2.4.32-expire-stale-arp-entries-1                        (Pradeep Vincent)
 - 2.4.32-ext2-update-inode-ctime-on-rename-1                 (Willy Tarreau)
 - 2.4.32-ext3-link-unlink-race-1                              (Vadim Egorov)
 - 2.4.32-ver_linux-binutils-version-reporting-1                (Joshua Kwan)

This leads to the following number of patches per kernel :

   Version | New | Total
   --------+-----+------
    2.4.28 |   8 |  178 
    2.4.29 |   8 |  175 
    2.4.30 |   8 |  109 
    2.4.31 |   8 |   96 
    2.4.32 |   8 |   46 
   --------+-----+------

Please note that three of those patches are not in mainline yet (but
queued) : the netfilter fix (CVE-2006-2444), the ext3-memleak and
the ext3 potential panic. I particularly thank Chris Wright for having
notified us about the netfilter bug we had missed.

I've built it with all modules on x86-smp but not booted it. The
detailed changelog follows. One thing to note is that Jari Ruusu
convinced me to reconciliate with GPG and to sign the files with it.
I don't know if I have done everything right, but I've signed every
.gz file and provided a detached ascii signature. Please do not hesitate
to tell me if I did something wrong. Fingerprint at the end of the mail.

Please use the links below :

    hotfixes home : http://linux.exosec.net/kernel/2.4-hf/
     last version : http://linux.exosec.net/kernel/2.4-hf/LATEST/LATEST/
         RSS feed : http://linux.exosec.net/kernel/hf.xml
    build results : http://bugsplatter.mine.nu/test/linux-2.4/ (Grant's site)
              GIT : http://w.ods.org/kernel/2.4/patches-2.4-hf.git/
           GITWEB : http://w.ods.org/git/?p=patches-2.4-hf.git;a=summary

Regards,
Willy
--

Changelog from 2.4.32-hf32.4 to 2.4.32-hf32.5
---------------------------------------
'+' = added ; '-' = removed

+ 2.4.32-CVE-2006-2444-netfilter-snmp-nat-mem-corruption-1 (Patrick McHardy)

  CVE-2006-2444 - Potential remote DoS in SNMP NAT helper.
  Fix memory corruption caused by snmp_trap_decode which may free
  random memory when snmp_trap_decode fails. The corruption can be
  triggered remotely when the ip_nat_snmp_basic module is loaded
  and traffic on port 161 or 162 is NATed.

+ 2.4.32-memleak-on-corrupted-ext3-journal-1                 (Theodore Ts'o)

  Fix memory leak when the ext3's journal file is corrupted

+ 2.4.32-avoid-panic-on-corrupted-ext3-journal-1             (Willy Tarreau)

  Backport from 2.6 of a patch from Andrew Morton : Don't panic if the
  journal superblock is wrecked: just fail the mount.

+ 2.4.32-fix-usb-fdd-without-partitions-1                 (Gilles Espinasse)

  When an USB flash disk is formatted as a floppy (without partitions),
  random partitions appear in /proc/partitions depending on the code and
  data used by the boot loader at the offset where the partition table
  is expected. Such layout appears when Windows is used to format the USB
  stick, or when putting a boot-loader such as syslinux on an device. This
  patch is a back-port of the 2.6 fix. Carefully tested, works as expected.

+ 2.4.32-expire-stale-arp-entries-1                        (Pradeep Vincent)

  In 2.4.21, arp code uses gc_timer to check for stale arp cache
  entries. In 2.6, each entry has its own timer to check for stale arp
  cache. 2.4.29 to 2.4.32 kernels (atleast) use neither of these timers.
  This causes problems in environments where IPs or MACs are reassigned
  - saw this problem on load balancing router based networks that use
  VMACs. Tested this code on load balancing router based networks as
  well as peer-linux systems.

+ 2.4.32-ext2-update-inode-ctime-on-rename-1                 (Willy Tarreau)

  The ext2fs filesystem on 2.2 and 2.6, as well as other filesystems
  on 2.4 update the inode ctime on rename(). When this fix was applied
  to 2.2.13, it was applied to the ext3 tree at the same time, but the
  ext2 tree was forgotten. It was recently fixed in 2.6, but 2.4 was
  forgotten again. First reported by Chris Siebenmann on 10 Jan 2004.

+ 2.4.32-ext3-link-unlink-race-1                              (Vadim Egorov)

  The problem happens when link and unlink are invoked simultaneously on
  the same inode on ext3 filesystem. In this case ext3_unlink may
  decrement i_nlink to 0 and put this inode into the in-memory orphan
  list, while ext3_link will increment i_nlink back to 1 having the inode
  in the orphan list. Thus the system ends up having an inode with
  i_nlink == 1 in the orphan list. When this inode gets unused later it
  the memory might get released to the free pool and then be used for
  some other purpose, most likely some other inode. From this point on
  any operation on the orphan list may result in modification of the
  list_head that could alredy be used to store some other date.

+ 2.4.32-ver_linux-binutils-version-reporting-1                (Joshua Kwan)

  The 'ver_linux' script expects 'ld' to output a line starting with
  'BFD', while recent versions of 'ld' print 'GNU ld'. The effect is
  that binutils version is not listed in reports based on ver_linux.


--
Willy Tarreau - http://w.ods.org/
PGP Fingerprint : 72C2 A394 02EA F546 BA6F  A7B1 E82C B631 848A 1004
EXOSEC - ZAC des Metz - 3 Rue du petit robinson - 78350 JOUY EN JOSAS
N°Indigo: 0 825 075 510 - Accueil: +33 1 72 89 72 30 - Fax: +33 1 72 89 80 19
Site web : http://www.exosec.fr/

