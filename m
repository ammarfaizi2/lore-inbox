Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266569AbUGUU4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266569AbUGUU4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 16:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266575AbUGUU43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 16:56:29 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:54403 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S266569AbUGUU40
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 16:56:26 -0400
Subject: Re: Inode question
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: sankarshana rao <san_wipro@yahoo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040721204602.35891.qmail@web50906.mail.yahoo.com>
References: <20040721204602.35891.qmail@web50906.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1090443377.17488.36.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 21 Jul 2004 15:56:17 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-21 at 15:46, sankarshana rao wrote:
> Thx for the reply...
> When I try to call lookup() from my kernel module, it
> gives undefined symbol error during INSMOD..
> any clues???

Not lookup, but path_lookup.

#include <linux/namei.h>
struct nameidata nd;
rc = path_lookup(path, LOOKUP_FOLLOW, &nd);
if (rc)
	file not found
else
	inum = nd.dentry->d_inode->i_ino;
	path_release(&nd);

> --- Dave Kleikamp <shaggy@austin.ibm.com> wrote:
> > On Wed, 2004-07-21 at 13:39, sankarshana rao wrote:
> > > Hi,
> > > I want to call namei() function in order to derive
> > an
> > > inode from a path name. Can I do this inside a
> > kernel
> > > module???
> > 
> > >From a kernel module, you should probably call
> > path_lookup().
> > 
> > Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

