Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271188AbTGWSbq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 14:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271199AbTGWSbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 14:31:46 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:46808 "HELO
	develer.com") by vger.kernel.org with SMTP id S271188AbTGWSbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 14:31:44 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
To: uClinux development list <uclinux-dev@uclinux.org>
Subject: Kernel 2.6 size increase
Date: Wed, 23 Jul 2003 20:46:46 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200307232046.46990.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

code bloat can be very harmful on embedded targets, but it's
generally inconvenient for any platform. I've measured the
code increase between 2.4.21 and 2.6.0-test1 on a small
kernel configuration for ColdFire:

   text    data     bss     dec     hex filename
 640564   39152  134260  813976   c6b98 linux-2.4.x/linux
 845924   51204   78896  976024   ee498 linux-2.5.x/vmlinux

I could provide the exact .config file for both kernels to
anybody interested. They are almost the same: no filesystems
except JFFS2, IPv4 and a bunch of small drivers. I have no
SMP, security, futexes, modules and anything else not
strictly needed to execute processes.

I've made a linker map file and compared the size of single
subsystems. These are the the major contributors to the
size increase:

  kernel/   +27KB
  mm/       +14KB
  fs/       +47KB
  drivers/  +35KB
  net/      +64KB

I've digged into net/ with nm -S --size-sort. It seems that
the major increase is caused by net/xfrm/. Could this module
be made optional?

In fs/, almost all modules have got 30-40% bigger, therefore
bloat is probably caused by inlines and macros getting more
complex.

Block drivers and MTD have generally become smaller. Character
devices are responsable for most of the size increase in drivers/.

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


