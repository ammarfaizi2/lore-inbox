Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbULHNq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbULHNq0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 08:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbULHNpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 08:45:22 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:11910 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261218AbULHNh0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 08:37:26 -0500
Subject: Re: 2.6.10-rc2-mm4
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Jeff Mahoney <jeffm@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, Chris Wright <chrisw@osdl.org>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>, Chris Mason <mason@suse.com>
In-Reply-To: <41B632DD.4030804@suse.com>
References: <20041130095045.090de5ea.akpm@osdl.org>
	 <1101842310.4401.111.camel@moss-spartans.epoch.ncsc.mil>
	 <20041130112903.C2357@build.pdx.osdl.net>
	 <20041130194328.GA28126@infradead.org>
	 <20041201233203.GA22773@locomotive.unixthugs.org>
	 <1101993302.26015.5.camel@moss-spartans.epoch.ncsc.mil>
	 <41B60B0F.1080201@suse.com>
	 <1102451289.25488.278.camel@moss-spartans.epoch.ncsc.mil>
	 <41B632DD.4030804@suse.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1102512501.26951.3.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 08 Dec 2004 08:28:21 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-07 at 17:46, Jeff Mahoney wrote:
> In general, this is true. However, there's a case where it's not. During
> the initial filesystem mount, the .reiserfs_priv directory is created by
> reiserfs_xattr_init(). This directory becomes the root of the private
> inode tree, but there is no way to mark it as private until after mkdir
> returns. After it returns, d_instantiate has already been called.
> 
> Therefore, on the first read-write mount, the inode associated with
> .reiserfs_priv will always be on that list. There are a few methods that
> could be added to set the inode private before the d_instantiate, but
> they're all pretty gross. Basically, of all the potential solutions,
> checking IS_PRIVATE in that loop is the simplest.

Ok, thanks for clarifying.  No objection to the patch.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

