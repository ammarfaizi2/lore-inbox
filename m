Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWABTDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWABTDz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 14:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWABTDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 14:03:55 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:27660 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750965AbWABTDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 14:03:54 -0500
Date: Mon, 2 Jan 2006 20:03:12 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Willy Tarreau <wtarreau@exosec.fr>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Grant Coady <grant_lkml@dodo.com.au>
Subject: Re: [ANNOUNCE] Linux 2.4.32-hf32.1
Message-ID: <20060102190312.GA16653@w.ods.org>
References: <20060102183740.GB5332@exosec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060102183740.GB5332@exosec.fr>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2006 at 07:37:40PM +0100, Willy Tarreau wrote:
> Hi all,
> 
> first I wish you a Happy New Year !

It seems like the year begins with mistakes, I've forgotten the changelog.
Please consult at the end to keep the mail nearly intact.

> I spent the day updating the 2.4-hf branch (in fact, mostly the scripts
> themselves), because there have been several important fixes since last
> release (2005/11/04). I counted 7 security fixes, 3 major fixes and 6
> minor fixes. This update will bring you to the same level as 2.4.33-pre1.
> Please check the changelog appended to this mail for more details.
> 
> As I previously stated it, the numbering scheme has changed so that all
> versions now share the same -hf suffix. For instance, this new version
> is numbered '-hf32.1', which means that the fixes are up-to-date with
> the first hotfix for mainline 2.4.32. Eventhough the name is ugly, it
> will then become obvious for anyone that 2.4.29-hf32.1 is late when
> 2.4.33-hf is out. As a side effect, I will only announce the lastest
> release, as everyone can understand that older ones are available too.
> 
> As nearly two months have elapsed since last -hf (2.4.31-hf8), a lot
> of things have been merged. In fact, I had even made a 2.4.31-hf9 which
> was never released due to a lack of time. So you'll find references to
> it in the changelog but it will not be available for download as it is
> already obsolete (except upon request, but I doubt anyone will be
> interested). I intend to be able to release more often as I found how
> to make my scripts benefit from git to grab the patches that I consider
> useful.
> 
> I've built the kernel for i686 with all modules enabled to ensure
> everything was OK, but did not boot it. I've not built incremental
> diffs, but I can make them upon request if anyone needs them. Right
> now, patches for kernels 2.4.29 to 2.4.32, both split up and as a
> whole patch, with and without extraversion are provided.
> 
> As usual, I'm sure that Grant will be glad to do a full rebuild for all
> of his machines and post the results online (Thanks Grant ;-)).
> 
>  URLs of interest :
> 
>     hotfixes home : http://linux.exosec.net/kernel/2.4-hf/
>      last version : http://linux.exosec.net/kernel/2.4-hf/LATEST/LATEST/
>          RSS feed : http://linux.exosec.net/kernel/hf.xml
>     build results : http://bugsplatter.mine.nu/test/linux-2.4/ (Grant's site)
> 
> 
> If anything's wrong, please bug me.
> 
> Happy kernel hacking for 2006,
> Willy

--- Changelog ---

Changelog from 2.4.32 to 2.4.32-hf32.1
---------------------------------------
'+' = added ; '-' = removed

+ 2.4.32-backport-of-CVE-2005-2709-fix-1                      (dann frazier)

  I've backported the fix for CVE-2005-2709 to 2.4 for Debian's 2.4 sarge
  kernel. sysctl.c in Linux kernel before 2.6.14.1 allows local users to
  cause a denial of service (kernel oops) and possibly execute code by
  opening an interface file in /proc/sys/net/ipv4/conf/, waiting until the
  interface is unregistered, then obtaining and modifying function pointers
  in memory that was used for the ctl_table.

+ 2.4.32-ipv6-fix-refcnt-of-struct-ip6_flowlabel-1               (Yan Zheng)

  This looks like another potential "local DoS" since this is in
  setsockopt(IPV6_FLOWLABEL_MGR). Users can cause a flow label to be
  kfreed() without removing it from the socket; and then overwrite its
  contents. This can trigger random kernel memory corruption.

+ 2.4.32-fix-sendmsg-overflow-CVE-2005-2490-1              (Marcus Meissner)

  Al Viro reported a flaw in sendmsg(). "When we copy 32bit ->msg_control
  contents to kernel, we walk the same userland data twice without sanity
  checks on the second pass. Moreover, if original looks small enough, we
  end up copying to on-stack array." - CVE-2005-2490.

+ 2.4.32-vfs-local-denial-of-service-file-lease-1                    (Horms)

  [PATCH] VFS: local denial-of-service with file leases (CVE-2005-3857)
  Remove time_out_leases() printk that's easily triggered by users.

+ 2.4.32-x86-64-user-code-panics-kernel-CVE-2005-2708-1      (Dave Anderson)

  There seems to be a local DoS in exec on AMD64 / linux 2.4 when the
  system is under memory pressure.
  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=161925

+ 2.4.32-IGMP-workaround-for-IGMP-v1-v2-bug-1                (David Stevens)

  As explained at http://www.cs.ucsb.edu/~krishna/igmp_dos/
  With IGMP version 1 and 2 it is possible to inject a unicast report to
  a client which will make it ignore multicast reports sent later by the
  router. The fix is to only accept the report if is was sent to a
  multicast or unicast address.

+ 2.4.32-ipv6-mcast-igmp-dos-fix-1                         (David S. Miller)

  Same issue as IPv4, don't listen to non-broadcast non-multicast reports.

+ 2.4.32-airo_cs-prototypes-1                                  (Adrian Bunk)

  If you got strange problems with either airo_cs devices or in any other
  completely unrelated part of the kernel shortly or long after a airo_cs
  device was detected by the kernel, this might have been caused by the
  fact that caller and callee disagreed regarding the size of the first
  argument to init_airo_card()...

+ 2.4.32-dont-panic-on-ide-dma-errors-1                         (Chris Ross)

  Kernel 2.4.32 and earlier can panic when trying to read a corrupted
  sector from an IDE disk. The function ide_dma_timeout_retry can end
  a request early by calling idedisk_error, but then goes on to use the
  request anyway causing a kernel panic due to a null pointer exception.

+ 2.4.32-data-corruption-in-smb_proc_setattr_unix-1      (Maciej W. Rozycki)

  This patch fixes a data corruption in smb_proc_setattr_unix().
  smb_filetype_from_mode() returns an u32, and there are only four bytes
  reserved for it in data.

+ 2.4.32-fix-for-clock-running-too-fast-1                  (Akira Tsukamoto)

  This one line patch adds upper bound testing inside timer_irq_works()
  when evaluating whether irq timer works or not on boot up. It fix the
  machines having problem with clock running too fast. What this patch
  do is, if timer interrupts running too fast through IO-APIC IRQ then
  false back to i8259A IRQ.

+ 2.4.32-fix-ptrace-self-attach-rule-1                      (Linus Torvalds)

  [PATCH] Fix ptrace self-attach rule
  Before we did CLONE_THREAD, the way to check whether we were attaching
  to ourselves was to just check "current == task", but with CLONE_THREAD
  we should check that the thread group ID matches instead.

+ 2.4.32-dcache-avoid-race-nr_unused-dentries-1                 (Neil Brown)

  [PATCH] fs/dcache.c: avoid race when updating nr_unused count of unused
  dentries. d_count==1 is no guarantee that dentry is on the dentry_unused
  list, even if it has just been incremented inside dcache_lock, as dput
  can decrement at any time. This test from Greg Banks is much safer, and
  is more transparently correct.

Changelog from 2.4.31-hf8 to 2.4.31-hf9
---------------------------------------
'+' = added ; '-' = removed

+ 2.4.31-sd_mod-memory-leak-1                                    (Dan Aloni)

  [PATCH] fix memory leak in sd_mod.o
  Handle freeing of sd_max_sectors in sd_exit().

+ 2.4.31-udp_v6_get_port-infinite-loop-1                 (YOSHIFUJI Hideaki)

  [IPV6]: Fix infinite loop in udp_v6_get_port()
  This is CVE-2005-2973, and 87bf9c97b4b3af8dec7b2b79cdfe7bfc0a0a03b2
  in Linus' 2.6 Git Tree. It seems to be relevant to 2.4

+ 2.4.31-tcp-clear-stale-pred_flags-snd_wnd-change-1            (Herbert Xu)

  [PATCH] Clear stale pred_flags when snd_wnd change
  This bug is responsible for causing the infamous "Treason uncloaked"
  messages that's been popping up everywhere since the printk was added.
  In the case of the treason messages, it just happens that the snd_wnd
  cached in pred_flags is zero while tp->snd_wnd is non-zero.  Therefore
  when a zero-window packet comes in we incorrectly conclude that the
  window is non-zero.

+ 2.4.31-only-disallow-setting-function-key-1              (Marcelo Tosatti)

  [PATCH] only disallow _setting_ of function key string
  Mikael Pettersson <mikpe@csd.uu.se> noted that the current 2.6-git (and
  2.4) patch to disallow KDSKBSENT for unpriviledged users should be less
  restrictive allowing reading of current function key string entry, but
  not writing.

--- end ---

