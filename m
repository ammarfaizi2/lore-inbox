Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267949AbUGWToX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267949AbUGWToX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 15:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267950AbUGWToX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 15:44:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39074 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267949AbUGWToR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 15:44:17 -0400
Subject: Re: Ext3 problems in dual booting machine with SE Linux
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Steve G <linux_4ever@yahoo.com>
Cc: James Morris <jmorris@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20040723190104.48863.qmail@web50609.mail.yahoo.com>
References: <20040723190104.48863.qmail@web50609.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1090611847.2140.42.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jul 2004 20:44:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2004-07-23 at 20:01, Steve G wrote:
> >You may have hit either the 2.4/2.6 xattr compatibility bug, or some other
> >xattr bug since fixed in the kernel.  I'd suggest using a 2.4.25 or
> >greater kernel if you want to access ext2/ext3 xattrs which were created
> >under 2.6.  2.4 kernels below this do not have 2.6 compatible xattrs for
> >ext2 and ext3.
> 
> If Ext3 is now no longer compatible with itself, should it have been called Ext4?

The comatibility issue affects ext2 too.  It's triggered by the presence
of extended attributes on "fast" ext2 symlinks, something which is
normally only triggered by SELinux; but the problem is not in SELinux,
it's in the core xattr and symlink code.

> Is there any version number embedded in the filesystem so newer versions of Ext3
> can act in a way compatible with older systems? 

It's not so simple.  Changing it now would make the new xattr code
incompatible with the old xattr code.  We're somewhat stuck with this
now.

> This seems like an open door to mischief. Any removable media can now be used to
> oops a kernel. There are systems that are under configuration control and moving
> to 2.4.25 is not really an option. They should be able to read/write any ext3
> media inserted into them.

Agreed.  Any oops on an older system is a bug --- ext3 shouldn't be
oopsing on bogus data.  I'll have a look at that (though I'm away for
most of the next 2 weeks so it probably won't be until I get back.) 
Such a bug in any ext3 implementation needs fixed, as it's exploitable
via removable media whether or not there are xattrs in the picture.

--Stephen

