Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261666AbSJMNwz>; Sun, 13 Oct 2002 09:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261639AbSJMNwy>; Sun, 13 Oct 2002 09:52:54 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:46111 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S261644AbSJMNww>; Sun, 13 Oct 2002 09:52:52 -0400
Date: Sun, 13 Oct 2002 14:59:32 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Walter Haidinger <walter.haidinger@gmx.at>
cc: "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: isofs: cruft option with volume_seq_no? (patch included)
In-Reply-To: <Pine.LNX.4.44.0210131403580.25059-100000@banshee.dnsalias.org>
Message-ID: <Pine.LNX.4.44.0210131457290.1485-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Oct 2002, Walter Haidinger wrote:
> 
> If you create an iso image with mkisofs and use the -volset-seqno option,
> any subsequent mount attempt will result in the following message:
> 
> kernel: Warning: defective CD-ROM (volume sequence number 2). Enabling
> "cruft" mount option.
> 
> Q: Why isn't this bug(?) fixed yet?

Summary of changes from v2.5.41 to v2.5.42
============================================

<Andries.Brouwer@cwi.nl>
	[PATCH] isofs fix
	
	The patch below removes some dead code and nonsense code.
	The part that changes behaviour is
	
	 -       if (sbi->s_cruft == 'n' &&
	 -           (volume_seq_no != 0) && (volume_seq_no != 1)) {
	 -               printk(KERN_WARNING "Warning: defective CD-ROM "
	 -                      "(volume sequence number %d). "
	 -                      "Enabling \"cruft\" mount option.\n", volume_seq_no);
	 -               sbi->s_cruft = 'y';
	 -       }
	
	that has already bitten lots of people.
	
	Nothing is wrong with a volume sequence number different from 0 or 1.
	(Cf. Ecma-119.pdf, Sections 4.17, 4.18, 6.6.)

