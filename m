Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264905AbTGBKja (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 06:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbTGBKja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 06:39:30 -0400
Received: from gprs2-63.eurotel.cz ([160.218.145.63]:20455 "EHLO
	exuhome.dyn.jankratochvil.net") by vger.kernel.org with ESMTP
	id S264905AbTGBKj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 06:39:29 -0400
Date: Wed, 2 Jul 2003 12:53:28 +0200
From: Jan Kratochvil 
	<rcpt-linux-kernel.AT.vger.kernel.org@jankratochvil.net>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       chaffee@cs.berkeley.edu, zippel@linux-m68k.org
Subject: Re: [PATCH] vfat+affs case preservation
Message-ID: <20030702105328.GA17023@exuhome.dyn.jankratochvil.net>
References: <20030702102538.GA16711@exuhome.dyn.jankratochvil.net> <20030702103457.GS27348@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030702103457.GS27348@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 02 Jul 2003 12:34:57 +0200, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Wed, Jul 02, 2003 at 12:25:38PM +0200, Jan Kratochvil wrote:
...
> > http://www.jankratochvil.net/priv/vfat/linux-2.4.22-pre2-vfat6.diff
> > http://www.jankratochvil.net/priv/vfat/linux-2.5.73-bk9-vfat6.diff
...
> > +/* We have to always do the revalidate as after unlink (etc.) there still may
> > + * exist other case-different dentries for the same inode. It would be also
> > + * possible to discard such aliases by going through d_alias links during the
> > + * unlink. "strictcase" does not have case-different dentries but "longna~1"
> > + * style aliases still exist there.
> > + */
> 
> > -	alias = d_find_alias(inode);
...
> Broken.   With that we can get two active dentries for the same directory.
> There goes any cache coherency, with all usual results.

Right, this patch will introduce virtual directory hardlinks - multiple dentries
to one directory inode. But it also makes dentry validation mandatory for such
filesystems to fix it. I was not able to prevent such hardlinking as there must
already exist two valid dentries named "dir" and "DIR" to call rename("dir").
Patch successfuly being used over 1.5 year on server to vindicate it a bit. :-)



Regards,
Lace
