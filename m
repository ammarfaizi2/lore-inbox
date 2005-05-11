Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVEKLeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVEKLeI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 07:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVEKLeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 07:34:07 -0400
Received: from aun.it.uu.se ([130.238.12.36]:50621 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261210AbVEKLeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 07:34:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17025.60829.58835.194099@alkaid.it.uu.se>
Date: Wed, 11 May 2005 13:33:49 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jack F Vogel <jfv@bluesong.net>, Andi Kleen <ak@muc.de>,
       notting@redhat.com
Subject: Re: [PATCH] check nmi watchdog is broken
In-Reply-To: <20050511055540.GA27052@redhat.com>
References: <200505011704.j41H4SUQ021132@hera.kernel.org>
	<20050511055540.GA27052@redhat.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones writes:
 > My EM64T Dell Precision 470 seems to have problems both before
 > and after this change, though the behaviour changes.
 > 
 > With -rc3..
 > testing NMI watchdog ... CPU#1: NMI appears to be stuck (0)!
 > 
 > With -rc4...
 > Testing NMI watchdog ... CPU#4: NMI appears to be stuck (0)!
 > 
 > The CPU #'s are consistent across reboots (Ie, they're always the same).
 > Though the rc4 behaviour seems odd, as my CPUs are numbered 0-3.

There is known breakage in x86-64's nmi watchdog recently.
One of the problems is that the checking code inspects
all possible CPU numbers [0..NR_CPUS[ and not just the
ones actually present, which leads to false failure reports.

 > Bill (Cc'd) also reports that with -rc4, he sees around
 > a 10 second delay when it does that 'Testing NMI watchdog'
 > message.

And that's another of the known x86-64 breakages.

/Mikael
