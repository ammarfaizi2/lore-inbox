Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161241AbWHDOrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161241AbWHDOrK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 10:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161236AbWHDOrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 10:47:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6321 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161241AbWHDOrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 10:47:08 -0400
Message-ID: <44D35DA0.4060403@redhat.com>
Date: Fri, 04 Aug 2006 09:45:52 -0500
From: Eric Sandeen <esandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jack@suse.cz, neilb@suse.de,
       Marcel Holtmann <marcel@holtmann.org>,
       "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [patch 16/23] ext3: avoid triggering ext3_error on bad NFS file
 handle
References: <20060804053258.391158155@quad.kroah.org> <20060804054010.GQ769@kroah.com>
In-Reply-To: <20060804054010.GQ769@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> 
> ------------------
> From: Neil Brown <neilb@suse.de>
> 
> The inode number out of an NFS file handle gets passed eventually to
> ext3_get_inode_block() without any checking.  If ext3_get_inode_block()
> allows it to trigger an error, then bad filehandles can have unpleasant
> effect - ext3_error() will usually cause a forced read-only remount, or a
> panic if `errors=panic' was used.
> 
> So remove the call to ext3_error there and put a matching check in
> ext3/namei.c where inode numbers are read off storage.

This patch and the ext2 patch (23/23) are accomplishing the same thing in 2 
different ways, I think, and introducing unnecessary differences between ext2 
and ext3.  I'd personally prefer to see both ext2 and ext3 handled with the 
get_dentry op addition, and I'd be happy to quickly whip up the ext3 patch to do 
this if there's agreement on this path.

(there's nothing technically wrong with either approach, it just seems 
inconsistent to me).

Thanks,

-Eric
