Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWCANLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWCANLv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 08:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWCANLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 08:11:50 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:9155 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S932133AbWCANLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 08:11:50 -0500
Date: Wed, 1 Mar 2006 14:11:49 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] vfs: cleanup of permission()
Message-ID: <20060301131149.GD26837@MAIL.13thfloor.at>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Andrew Morton <akpm@osdl.org>,
	Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20060228052606.GA6494@MAIL.13thfloor.at> <1141202744.11585.20.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141202744.11585.20.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 12:45:44AM -0800, Trond Myklebust wrote:
> On Tue, 2006-02-28 at 06:26 +0100, Herbert Poetzl wrote:
> > Hi Andrew! Christoph! Al!
> > 
> > after thinking some time about the oracle words
> > (sent in reply to previous BME submissions) we 
> > (Sam and I) came to the conclusion that it would 
> > be a good idea to remove the nameidata introduced
> > in September 2003 from the inode permission()
> > checks, so that vfs_permission() can take care
> > of them ...
> 
> Why? There may be perfectly legitimate reasons for the filesystem to
> request information about the path. I can think of server failover
> situations in NFSv4 where the client may need to look up the
> filehandle for the file on the new server before it can service the
> ACCESS call.

the second part is actually a hack to help nfs and fuse
to get the 'required' information until there is a proper
interface (at the vfs not inode level) to pass relevant
information (probably dentry/vfsmount/flags)

> > this is in two parts, the first one does the 
> > removal and the second one fixes up nfs and fuse
> > by passing the relevant nd_flags via the mask
> > 
> > Note: this is just a suggestion, so please let
> >       us know what you think 
> 
> Firstly, the fact that the lookup intent flags happen not to collide
> with MAY_* is a complete fluke, not a design. The numerical values of
> either set of flags could change tomorrow for all you know.
>
> Secondly, an intent is _not_ a permissions mask by any stretch of the
> imagination.

see above

> IOW: at the very least make that intent flag a separate parameter.

IMHO it would be good to remove them completely form the
current permission() checks.

best,
Herbert

> Cheers,
>   Trond
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
