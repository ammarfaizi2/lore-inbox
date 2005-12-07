Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbVLGPfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbVLGPfj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 10:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbVLGPfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 10:35:39 -0500
Received: from pat.uio.no ([129.240.130.16]:18135 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751141AbVLGPff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 10:35:35 -0500
Subject: RE: stat64 for over 2TB file returned invalid st_blocks
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Takashi Sato <sho@tnes.nec.co.jp>,
       "'Andreas Dilger'" <adilger@clusterfs.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <1133967716.8910.5.camel@kleikamp.austin.ibm.com>
References: <000001c5fb1d$0a27c8d0$4168010a@bsd.tnes.nec.co.jp>
	 <1133963528.27373.4.camel@lade.trondhjem.org>
	 <1133967716.8910.5.camel@kleikamp.austin.ibm.com>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 10:34:30 -0500
Message-Id: <1133969671.27373.47.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.111, required 12,
	autolearn=disabled, AWL 1.70, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 09:01 -0600, Dave Kleikamp wrote:
> On Wed, 2005-12-07 at 08:52 -0500, Trond Myklebust wrote:
> > On Wed, 2005-12-07 at 19:57 +0900, Takashi Sato wrote:
> > 
> > > On my previous mail, I said that CONFIG_LBD should not determine
> > > whether large single files is enabled.  But after further
> > > consideration, on such a small system that CONFIG_LBD is disabled,
> > > using large filesystem over network seems to be very rare.
> > > So I think that the type of i_blocks should be sector_t.
> > 
> > ???? Where do you get this misinformation from?
> 
> Without some kind of counter-example, I would tend to agree with
> Takashi.  In what scenerio would someone build a kernel with CONFIG_LBD
> disabled, yet would be needing to access files > 2TB across the network?

The word "filesystem" confused me. In my experience > 2TB filesystems
tend to be the norm for NFS shared systems these days, and so the fact
that 'struct kstatfs' uses sector_t irks me.
Access to > TB files is not unheard of in HPC circles (particularly in
the case of simulations), but these files tend to be pretty sparse, so
the block counts are not necessarily that large.

My point stands, though. whether or not sector_t may indeed be the right
size as far as i_block is concerned, a quick grep through (fs|block)/*.c
shows you that as a type, it is anything but a count of the number of
blocks in a file.

If you really want a variable size type here, then the right thing to do
is to define a __kernel_blkcnt_t or some such thing, and hide the
configuration knob for it somewhere in the arch-specific Kconfigs.

Cheers,
  Trond

