Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWC0PUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWC0PUa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 10:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWC0PUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 10:20:30 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:1731 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751083AbWC0PU3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 10:20:29 -0500
Date: Mon, 27 Mar 2006 08:20:26 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Bodo Eggert <7eggert@gmx.de>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] Move SG_GET_SCSI_ID from sg to scsi
Message-ID: <20060327152026.GG3486@parisc-linux.org>
References: <Pine.LNX.4.58.0603262108500.13001@be1.lrz> <20060326200522.GA3486@parisc-linux.org> <Pine.LNX.4.58.0603271158360.3209@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0603271158360.3209@be1.lrz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 12:11:14PM +0200, Bodo Eggert wrote:
> > > +			__put_user(0, &idp->unused[0]);
> > > +			__put_user(0, &idp->unused[1]);
> > 
> > Is it time to repurpose the unused bytes for the 64-bit LUN?
> 
> ACK, but I didn't find out how to fill it, and having ints instead of
> __uXX made the struct look ugly. Therefore I postponed it to a later patch.

So we don't currently save the scsi_lun anywhere.  We, er, translate it
into a 32-bit int, and carry that around.  Obviously this is going to
have to change for things like iSCSI, but this is totally offtopic for
your patch.  So I agree with you, whoever adds the 64-bit LUN support
gets to patch the ioctl struct too.
