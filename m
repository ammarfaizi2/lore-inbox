Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272971AbTHEXOs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 19:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272974AbTHEXOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 19:14:48 -0400
Received: from www.13thfloor.at ([212.16.59.250]:65179 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S272971AbTHEXOk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 19:14:40 -0400
Date: Wed, 6 Aug 2003 01:14:49 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: RO --bind mount implementation ...
Message-ID: <20030805231449.GD2594@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: viro@parcelfarce.linux.theplanet.co.uk,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20030804221615.GA18521@www.13thfloor.at> <20030805165924.GF12757@parcelfarce.linux.theplanet.co.uk> <20030805225149.GC2594@www.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030805225149.GC2594@www.13thfloor.at>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 12:51:49AM +0200, Herbert Pötzl wrote:
> On Tue, Aug 05, 2003 at 05:59:24PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > On Tue, Aug 05, 2003 at 12:16:15AM +0200, Herbert Pötzl wrote:
> >  
> > > anyway, I discussed this with some friends, and
> > > they pointed out that this would be useful ...
> > > so here is the first try ...
> > 
> > Umm...  You know, the most obvious system call that should care about
> > read-only is open(pathname, O_RDWR) ;-)  IOW, taking care of directory
> > modifications is not enough - you need to deal with
> > 	* opening file for write
> > 	* truncation (both from *truncate() and from open() with O_TRUNC)
> > 	* metadata changes (timestamps, ownership, permissions)
> 
> well, the open case, IMHO is handled by the
> lookup_create() modifications, truncate is something

more descriptive would have been:
- I guess this is handled in open_namei() by

     error = -EROFS;
     if ((flag & 2) && (IS_RDONLY(inode) || MNT_IS_RDONLY(nd->mnt)))
            goto exit;

> best,
> Herbert
