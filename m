Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVEWIYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVEWIYs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 04:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbVEWIYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 04:24:48 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:8206 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261863AbVEWIYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 04:24:44 -0400
To: linuxram@us.ibm.com
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, jamie@shareable.org
In-reply-to: <1116833048.4397.137.camel@localhost> (message from Ram on Mon,
	23 May 2005 00:24:08 -0700)
Subject: Re: [RFC][PATCH] rbind across namespaces
References: <1116627099.4397.43.camel@localhost>
	 <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu>
	 <1116660380.4397.66.camel@localhost>
	 <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu>
	 <1116665101.4397.71.camel@localhost>
	 <E1DZPzS-0006kw-00@dorka.pomaz.szeredi.hu>
	 <1116670073.4397.77.camel@localhost>
	 <E1DZTmi-0006up-00@dorka.pomaz.szeredi.hu>
	 <1116793554.4397.102.camel@localhost> <1116795059.4397.111.camel@localhost>
	 <E1Da5BO-00027F-00@dorka.pomaz.szeredi.hu> <1116833048.4397.137.camel@localhost>
Message-Id: <E1Da8ER-0002G5-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 23 May 2005 10:24:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> yes done. enclosed the patch.
> 
> But seems like this patch opens up questions like:
> 
> Should mounts/umounts/remounts/pivot_root in foreign namespaces 
> be allowed?

I think yes.

Moving a subtree to a different namespace is a bit tricky so maybe
move should still be restricted to be within a single namespace.

And I think we should relax the checks under /proc, to allow proper
access to foreign namespaces as far as it doesn't impact security.
E.g. it makes sense to allow a process to access /proc/self/fd/XXX
even if XXX resides in a different namespace.  Currently that is not
allowed.

Miklos
