Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264740AbTGHCr1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 22:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266233AbTGHCr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 22:47:27 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24215 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264740AbTGHCr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 22:47:26 -0400
Date: Mon, 07 Jul 2003 19:53:50 -0700 (PDT)
Message-Id: <20030707.195350.39170946.davem@redhat.com>
To: hch@infradead.org
Cc: jmorris@intercode.com.au, TSPAT@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: crypto API and IBM z990 hardware support
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030707080929.A1848@infradead.org>
References: <OF1BACB1D3.F4409038-ONC1256D57.00247A0A-C1256D57.002701D8@de.ibm.com>
	<Mutt.LNX.4.44.0307021913540.31308-100000@excalibur.intercode.com.au>
	<20030707080929.A1848@infradead.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Christoph Hellwig <hch@infradead.org>
   Date: Mon, 7 Jul 2003 08:09:29 +0100

   On Wed, Jul 02, 2003 at 07:35:16PM +1000, James Morris wrote:
   > So, there might be:
   > 
   > crypto/aes.c
   > crypto/arch/i386/aes.s
   
   crypto/arch/ sounds like a bad idea.  We really should avoid arch code
   outside arch/ and include/asm*.  So arch/<foo>/crypto/ as suggested by
   Thomas is much better.
   
I totally disagree.  I think the way we do things today is _STUPID_.
We put arch code far away from the generic version which makes finding
stuff very difficult for people inspecting the code for the first time.

For example, the fact that I have to go groveling in
arch/foo/lib/whoknowswhatfile.whoknowswhatextension to look at
the memcpy/checksum/whatever implementation is completely busted.

So, I totally support making crypto/arch/ directories.
