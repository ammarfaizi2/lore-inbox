Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161138AbWHDOxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161138AbWHDOxE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 10:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161249AbWHDOxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 10:53:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:52946 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161138AbWHDOxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 10:53:02 -0400
Date: Fri, 4 Aug 2006 15:52:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Eric Sandeen <esandeen@redhat.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       torvalds@osdl.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jack@suse.cz, neilb@suse.de,
       Marcel Holtmann <marcel@holtmann.org>,
       "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [patch 16/23] ext3: avoid triggering ext3_error on bad NFS file handle
Message-ID: <20060804145254.GA20640@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Eric Sandeen <esandeen@redhat.com>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org,
	Justin Forbes <jmforbes@linuxtx.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
	Dave Jones <davej@redhat.com>,
	Chuck Wolber <chuckw@quantumlinux.com>,
	Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
	alan@lxorguk.ukuu.org.uk, jack@suse.cz, neilb@suse.de,
	Marcel Holtmann <marcel@holtmann.org>,
	"Stephen C. Tweedie" <sct@redhat.com>
References: <20060804053258.391158155@quad.kroah.org> <20060804054010.GQ769@kroah.com> <44D35DA0.4060403@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D35DA0.4060403@redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 09:45:52AM -0500, Eric Sandeen wrote:
> Greg KH wrote:
> >-stable review patch.  If anyone has any objections, please let us know.
> >
> >------------------
> >From: Neil Brown <neilb@suse.de>
> >
> >The inode number out of an NFS file handle gets passed eventually to
> >ext3_get_inode_block() without any checking.  If ext3_get_inode_block()
> >allows it to trigger an error, then bad filehandles can have unpleasant
> >effect - ext3_error() will usually cause a forced read-only remount, or a
> >panic if `errors=panic' was used.
> >
> >So remove the call to ext3_error there and put a matching check in
> >ext3/namei.c where inode numbers are read off storage.
> 
> This patch and the ext2 patch (23/23) are accomplishing the same thing in 2 
> different ways, I think, and introducing unnecessary differences between 
> ext2 and ext3.  I'd personally prefer to see both ext2 and ext3 handled 
> with the get_dentry op addition, and I'd be happy to quickly whip up the 
> ext3 patch to do this if there's agreement on this path.

I completly agree with Eric here.  Also pushing out only the fix for one
(and today probably the lesser used) filesystems to -stable seems wrong.
