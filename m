Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315202AbSFXTkV>; Mon, 24 Jun 2002 15:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315204AbSFXTkU>; Mon, 24 Jun 2002 15:40:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:34528 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315202AbSFXTkT>;
	Mon, 24 Jun 2002 15:40:19 -0400
Date: Mon, 24 Jun 2002 12:33:56 -0700 (PDT)
Message-Id: <20020624.123356.82809701.davem@redhat.com>
To: manand@us.ibm.com
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: efficient copy_to_user and copy_from_user routines in Linux
 Kernel
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <OFCB119CD8.D6AE7B3D-ON85256BE2.006AC911@raleigh.ibm.com>
References: <OFCB119CD8.D6AE7B3D-ON85256BE2.006AC911@raleigh.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Mala Anand" <manand@us.ibm.com>
   Date: Mon, 24 Jun 2002 14:34:08 -0500

   The 2.5.19 copy routines use the movsl instruction.  We found that when the
   src or dst addresses are not aligned on 8 bytes, performance can be
   improved
   by using the integer registers instead of the movsl instruction.  For
   tcpip,
   the src or dst addresses are often misaligned.

If the code is going to become so much larger, move the implementation
out of the header file and into arch/i386/lib/foo.S

It makes no sense to inline it anymore if it is going to be
implemented with so many instructions.
