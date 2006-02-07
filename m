Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965101AbWBGOt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbWBGOt2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 09:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbWBGOt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 09:49:28 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:28575 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S965101AbWBGOt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 09:49:28 -0500
Date: Tue, 7 Feb 2006 15:49:37 +0100
From: Luca <kronos@kronoz.cjb.net>
To: Nathan Scott <nathans@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [BUG] Linux 2.6.16-rcX breaks mutt
Message-ID: <20060207144937.GA3302@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20060206172141.GA15133@dreamland.darkstar.lan> <20060206233046.GC791@frodo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060206233046.GC791@frodo>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Tue, Feb 07, 2006 at 10:30:46AM +1100, Nathan Scott ha scritto: 
> Hi Luca,
> 
> On Mon, Feb 06, 2006 at 06:21:41PM +0100, Luca wrote:
> > Hi,
> > I found out that mutt when running with a 2.6.16-rcX kernel is unable to
> > discover new mails in mboxes other than the main one.
> > ...
> > I've done a simple test with working and non working system:
> 
> I constructed a test case based on your description, and this patch
> fixes it for me - could you try it out & let me know how it goes in
> yoour case?

Tested now, it's working.

> --- fs/xfs/linux-2.6/xfs_iops.c.orig	2006-02-07 10:49:34.143620000 +1100
> +++ fs/xfs/linux-2.6/xfs_iops.c	2006-02-07 10:49:57.785097500 +1100
> @@ -673,6 +673,8 @@ linvfs_setattr(
>  	if (ia_valid & ATTR_ATIME) {
>  		vattr.va_mask |= XFS_AT_ATIME;
>  		vattr.va_atime = attr->ia_atime;
> +		if (ia_valid & ATTR_ATIME_SET)
> +			inode->i_atime = attr->ia_atime;
>  	}
>  	if (ia_valid & ATTR_MTIME) {
>  		vattr.va_mask |= XFS_AT_MTIME;

thanks,
Luca
-- 
Home: http://kronoz.cjb.net
La somma dell'intelligenza sulla terra e` una costante.
La popolazione e` in aumento.
