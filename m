Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317424AbSGVOEe>; Mon, 22 Jul 2002 10:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317432AbSGVOEe>; Mon, 22 Jul 2002 10:04:34 -0400
Received: from nameservices.net ([208.234.25.16]:59934 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S317424AbSGVODU>;
	Mon, 22 Jul 2002 10:03:20 -0400
Message-ID: <3D3C11BA.F195FB15@opersys.com>
Date: Mon, 22 Jul 2002 10:07:54 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: SMP clusters implementation details
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In continuing my work on the Adeos nanokernel and following many
discussions at the OLS, I concentrated on the idea of running
multiple Linux kernels in parallel on SMP hardware in order to
obtain SMP clusters. What started as a high-level investigation
eventually turned out to be an in-depth search for a viable
architecture.

At this point, I think I have figured out the exact components
required (including how to boot multiple independent Linux kernels
on SMP hardware), their interactions, and the additions to be
developed. I wrote a paper (see link at the bottom) detailing
these issues in order to encourage discussion over the ideas and
techniques.

Instead of a high-level overview or an explanation of the virtues
of SMP clusters, this paper presents many low-level implementation
details and outlines the exact steps required to obtain a fully
functional system.

To get there, I looked at a lot of previous work. Running multiple
OS instances on the same hardware to enhance scalability is an idea
that has actually been investigated before. The most documented
example is Disco (which was implemented by the very folks that
eventually brought us VMWare). Disco is a virtual machine monitor
that enables multiple IRIX kernels to coexist on the same hardware.

The main "flaw" of the approach is that the authors started with
assumption that modifying the OS to run multiple copies of it
wasn't permitted. The architecture described in my paper is based
on the assumption that minor kernel modifications are permitted
as long as they are very isolated and easily removable. Hence,
no virtualization whatsoever.

These are the main features of the architecture being presented:
o No changes to the kernel's virtual memory code.
o No changes to the kernel's scheduler.
o No changes to the kernel's lock granularity.
o Minimal low-level changes to kernel code.
o Reuse of many existing software components.
o Short-term accessibility.

Paper title:
A Practical Approach to Linux Clusters on SMP Hardware

Paper outline:
 1. Introduction
 2. Previous work
 3. Overall system architecture
 4. Adeos nanokernel
 5. Kernel-mode bootloader
 6. Linux kernel changes
 7. Virtual devices
 8. Clustering and single system image components
 9. Work ahead
10. Caveats and future work
11. Conclusion

The paper is 12 pages long, including references, and should make
for an interesting read even if you aren't interested in clustering
or scalability.

I could go on and provide more details, but if you're still
reading this, then you better grab the paper and have a look for
yourself.

Here's the paper in various formats:
Postscript:
http://www.opersys.com/ftp/pub/Adeos/practical-smp-clusters.ps
PDF:
http://www.opersys.com/ftp/pub/Adeos/practical-smp-clusters.pdf
HTML:
http://www.opersys.com/adeos/practical-smp-clusters/

Feedback and suggestions on the architecture being presented are
encouraged.

Best regards,

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
