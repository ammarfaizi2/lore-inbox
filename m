Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264514AbUFXNLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264514AbUFXNLZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 09:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUFXNIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 09:08:10 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:35087 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264649AbUFXNG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 09:06:29 -0400
Date: Thu, 24 Jun 2004 15:06:27 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: FabF <fabian.frederick@skynet.be>, Andries Brouwer <aebr@win.tue.nl>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.7-mm1] MBR centralization
Message-ID: <20040624130627.GG3072@pclin040.win.tue.nl>
References: <1088025348.2213.32.camel@localhost.localdomain> <20040623213629.GC3072@pclin040.win.tue.nl> <1088057276.1901.4.camel@localhost.localdomain> <Pine.LNX.4.60.0406240809280.29245@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0406240829550.29245@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0406240829550.29245@hermes-1.csi.cam.ac.uk>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : mailhost.tue.nl 1182; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 08:38:52AM +0100, Anton Altaparmakov wrote:

> While I am at it, the above macro is even further optimized by moving the 
> endianness conversion to the constant so it is applied at compile time 
> rather than run time like so:
> 
> #define MSDOS_MBR(p)	((*(u16*)(p)) == __constant_cpu_to_le16(0xaa55))

I never understand why people want to do such things.
Cast a character pointer to u16*, possibly do a byteswap, etc.
What one wants is just

	p[0] == 0x55 && p[1] == 0xaa
