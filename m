Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbUK0Slr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUK0Slr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 13:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbUK0Slr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 13:41:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52926 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261300AbUK0Sku
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 13:40:50 -0500
Date: Sat, 27 Nov 2004 18:40:48 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Vladimir Saveliev <vs@namesys.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: should delete_inode be allowed to be called from shrink_dcache?
Message-ID: <20041127184048.GJ26051@parcelfarce.linux.theplanet.co.uk>
References: <1101555657.2229.54.camel@tribesman.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101555657.2229.54.camel@tribesman.namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2004 at 02:40:57PM +0300, Vladimir Saveliev wrote:
> Hello
> 
> Is there anything wrong that
> 
> mkdir dir
> cd dir
> rmdir ../dir
> ls file
> cd ..
> 
> leaves after itself two dentries - negative one ("file") and dentry of
> directory "dir" which is attached to inode of that directory?

No, it's legitimate (and can happen in other scenarios).
 
> After that a process may get into somefs_delete_inode trying to free
> pages by shrinking dcache (it will first free negative dentry and then
> its parent).
> If process is doing that being already in somefs_write (for example)
> some filesystems may have problems.

Details, please...  All filesystems I'm familiar with won't (AFAICS) have
any problems with that.  What exactly do you have in mind?  Note that
in a lot of areas you get GFP_NOFS allocations anyway - that's the primary
defense against deadlocks and it's almost always enough.  The only trouble
I can recall more or less recently was hpfs - there we had (among shitpiles
of other races) several places that required explicit GFP_NOFS.  Usually
it just works...
