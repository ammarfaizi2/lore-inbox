Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262540AbVAUWGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbVAUWGy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 17:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262517AbVAUWFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 17:05:23 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:29411 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262547AbVAUVs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:48:57 -0500
Subject: Re: Fix ea-in-inode default ACL creation
From: Andreas Gruenbacher <agruen@suse.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Tridgell <tridge@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>, Alex Tomas <alex@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1106343376.1989.437.camel@sisko.sctweedie.blueyonder.co.uk>
References: <1106245344.15959.13.camel@winden.suse.de>
	 <1106343376.1989.437.camel@sisko.sctweedie.blueyonder.co.uk>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1106344121.19651.55.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 21 Jan 2005 22:48:41 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-21 at 22:36, Stephen C. Tweedie wrote:
> Ugh.  It feels horrible to have to do this, but we _do_ want to clear
> the raw inode, and we only want to do it once, and we have to do it on
> first access to the on-disk structures.  I can't see an easy way round
> it that doesn't add more overhead.

Well, we could split EXT3_STATE_NEW into a "GOOD_OLD_NEW" flag for the
first 128 bytes and a "BIG_INODE_NEW" flag for the rest, and only
initialize the rest in the xattr code when necessary. Not any better it
I suppose. Note that this change has no effect except with default ACLs
anyway.

-- Andreas.

