Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751954AbWCAXm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbWCAXm5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 18:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWCAXm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 18:42:57 -0500
Received: from pat.uio.no ([129.240.130.16]:61433 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750818AbWCAXm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 18:42:56 -0500
Subject: Re: [RFC] vfs: cleanup of permission()
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060301131149.GD26837@MAIL.13thfloor.at>
References: <20060228052606.GA6494@MAIL.13thfloor.at>
	 <1141202744.11585.20.camel@lade.trondhjem.org>
	 <20060301131149.GD26837@MAIL.13thfloor.at>
Content-Type: text/plain
Date: Wed, 01 Mar 2006 15:42:43 -0800
Message-Id: <1141256563.26382.8.camel@netapplinux-10.connectathon.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.95, required 12,
	autolearn=disabled, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-01 at 14:11 +0100, Herbert Poetzl wrote:

> the second part is actually a hack to help nfs and fuse
> to get the 'required' information until there is a proper
> interface (at the vfs not inode level) to pass relevant
> information (probably dentry/vfsmount/flags)

The nameidata _IS_ the vfs structure for storing path context
information. You seem to be suggesting we need yet another one. Why?

> > > this is in two parts, the first one does the 
> > > removal and the second one fixes up nfs and fuse
> > > by passing the relevant nd_flags via the mask
> > > 
> > > Note: this is just a suggestion, so please let
> > >       us know what you think 
> > 
> > Firstly, the fact that the lookup intent flags happen not to collide
> > with MAY_* is a complete fluke, not a design. The numerical values of
> > either set of flags could change tomorrow for all you know.
> >
> > Secondly, an intent is _not_ a permissions mask by any stretch of the
> > imagination.
> 
> see above
> 
> > IOW: at the very least make that intent flag a separate parameter.
> 
> IMHO it would be good to remove them completely form the
> current permission() checks.

Vetoed!

Redundant RPC calls have performance costs to the client, the server and
the network. That intent information is there in order to allow the
filesystem to figure out whether or not it needs to do the permissions
check, or if that check is already being done by other operations.

Removing the intents are therefore not an option.

Cheers,
  Trond

