Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbTFZSmy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 14:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTFZSmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 14:42:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46039 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262320AbTFZSmr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 14:42:47 -0400
Date: Thu, 26 Jun 2003 19:56:59 +0100
From: Matthew Wilcox <willy@debian.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Matthew Wilcox <willy@debian.org>, David Woodhouse <dwmw2@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BINFMT_ZFLAT can't be a module
Message-ID: <20030626185659.GR451@parcelfarce.linux.theplanet.co.uk>
References: <20030626180909.GP451@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0306262036030.11817-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306262036030.11817-100000@serv>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 26, 2003 at 08:40:05PM +0200, Roman Zippel wrote:
> > -	default y if CRAMFS=y || PPP_DEFLATE=y || JFFS2_FS=y || ZISOFS_FS=y || BINFMT_ZFLAT=y || CRYPTO_DEFLATE=y
> > -	default m if CRAMFS=m || PPP_DEFLATE=m || JFFS2_FS=m || ZISOFS_FS=m || BINFMT_ZFLAT=m || CRYPTO_DEFLATE=m
> > +	default y if CRAMFS=y || PPP_DEFLATE=y || JFFS2_FS=y || ZISOFS_FS=y || CRYPTO_DEFLATE=y || (BINFMT_FLAT=y && BINFMT_ZFLAT=y)
> > +	default m if CRAMFS=m || PPP_DEFLATE=m || JFFS2_FS=m || ZISOFS_FS=m || CRYPTO_DEFLATE=m || (BINFMT_FLAT=m && BINFMT_ZFLAT=y)
> 
> This can be simplified now to:
> 
> config ZLIB_INFLATE
> 	def_tristate CRAMFS || PPP_DEFLATE || JFFS2_FS || \
> 		     ZISOFS_FS || CRYPTO_DEFLATE || \
> 		     (BINFMT_FLAT && BINFMT_ZFLAT)

Could you document this in Documentation/kbuild/kconfig-language.txt
please?  The thing is, I'm not sure it'll work, and it's hard to convince
myself without docs.

Here's what I want:

CRAMFS	FLAT	ZFLAT	outcome
Y	Y	Y	Y
Y	Y	N	Y
Y	M	Y	Y
Y	M	N	Y
Y	N	-	Y

M	Y	Y	Y
M	Y	N	M (*)
M	M	Y	M
M	M	N	M
M	N	-	M

N	Y	Y	Y
N	Y	N	N
N	M	Y	M
N	M	N	N
N	N	-	N

Does dep_tristate give me that?  Particularly the one with a (*) by it.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
