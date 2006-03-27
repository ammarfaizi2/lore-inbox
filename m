Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbWC0KL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbWC0KL0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 05:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWC0KL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 05:11:26 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:14791 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750839AbWC0KLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 05:11:25 -0500
Date: Mon, 27 Mar 2006 12:11:14 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Matthew Wilcox <matthew@wil.cx>
cc: Bodo Eggert <7eggert@gmx.de>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Move SG_GET_SCSI_ID from sg to scsi
In-Reply-To: <20060326200522.GA3486@parisc-linux.org>
Message-ID: <Pine.LNX.4.58.0603271158360.3209@be1.lrz>
References: <Pine.LNX.4.58.0603262108500.13001@be1.lrz>
 <20060326200522.GA3486@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Mar 2006, Matthew Wilcox wrote:

> On Sun, Mar 26, 2006 at 09:28:28PM +0200, Bodo Eggert wrote:
> >          case SCSI_IOCTL_GET_PCI:
> >                  return scsi_ioctl_get_pci(sdev, arg);
> > +	case SG_GET_SCSI_ID:
> 
> You're using the old ioctl name here ...

Bad, bad, bad ...

> > +		if (!access_ok(VERIFY_WRITE, arg, sizeof (struct scsi_ioctl_id)))
> > +			return -EFAULT;
> > +		else {
> > +			struct scsi_ioctl_id __user *idp = arg;
> > +
> > +			__put_user((int) sdev->host->host_no,
> > +				   &idp->host_no);
> 
> The cast isn't necessary; __put_user casts the argument to the type of
> the pointer.

Nice.

> > +			__put_user(0, &idp->unused[0]);
> > +			__put_user(0, &idp->unused[1]);
> 
> Is it time to repurpose the unused bytes for the 64-bit LUN?

ACK, but I didn't find out how to fill it, and having ints instead of
__uXX made the struct look ugly. Therefore I postponed it to a later patch.

> > +struct scsi_ioctl_id { /* used by SCSI_IOCTL_GET_ID ioctl() */
> > +    int host_no;        /* as in "scsi<n>" where 'n' is one of 0, 1, 2 etc */
> 
> tabs instead of spaces?

Will look at it.
-- 
 In:  DATA
 Out: 554 Error: no valid recipients
 In:  Received: from unknown (190.106.166.70)       -- SMTP-Dialog,
 Out: 221 Error: I can break rules, too. Goodbye.      found in d.a.n.m
