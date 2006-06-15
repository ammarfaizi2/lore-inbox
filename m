Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030340AbWFOMjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbWFOMjH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 08:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbWFOMjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 08:39:07 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:18055 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030340AbWFOMjF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 08:39:05 -0400
Date: Thu, 15 Jun 2006 13:39:03 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] affs_fill_super() %s abuses
Message-ID: <20060615123903.GR27946@ftp.linux.org.uk>
References: <20060615110355.GH27946@ftp.linux.org.uk> <Pine.LNX.4.64.0606151427290.17704@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606151427290.17704@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2006 at 02:31:05PM +0200, Roman Zippel wrote:
> > -		printk(KERN_NOTICE "AFFS: Mounting volume \"%*s\": Type=%.3s\\%c, Blocksize=%d\n",
> > -			AFFS_ROOT_TAIL(sb, root_bh)->disk_name[0],
> > -			AFFS_ROOT_TAIL(sb, root_bh)->disk_name + 1,
> > -			(char *)&chksum,((char *)&chksum)[3] + '0',blocksize);
> > +		int len = AFFS_ROOT_TAIL(sb, root_bh)->disk_name[0];
> > +		char name[32];
> > +
> > +		if (len > 31)
> > +			len = 31;
> 
> You get the same effect by changing it above into "min(AFFS_ROOT_TAIL(sb, 
> root_bh)->disk_name[0], 31)" and makes the copying unnecessary.
> BTW since this is only active with SF_VERBOSE, I don't think it's critical 
> enough for 2.6.17 at this point.

Fine by me...  I'd still prefer more explicit form (it's hardly a critical
path), but yes, that would do.
