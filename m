Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262560AbVC3XSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbVC3XSu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 18:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbVC3XSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 18:18:49 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:9444 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S262560AbVC3XSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 18:18:41 -0500
Date: Wed, 30 Mar 2005 18:18:40 -0500
To: lkml <linux-kernel@vger.kernel.org>,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [PATCH] Set MS_ACTIVE in isofs_fill_super()
Message-ID: <20050330231840.GA6773@delft.aura.cs.cmu.edu>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>,
	"viro@parcelfarce.linux.theplanet.co.uk" <viro@parcelfarce.linux.theplanet.co.uk>
References: <1112213392.25362.65.camel@russw.beaverton.ibm.com> <20050330123907.10740bc1.akpm@osdl.org> <1112221619.9858.89.camel@russw.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112221619.9858.89.camel@russw.beaverton.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 02:26:59PM -0800, Russ Weight wrote:
> isofs_fill_super() is called by get_sb_bdev(), which is in the generic
> filesystem code. get_sb_bdev() receives a pointer as a parameter when it
> is called from isofs_get_sb(). To make a change in get_sb_bdev() would
> be to affect many (all?) filesystems. This may be the right thing to do
> - although it seems a little heavy-weight since the failure hasn't been
> reported in other filesystems.

It probably hasn't been reported in other filesystems because they only
use iput() in the error path if they can't get the dentry for the root
inode, which is probably a fairly rare situation. From what I can see
only isofs seems to intentionally drop the inode to grab another one.

Jan

