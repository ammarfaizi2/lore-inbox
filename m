Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVEUIKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVEUIKE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 04:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVEUIKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 04:10:04 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:61712 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261697AbVEUIJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 04:09:52 -0400
To: linuxram@us.ibm.com
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, jamie@shareable.org
In-reply-to: <1116660380.4397.66.camel@localhost> (message from Ram on Sat, 21
	May 2005 00:26:20 -0700)
Subject: Re: [RFC][PATCH] rbind across namespaces
References: <1116627099.4397.43.camel@localhost>
	 <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu> <1116660380.4397.66.camel@localhost>
Message-Id: <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 21 May 2005 10:09:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Enclosed the simplified patch,

Looks much better :)

I still see a problem: what if old_nd.mnt is already detached, and
bind is non-recursive.  Now it fails with EINVAL, though it used to
work (and I think is very useful).

When doing up_write(...) you don't have to keep the order, just check
if the namespaces are not equal for the second up_write().

And why don't you do this:

	if (old_ns < mntpt_ns)
		down_write(&old_ns->sem);

instead of this

	if (old_ns < mntpt_ns) {
		down_write(&old_ns->sem);
	}

Miklos
