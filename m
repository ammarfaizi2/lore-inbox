Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424151AbWKIRQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424151AbWKIRQj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 12:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424148AbWKIRQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 12:16:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64152 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1424133AbWKIRQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 12:16:38 -0500
Message-ID: <45536270.2040505@sandeen.net>
Date: Thu, 09 Nov 2006 11:16:32 -0600
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Jeff Layton <jlayton@redhat.com>
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2/3] new_inode_autonum: convert filesystems to use new
 function
References: <1163085883.21469.46.camel@dantu.rdu.redhat.com>
In-Reply-To: <1163085883.21469.46.camel@dantu.rdu.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Layton wrote:
> This patch converts all in-tree filesystems that blindly use the i_ino 
> value given by new_inode to use new_inode_autonum. Also fix up a few
> other cases where i_ino might not end up being unique.

After looking at this, since you have to change all of these filesystems
anyway, I'm not sure there's a lot of value in having
new_inode_autonum(); they all previously called new_inode() and then
filled in a few fields of the new inode.  Why not just call new_inode(),
and add a call to inode->i_inum = iunique(sb, 0)?  We don't have
new_inode_autouid() or new_inode_autoatime(), why is i_ino special in
this regard?

-Eric
