Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932596AbVLFOsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbVLFOsz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 09:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751669AbVLFOsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 09:48:54 -0500
Received: from pat.uio.no ([129.240.130.16]:60152 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751676AbVLFOsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 09:48:53 -0500
Subject: Re: stat64 for over 2TB file returned invalid st_blocks
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Takashi Sato <sho@tnes.nec.co.jp>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1133879435.8895.14.camel@kleikamp.austin.ibm.com>
References: <000301c5fa62$8d1bb730$4168010a@bsd.tnes.nec.co.jp>
	 <1133879435.8895.14.camel@kleikamp.austin.ibm.com>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 09:48:36 -0500
Message-Id: <1133880516.9040.6.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.947, required 12,
	autolearn=disabled, AWL 1.05, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-06 at 08:30 -0600, Dave Kleikamp wrote:
> On Tue, 2005-12-06 at 21:42 +0900, Takashi Sato wrote:
> > I realized some 32-bit big-endian architectures such as sh and m68k
> > have a padding before 32-bit st_blocks, though mips and ppc have
> > 64-bit st_blocks.
> > 
> > - asm-sh
> > #if defined(__BIG_ENDIAN__)
> >         unsigned long   __pad4;         /* Future possible st_blocks hi bits */
> >         unsigned long   st_blocks;      /* Number 512-byte blocks allocated. */
> > #else /* Must be little */
> >         unsigned long   st_blocks;      /* Number 512-byte blocks allocated. */
> >         unsigned long   __pad4;         /* Future possible st_blocks hi bits */
> > #endif
> > 
> > - asm-m68k
> >         unsigned long   __pad4;         /* future possible st_blocks high bits */
> >         unsigned long   st_blocks;      /* Number 512-byte blocks allocated. */
> > 
> > So I updated the patch.  Any feedback and comments are welcome.
> 
> I think it looks good.  The only issue I have is that I agree with
> Andreas that i_blocks should be of type sector_t.  I find the case of
> accessing very large files over nfs with CONFIG_LBD disabled to be very
> unlikely.

NO! sector_t is a block-device specific type. It does not belong in the
generic inode.

Cheers,
  Trond

