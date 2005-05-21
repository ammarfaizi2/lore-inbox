Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVEUG1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVEUG1z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 02:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVEUG1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 02:27:55 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:33035 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261678AbVEUG1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 02:27:41 -0400
To: linuxram@us.ibm.com
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, jamie@shareable.org
In-reply-to: <1116627099.4397.43.camel@localhost> (message from Ram on Fri, 20
	May 2005 15:11:40 -0700)
Subject: Re: [RFC][PATCH] rbind across namespaces
References: <1116627099.4397.43.camel@localhost>
Message-Id: <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 21 May 2005 08:27:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have enclosed a patch that allows rbinds across any two namespaces.
> NOTE: currenly bind from foriegn namespace to current namespace is
> allowed. This patch now allows:

Note: you are accessing ->mnt_namespace without holding vfsmount_lock.

Also why check current->namespace?  It doesn't hurt to do
get_namespace() even if it's not strictly needed.  And it would
simplify the code.

In fact all uses of current->namespace and check_mnt() could be
eliminated from namespace.c.  The only use of ->namespace would be in
copy_namespace() and exit_namespace().

Miklos
