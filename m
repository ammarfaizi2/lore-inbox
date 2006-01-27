Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWA0HRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWA0HRq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 02:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWA0HRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 02:17:46 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:19641
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932295AbWA0HRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 02:17:46 -0500
Date: Thu, 26 Jan 2006 23:17:49 -0800
From: Greg KH <gregkh@suse.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] debugfs: hard link count wrong
Message-ID: <20060127071749.GA13924@suse.de>
References: <20060126141142.GA11599@osiris.boeblingen.de.ibm.com> <20060127032513.GA12559@suse.de> <20060127055607.GA9331@osiris.boeblingen.de.ibm.com> <20060127063804.GA4680@suse.de> <20060127070423.GB9331@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127070423.GB9331@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 08:04:23AM +0100, Heiko Carstens wrote:
> > > > Device: eh/14d  Inode: 15528       Links: 2
> > > Links should be 3, I thought? For an empty directory it's 2 and as soon as
> > > you create a new directory in there it should be increased by 1. Therefore
> > > it should be 3. Or am I missing something?
> > 
> > Yeah, I think you are correct.  But I don't see where in the debugfs
> > code I messed this up...
> > 
> > In debugfs_mkdir() we increment the parent i_nlink properly if we create
> > the new subdirectory, and based on other implementations like this
> > (usbfs), that logic seems to be correct.
> > 
> > Unless something is odd with creating a directory in the root of the fs.
> > Does the subdirectory you have created have the proper number of links?
> 
> Yes, everything below the debug directory itself seems to be ok.
> 
> > > Btw.: my find version: "GNU find version 4.2.20".
> > Hm, newer versions of find don't complain about this?
> 
> The latest version I could find at http://ftp.gnu.org/pub/gnu/findutils/
> is 4.2.27 which still complains. No, idea from where you got the 4.2.30 :)

I'm running 4.3.0, not 4.2.30.  I don't know where it came from either,
gentoo's unstable tree has it, and caused me to download it from
somewhere when I built it :)

thanks,

greg k-h
