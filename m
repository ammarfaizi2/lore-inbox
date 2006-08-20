Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWHTPdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWHTPdc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 11:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWHTPdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 11:33:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:64646 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750822AbWHTPdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 11:33:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X7f5bb9WJxL/PqU1NVA1yGm2tTboT/LhZX+W6JbG90dAGaieO9Ug9PMU40nwbamgiOlM3y2Ym3ceUBBfWs5O9aRC/pf9mTMRcF5VZzjBbHaHXLoqapGfzvR8QfEUxHVWzzwZh3hvTepP4VIozCs1veGyUj7rHg9TRhxDt9iTVLw=
Message-ID: <70b6f0bf0608200833r46305438x783e62b4827db0ef@mail.gmail.com>
Date: Sun, 20 Aug 2006 08:33:29 -0700
From: "Val Henson" <val.henson@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [PATCH] ext2: avoid needless discard of preallocated blocks
Cc: "Ron Yorston" <rmy@tigress.co.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       "Mingming Cao" <cmm@us.ibm.com>
In-Reply-To: <1156087499.23756.39.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608171945.k7HJjaLk029781@tiffany.internal.tigress.co.uk>
	 <20060819224603.bf687be2.akpm@osdl.org>
	 <200608201148.k7KBm8XA005948@tiffany.internal.tigress.co.uk>
	 <1156087499.23756.39.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Sun, 2006-08-20 at 12:48 +0100, Ron Yorston wrote:
> > Andrew Morton <akpm@osdl.org> wrote:
> > >Been there, done that.  The problem was that hanging onto the preallocation
> > >will cause separate files to have up-to-seven-block gaps between them.  So
> > >if you put a large number of small files in the same directory, the time to
> > >read them all back is quite significantly impacted: they cover a lot more
> > >disk.
> >
> > The preallocation is only held while the file is open, so there will only
> > be gaps between files that are open simultaneously.  If they're created
> > sequentially there will be no gap.
> >
> > This issue exists even with the current code.
> >
> > The patch will have a small effect.  With the current code an open file
> > will lose its preallocation when some other process touches the inode.
> > In that case a subsequently created file will follow without a gap.  As
> > soon as the open file is written to, though, it gets a new preallocation.
> > -
>
> maybe porting the reservation code to ext2 (as Val has done) is a nicer
> long term solution..

The even nicer solution long term solution is to abstract out the
reservation code as much as possible and share it.   But if you want
my (hasty and unlovely) port, you can grab it out of this patch:

http://infohost.nmt.edu/~val/patches/fswide_latest_patch

I'm not sure what benchmark to use to test the performance; our
initial benchmarks (run by Zach Brown) didn't show an improvement (see
the OLS paper).

-VAL
