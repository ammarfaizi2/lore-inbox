Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267008AbSLDSXr>; Wed, 4 Dec 2002 13:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267013AbSLDSXr>; Wed, 4 Dec 2002 13:23:47 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:17693 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id <S267008AbSLDSXp>; Wed, 4 Dec 2002 13:23:45 -0500
To: ak@muc.de, kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: rtnetlink replacement for SIOCSIFHWADDR
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 04 Dec 2002 10:31:14 -0800
Message-ID: <52wumpbpql.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Dec 2002 18:31:07.0140 (UTC) FILETIME=[4F508440:01C29BC3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, since you are the architects of the rtnetlink facility, I am
writing to you to ask your opinion on how to add some functionality.

I'm exploring what changes are needed in the kernel to support devices
with large addr_len.  My motivation is to get the infrastructure for
IP-over-InfiniBand, which has addr_len 20, into the kernel, and I am
trying to produce a patch that can be accepted into mainline 2.5.

With a few a minor fixes to avoid overrunning array bounds, almost
everything just works.  The RTM_NEWNEIGH and RTM_DELNEIGH messages
seem to provide what is needed to manage ARP entries with large L2
addresses (replacing the SIOCSARP and SIOCDARP ioctls).

The one major piece that is missing is a replacement for SIOCSIFHWADDR
(which can only set L2 addresses up to 14 bytes long, because of the
size of sa_data in struct sockaddr).  I can see two ways one might set
an interface's L2 address through rtnetlink:

  We could extend the RTM_NEWLINK message (possibly using the change
  mask) to include changing just the L2 address, and add support in
  the kernel for receiving these messages from userspace.

  Or, we could add a new RTM_SETLINK message that userspace can send
  to the kernel to modify an interface's properties.

Of course I am open to other suggestions for how to replace
SIOCSIFHWADDR.  I would very much appreciate your thoughts on how to
proceed.

Thanks,
  Roland <roland@topspin.com>
