Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161509AbWHDVrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161509AbWHDVrP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 17:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161510AbWHDVrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 17:47:15 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:63916 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161509AbWHDVrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 17:47:14 -0400
Subject: Re: [PATCH 06/28] reintroduce list of vfsmounts over superblock
From: Dave Hansen <haveblue@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk, herbert@13thfloor.at
In-Reply-To: <20060803143953.GD920@infradead.org>
References: <20060801235240.82ADCA42@localhost.localdomain>
	 <20060801235244.964B79E7@localhost.localdomain>
	 <20060803143953.GD920@infradead.org>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 14:47:08 -0700
Message-Id: <1154728028.10109.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-03 at 15:39 +0100, Christoph Hellwig wrote:
> On Tue, Aug 01, 2006 at 04:52:44PM -0700, Dave Hansen wrote:
> > 
> > We're moving a big chunk of the burden of keeping people from
> > writing to r/o filesystems from the superblock into the
> > vfsmount.  This requires that we consult the superblock's
> > vfsmounts when things like remounts occur.
> > 
> > So, introduce a list of vfsmounts hanging off the superblock.
> > We'll use this in a bit.
> 
> I don't think we'll need it.  We really need to keep is someone writing
> to this vfsmount counters in addition to is someone writing to this sb.

This one was a direct request from Al:

http://article.gmane.org/gmane.linux.kernel/421029
> BTW, it might be worth doing the following:
> 	* reintroduce the list of vfsmounts over given superblock (protected
> by vfsmount_lock)
...

So, I assume that there are some evil plans in the future for this as
well.

> In fact there are cases were we want a superblock to be writeable to
> without any view into it being writeable, e.g. for journal recovery.

Note that, as it stands now, the vfsmount has a flag which duplicates
the superblock r/o flag.  It is perfectly fine to do that journal
recovery by making the superblock r/w, but without telling any of the
mounts about it.  All of the write requests will get blocked by the
mount flag, and no one will ever see that the superblock changed state.

-- Dave

