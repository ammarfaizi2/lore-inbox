Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbUCMIPV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 03:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbUCMIPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 03:15:21 -0500
Received: from fungus.teststation.com ([212.32.186.211]:25099 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id S262420AbUCMIPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 03:15:19 -0500
Date: Sat, 13 Mar 2004 09:14:49 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.local
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: Adam Sampson <azz@us-lot.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: smbfs Oops with Linux 2.6.3
In-Reply-To: <Pine.LNX.4.58.0403111928250.29087@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.44.0403130902160.32093-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2004, Zwane Mwaikambo wrote:

> > The difference must be that in a the inode data for the root inode is not
> > considered current when the second ls runs, but I don't understand why the
> > readdir is printed before the getattr.
> 
> I don't understand why to expect the getattr before the readdir, perhaps
> you can elaborate for me?

smb_readdir
  smb_revalidate_inode
    smb_refresh_inode
      smb_proc_getattr
        server->ops->getattr
  server->ops->readdir


The first ls should find the inode out-of-date (smb_readdir probably isn't 
the first call, but that doesn't matter) because it is the first user.
The second ls is run shortly after and should find the inode to be 
up-to-date.

I'm not sure it is important at all, it just wasn't what I expected.

/Urban

