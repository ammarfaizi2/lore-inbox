Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265339AbUBPEPJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 23:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265366AbUBPEPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 23:15:09 -0500
Received: from [80.72.36.106] ([80.72.36.106]:49095 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S265339AbUBPEPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 23:15:04 -0500
Date: Mon, 16 Feb 2004 05:14:58 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christophe Saout <christophe@saout.de>, linux-kernel@vger.kernel.org
Subject: Re: dm-crypt using kthread
In-Reply-To: <4030416E.9070805@pobox.com>
Message-ID: <Pine.LNX.4.58.0402160510360.26082@alpha.polcom.net>
References: <402A4B52.1080800@centrum.cz>  <1076866470.20140.13.camel@leto.cs.pocnet.net>
  <20040215180226.A8426@infradead.org>  <1076870572.20140.16.camel@leto.cs.pocnet.net>
  <20040215185331.A8719@infradead.org>  <1076873760.21477.8.camel@leto.cs.pocnet.net>
  <20040215194633.A8948@infradead.org>  <20040216014433.GA5430@leto.cs.pocnet.net>
  <20040215175337.5d7a06c9.akpm@osdl.org>  <Pine.LNX.4.58.0402160303560.26082@alpha.polcom.net>
 <1076900606.5601.47.camel@leto.cs.pocnet.net> <Pine.LNX.4.58.0402160409190.26082@alpha.polcom.net>
 <4030416E.9070805@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Feb 2004, Jeff Garzik wrote:

> Grzegorz Kulewski wrote:
> > Could somebody write dm-compress (compressing not encrypting)? Is it 
> > technically possible (can device mapper handle different data size at 
> > input, differet at output)? (I think there is compressing loop patch.)
> > Could dm first compress data (even with weak algorithm), then encrypt, to 
> > make statistical analysis harder?
> 
> 
> It's certainly possible, but you have to consider that data transfer 
> almost always should be considered in page-sized chunks.  For compress 
> that would imply you would need to allocate/free blocks and similar 
> duties that a filesystem must perform, simply because you do not have 
> one-to-one correspondence with blocks being passed to you.
> 
> You also have to consider that the kernel may request one or more pages 
> that are in the middle of a compressed run of pages.  For example, 
> consider an algorithm that compresses 16 pages into a run of 4 pages. 
> Later on, when the kernel requests (uncompressed) page 9, you likely 
> need to read all 4 pages, and allocate 16 more pages for decompression. 
>   So, reading 1 upper layer page required dm-compress tying up 20 pages.
> 

Yes, I understand that (at least I think so...). But Knopix (and probably 
other distros) use 2.4 with compressing loop patch, and I think somebody 
at Gentoo is trying to port that patch to 2.6 for Gentoo's LiveCD... So it 
was done somehow... (I do not know how, however.)


Grzegorz Kulewski

