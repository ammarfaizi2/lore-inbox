Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbVLAVQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbVLAVQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 16:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbVLAVQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 16:16:58 -0500
Received: from fep32-0.kolumbus.fi ([193.229.0.63]:43502 "EHLO
	fep32-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S932480AbVLAVQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 16:16:57 -0500
Date: Thu, 1 Dec 2005 23:17:09 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Linus Torvalds <torvalds@osdl.org>,
       Ryan Richter <ryan@tau.solarneutrino.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Fw: crash on x86_64 - mm related?
In-Reply-To: <1133468882.5232.14.camel@mulgrave>
Message-ID: <Pine.LNX.4.63.0512012304240.5777@kai.makisara.local>
References: <20051129092432.0f5742f0.akpm@osdl.org> 
 <Pine.LNX.4.63.0512012040390.5777@kai.makisara.local> 
 <Pine.LNX.4.64.0512011136000.3099@g5.osdl.org> <1133468882.5232.14.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2005, James Bottomley wrote:

> On Thu, 2005-12-01 at 11:38 -0800, Linus Torvalds wrote:
> > Ryan, can you test 2.6.15-rc4 and report what it does?
> > 
> > The "Bad page state" messages may (should) remain, but the crashes should 
> > be gone and the machine should hopefully continue functioning fine. And, 
> > perhaps more importantly, you should hopefully have a _new_ message about 
> > incomplete pfn mappings that should help pinpoint which driver causes 
> > this..
> 
> On a side note, I have Kai's patch in the scsi-rc-fixes tree which I'm
> getting ready to push.  Can we get a consensus on whether it should be
> removed before I merge upwards?
> 
I think it should be removed because it is based partly on a wrong 
assumption: asynchronous writes are _not_ done together with direct i/o. 
(I have also experimentally verified that this does not happen.)

The patch includes the patch I sent sent to linux-scsi on Nov 21. Nobody 
has commented it and I don't know if the user pages have to be explicitly 
marked dirty after the HBA has read data there. If they have to, then this 
earlier patch is valid. If not, I will send a patch for 2.6.16 to remove 
the latent code.

-- 
Kai
