Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264653AbUEOGdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264653AbUEOGdh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 02:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbUEOGdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 02:33:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62601 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264653AbUEOGde
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 02:33:34 -0400
Date: Sat, 15 May 2004 07:33:33 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: FabF <Fabian.Frederick@skynet.be>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.6-mm2] vfs iput in inode critical region
Message-ID: <20040515063333.GO17014@parcelfarce.linux.theplanet.co.uk>
References: <1084476395.7979.10.camel@bluerhyme.real3> <20040514224722.GL17014@parcelfarce.linux.theplanet.co.uk> <1084460539.7957.5.camel@bluerhyme.real3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084460539.7957.5.camel@bluerhyme.real3>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 05:02:19PM +0200, FabF wrote:
> On Sat, 2004-05-15 at 00:47, viro@parcelfarce.linux.theplanet.co.uk
> wrote:
> > On Thu, May 13, 2004 at 09:26:36PM +0200, FabF wrote:
> > > Hi,
> > > 
> > > 	AFAICS, block_dev.c : do_open calls bdput after an unlock_kernel.bdput
> > > calls iput and iput plays with some parameters and locks in iput final
> > > case only.Here's a patch to have a spinlock around the whole iput.
> > 
> > Huh?  Of course iput() is called without BKL (and in a lot more places than
> > just that, actually), but why does it imply that we suddenly need to hold
> > inode_lock over the entire function?
> > 
> What can avoid inode->i_state to change during fs put_inode is done plus
> super_operations get assigned something unprotected as well.

1) Nothing whatsoever; why does ->put_inode() need protection for ->i_state
of all things?
2) ->i_sb never changes through the lifetime of inode; sb->s_op should never
change too.
