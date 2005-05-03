Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVECVCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVECVCz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 17:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVECVCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 17:02:55 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:602 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261700AbVECVCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 17:02:50 -0400
Date: Tue, 3 May 2005 14:02:47 -0700
From: Greg KH <gregkh@suse.de>
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [PATCH 2.6.11.8] SCSI tape security: require CAP_SYS_RAWIO for SG_IO etc.
Message-ID: <20050503204614.GA15976@suse.de>
References: <Pine.LNX.4.61.0504301055500.21122@kai.makisara.local> <Pine.LNX.4.61.0505012051300.6783@kai.makisara.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505012051300.6783@kai.makisara.local>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2005 at 08:56:06PM +0300, Kai Makisara wrote:
> On Sat, 30 Apr 2005, Kai Makisara wrote:
> 
> > The patch at the end is against 2.6.11.8.
> > 
> > The kernel currently allows any user permitted to access the tape device file
> > to send the tape drive commands that may either make the tape drivers internal
> ...
> > filtering. This patch solves the problem for tapes and no more elaborate
> > patches are needed. If those are merged to the kernel, this patch can be reversed.
> > 
> > Signed-off-by: Kai Makisara <kai.makisara@kolumbus.fi>
> > 
> > --- linux-2.6.11.8/drivers/scsi/st.c	2005-03-03 21:10:36.000000000 +0200
> > +++ linux-2.6.11.8-k1/drivers/scsi/st.c	2005-04-30 09:57:21.000000000 +0300
> > @@ -3414,7 +3414,10 @@ static int st_ioctl(struct inode *inode,
> >  		case SCSI_IOCTL_GET_BUS_NUMBER:
> >  			break;
> >  		default:
> > -			i = scsi_cmd_ioctl(file, STp->disk, cmd_in, p);
> > +			if (!capable(CAP_SYS_RAWIO))
> > +				i = -EPERM;
> > +			else
> > +				i = scsi_cmd_ioctl(file, STp->disk, cmd_in, p);
> >  			if (i != -ENOTTY)
> >  				return i;
> >  			break;
> 
> Please hold this patch. Testing the corresponding patch for 2.6.12-rc
> showed that this is too restrictive. Best to wait until the next versions 
> will be reviewed on the linux-scsi list and merged into -rc.

Ok, when you come up with something that is acceptable, care to email it
also to the stable@kernel.org people?

thanks,

greg k-h
