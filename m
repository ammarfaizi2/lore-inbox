Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbUCYPTx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 10:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbUCYPTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 10:19:52 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:38060 "EHLO
	mailout.schmorp.de") by vger.kernel.org with ESMTP id S263199AbUCYPSP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 10:18:15 -0500
Date: Thu, 25 Mar 2004 16:18:02 +0100
From: Marc Lehmann <pcg@schmorp.de>
To: Michael Frank <mhf@linuxmail.org>
Cc: Pavel Machek <pavel@suse.cz>,
       Software Suspend - Mailing Lists 
	<swsusp-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] (no subject)
Message-ID: <20040325151802.GD11633@schmorp.de>
Mail-Followup-To: Michael Frank <mhf@linuxmail.org>,
	Pavel Machek <pavel@suse.cz>,
	Software Suspend - Mailing Lists <swsusp-devel@lists.sourceforge.net>,
	kernel list <linux-kernel@vger.kernel.org>
References: <opr49atvpk4evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opr49atvpk4evsfm@smtp.pacific.net.th>
X-Operating-System: Linux version 2.6.4 (root@cerebro) (gcc version 3.3.3 20040125 (prerelease) (Debian)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 05:18:57PM +0800, Michael Frank <mhf@linuxmail.org> wrote:
> Also, as Pavel mentioned, LZF code should be put in /lib and cleaned up. 

I fully agree. Unfortunately, I have about zero time for any such project
in the foreseeable future (It'd need more time since my knowledge about
integration issues is extremely scarce, and I am swamped with other work).

The code in the kernel required a few features not available with earlier
lzf releases (e.g. passing the the hash table via args instead of
allocating it on the stack).

The standard 1.3 release is configurable via defines in this respect
(-DAVOID_ERRNO -DLZF_STATE_ARG), and would be better suited for inclusion
in the kernel (the code would be byte-identical in the userspace and
kernel version), but making a patch would require some testing, to make
sure the new code compiles etc.

Also, as used in software-suspend2, the user must #define symbols (see
the beginning of kernel/power/lzfcompress.c) and include the c files
directly. When making them library functions one would need to choose
a reasonable default. Copying lzfP.h into include/linux and editing it
should be enough, though.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
