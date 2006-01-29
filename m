Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWA2R5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWA2R5H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 12:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWA2R5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 12:57:06 -0500
Received: from exo3753.pck.nerim.net ([213.41.240.142]:61494 "EHLO
	mail-out1.exosec.net") by vger.kernel.org with ESMTP
	id S1751090AbWA2R5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 12:57:05 -0500
Date: Sun, 29 Jan 2006 18:56:47 +0100
From: Willy Tarreau <wtarreau@exosec.fr>
To: linux-kernel@vger.kernel.org
Cc: Syed Ahemed <kingkhan@gmail.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Grant Coady <grant_lkml@dodo.com.au>
Subject: [ANNOUNCE] Linux 2.4.32-hf32.2
Message-ID: <20060129175647.GA21999@exosec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

here's the second hotfix for 2.4.32 and older kernels. There are only
a few fixes, two of them security-related, and one that I mistakenly
removed from 2.4.32-hf32.1 because I thought it was fixed in 2.4.32
while it was not. Please consult the appended changelog.

In other news, with some help from Syed Ahemed, I added support for
2.4.28 which some people still use. It is interesting to note that
some recent patches do not apply to 2.4.28 because the bugs they fix
were introduced later. That clearly demonstrates the usefulness of a
feature freeze.

I've successfully built 2.4.28-hf32.2 with all of its modules, which
puts 150 patches on top of 2.4.28.

Grant, I think it's not necessary to rebuild all versions, doing 2.4.32
should be enough.

 URLs of interest :

    hotfixes home : http://linux.exosec.net/kernel/2.4-hf/
     last version : http://linux.exosec.net/kernel/2.4-hf/LATEST/LATEST/
         RSS feed : http://linux.exosec.net/kernel/hf.xml
    build results : http://bugsplatter.mine.nu/test/linux-2.4/ (Grant's site)

Cheers,
Willy


Changelog from 2.4.32-hf32.1 to 2.4.32-hf32.2
---------------------------------------
'+' = added ; '-' = removed

+ 2.4.32-wan-sdla-fix-probable-security-hole-1                       (Horms)

  [PATCH] wan sdla:  fix probable security hole
  Quoting Chris Wright : "Hrm, I believe you could use this to read 128k
  of kernel memory. sdla_read() takes len as a short, whereas mem.len is
  an int. So, if mem.len == 0x20000, the allocation could still succeed.
  When cast to short, len will be 0x0, causing the read loop to copy
  nothing into the buffer. At least it's protected by a capable() check.
  I don't know what proper upper bound is for this hardware, or how much
  it's used/cared about. Simple memset() is trivial fix."
  This seems to be applicable to 2.4.

+ 2.4.32-CAN-2004-1058-proc_pid_cmdline-race-fix-1            (dann frazier)

  The following patch fixes a race condition that allows local users to
  view the environment variables of another process. Taken from Red Hat's
  kernel-2.4.21-27.0.4.EL.src.rpm.

+ 2.4.32-bond_alb-hash-table-corruption-1                (ODonnell, Michael)

  Our systems have been crashing during testing of PCI HotPlug
  support in the various networking components. We've faulted in
  the bonding driver due to a bug in bond_alb.c:tlb_clear_slave().
  In that routine, the last modification to the TLB hash table is
  made without protection of the lock, allowing a race that can
  lead tlb_choose_channel() to select an invalid table element.

+ 2.4.32-rc2-mcast-filter-1                                  (Willy Tarreau)

  [PATCH-2.4][MCAST]IPv6: small fix for ip6_mc_msfilter(...)
  Multicast source filters aren't widely used yet, and that's really
  the only feature that's affected if an application actually exercises
  this bug, as far as I can tell. An ordinary filter-less multicast join
  should still work, and only forwarded multicast traffic making use of
  filters and doing empty-source filters with the MSFILTER ioctl would
  be at risk of not getting multicast traffic forwarded to them because
  the reports generated would not be based on the correct counts.
  Initial 2.6 patch by Yan Zheng, bug explanation by David Stevens,
  patch ACKed by David.

--
Willy Tarreau - http://w.ods.org/ 
EXOSEC - ZAC des Metz - 3 Rue du petit robinson - 78350 JOUY EN JOSAS
N°Indigo: 0 825 075 510 - Accueil: +33 1 72 89 72 30 - Fax: +33 1 72 89 80 19
Site web : http://www.exosec.fr/

