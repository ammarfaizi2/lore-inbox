Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285241AbRLFV7g>; Thu, 6 Dec 2001 16:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285240AbRLFV71>; Thu, 6 Dec 2001 16:59:27 -0500
Received: from pizda.ninka.net ([216.101.162.242]:48011 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285241AbRLFV65>;
	Thu, 6 Dec 2001 16:58:57 -0500
Date: Thu, 06 Dec 2001 13:58:45 -0800 (PST)
Message-Id: <20011206.135845.107259299.davem@redhat.com>
To: greearb@candelatech.com
Cc: marcelo@conectiva.com.br, matthias.andree@stud.uni-dortmund.de,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.17-pre5
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C0FDFA4.2060701@candelatech.com>
In-Reply-To: <Pine.LNX.4.21.0112061705130.21518-100000@freak.distro.conectiva>
	<3C0FDFA4.2060701@candelatech.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Greear <greearb@candelatech.com>
   Date: Thu, 06 Dec 2001 14:14:12 -0700

   Perhaps Dave could summarize it in < 50 lines.  That would
   be a whole heap better than having to read the patch to try
   to figure out what changed....
   
My summary was to him was much less than 50 lines.
In fact, here it is:

1) DecNET doc and code fixes from it's maintainer, Steven
   Whitehouse.

2) You accidently reverted earlier socket.h LLC additions.
   I assume it's because the networking patch I sent you
   had it, yet it was already in your tree, and when Patch
   complained you told it "treat as -R". :(

   This should fix that.

3) VLAN fixes, in particular stop OOPS on module unload.
   Also fix the build when VLAN is non-modular.

4) ip_fw_compat_redir can loose it's timer, fix from netfilter
   maintainers.

5) ipt_unclean module handles ECN bits incorrectly.
   Fix from netfilter maintainers.

6) Ipv4 TCP error handling looks up listening socket
   children incorrectly.  src/dest need to be reversed
   in such cases.

   IPv6 has the same bug, but Alexey needs some more time
   to clean up that stuff.

7) SunRPC's csum_partial_copy_to_page_cache() does not handle
   odd lengths correctly.  Checksums needs to be combined
   using csum_block_add() and friends in order to handle this
   odd length case.
