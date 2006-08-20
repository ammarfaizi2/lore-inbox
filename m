Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWHTPZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWHTPZF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 11:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWHTPZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 11:25:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14569 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750812AbWHTPZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 11:25:03 -0400
Subject: Re: [PATCH] ext2: avoid needless discard of preallocated blocks
From: Arjan van de Ven <arjan@infradead.org>
To: Ron Yorston <rmy@tigress.co.uk>
Cc: Val Henson <val.henson@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <200608201148.k7KBm8XA005948@tiffany.internal.tigress.co.uk>
References: <200608171945.k7HJjaLk029781@tiffany.internal.tigress.co.uk>
	 <20060819224603.bf687be2.akpm@osdl.org>
	 <200608201148.k7KBm8XA005948@tiffany.internal.tigress.co.uk>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 20 Aug 2006 17:24:59 +0200
Message-Id: <1156087499.23756.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-20 at 12:48 +0100, Ron Yorston wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >Been there, done that.  The problem was that hanging onto the preallocation
> >will cause separate files to have up-to-seven-block gaps between them.  So
> >if you put a large number of small files in the same directory, the time to
> >read them all back is quite significantly impacted: they cover a lot more
> >disk.
> 
> The preallocation is only held while the file is open, so there will only
> be gaps between files that are open simultaneously.  If they're created
> sequentially there will be no gap.
> 
> This issue exists even with the current code.
> 
> The patch will have a small effect.  With the current code an open file
> will lose its preallocation when some other process touches the inode.
> In that case a subsequently created file will follow without a gap.  As
> soon as the open file is written to, though, it gets a new preallocation.
> -

maybe porting the reservation code to ext2 (as Val has done) is a nicer
long term solution..

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

