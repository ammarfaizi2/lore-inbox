Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266598AbUFYJjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266598AbUFYJjx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 05:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266624AbUFYJjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 05:39:53 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:49418 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S266598AbUFYJju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 05:39:50 -0400
Date: Fri, 25 Jun 2004 11:39:48 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Andries Brouwer <aebr@win.tue.nl>, FabF <fabian.frederick@skynet.be>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.7-mm1] MBR centralization
Message-ID: <20040625093948.GA4946@pclin040.win.tue.nl>
References: <1088025348.2213.32.camel@localhost.localdomain> <20040623213629.GC3072@pclin040.win.tue.nl> <1088057276.1901.4.camel@localhost.localdomain> <Pine.LNX.4.60.0406240809280.29245@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0406240829550.29245@hermes-1.csi.cam.ac.uk> <20040624130627.GG3072@pclin040.win.tue.nl> <1088152223.16286.9.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088152223.16286.9.camel@imp.csi.cam.ac.uk>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : mailhost.tue.nl 1182; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 09:30:24AM +0100, Anton Altaparmakov wrote:
> On Thu, 2004-06-24 at 14:06, Andries Brouwer wrote:
> > On Thu, Jun 24, 2004 at 08:38:52AM +0100, Anton Altaparmakov wrote:
> > > While I am at it, the above macro is even further optimized by moving the 
> > > endianness conversion to the constant so it is applied at compile time 
> > > rather than run time like so:
> > > 
> > > #define MSDOS_MBR(p)	((*(u16*)(p)) == __constant_cpu_to_le16(0xaa55))
> > 
> > I never understand why people want to do such things.
> > Cast a character pointer to u16*, possibly do a byteswap, etc.
> > What one wants is just
> > 
> > 	p[0] == 0x55 && p[1] == 0xaa
> 
> I would disagree.  Seeing something like "is_msdos_mbr(p)" it is
> immediately obvious what it means while seeing the "p[0] = 0x55 && p[1]
> = 0xaa" it is not obvious at all what it means.  IMO _any_ hardcoded
> value is a very bad thing

Ha Anton - you cannot read.
I complain about this strange casting, and you start talking about hardcoded
values (while you write 0xaa55 yourself). The current code is below - a good
name and no hardcoded constants and no strange casts.

Andries


#define MSDOS_LABEL_MAGIC1      0x55
#define MSDOS_LABEL_MAGIC2      0xAA

static inline int
msdos_magic_present(unsigned char *p)
{
        return (p[0] == MSDOS_LABEL_MAGIC1 && p[1] == MSDOS_LABEL_MAGIC2);
}
