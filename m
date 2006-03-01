Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWCANG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWCANG7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 08:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWCANG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 08:06:59 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:6595 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S932173AbWCANG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 08:06:58 -0500
Date: Wed, 1 Mar 2006 14:06:57 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: tvrtko.ursulin@sophos.com
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Al Viro <viro@ftp.linux.org.uk>,
       LSM <linux-security-module@mail.wirex.com>
Subject: Re: [RFC] vfs: cleanup of permission()
Message-ID: <20060301130657.GC26837@MAIL.13thfloor.at>
Mail-Followup-To: tvrtko.ursulin@sophos.com, Andrew Morton <akpm@osdl.org>,
	Christoph Hellwig <hch@infradead.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	LSM <linux-security-module@mail.wirex.com>
References: <1141202744.11585.20.camel@lade.trondhjem.org> <OFAFEC22B7.7F7518A9-ON80257124.0043AF58-80257124.00448503@sophos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFAFEC22B7.7F7518A9-ON80257124.0043AF58-80257124.00448503@sophos.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 12:28:25PM +0000, tvrtko.ursulin@sophos.com wrote:
> > On Tue, 2006-02-28 at 06:26 +0100, Herbert Poetzl wrote:
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
> Could you please provide a link to that 'previous BME submissions'?

here you go: http://lkml.org/lkml/2006/1/21/19

> Thanks.

you're welcome!

> Also, since you are modifying LSM interfaces, why not discuss it on
> the LSM mailing list?

no problem with that, will cc the lsm folks next time
(feel free to bounce the messages)

for now, here is a link to this thread:
  http://lkml.org/lkml/2006/2/28/4

> And finally, please don't remove nameidata. Modules out there depend
> on it and we at Sophos are about to release a new product which needs
> it as well. The plan was to announce the whole thing parallel with the
> release, but after spotting your post I was prompted to react ahead
> of the schedule. However, I am very busy at the moment so the actual
> announcment with full details will have to wait for a week or two.

thing is, permission() does inode based checks
and the nameidata is not even provided in most
cases, so you cannot rely on that information
anyway

it would probably be better to have some kind
of vfs_permission, which uses dentry/vfsmnt for
decisions on the vfs layer, this would also allow
to cover most of the cases where nameidata is not
available (for example the filep based stuff)

best,
Herbert

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
