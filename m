Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVEVVLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVEVVLM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 17:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVEVVLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 17:11:12 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:14307 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261772AbVEVVLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 17:11:00 -0400
Subject: Re: [RFC][PATCH] rbind across namespaces
From: Ram <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jamie@shareable.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <E1DZlVn-0007a6-00@dorka.pomaz.szeredi.hu>
References: <1116627099.4397.43.camel@localhost>
	 <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu>
	 <1116660380.4397.66.camel@localhost>
	 <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu>
	 <20050521134615.GB4274@mail.shareable.org>
	 <E1DZlVn-0007a6-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1116796229.4397.117.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 22 May 2005 14:10:29 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-22 at 01:08, Miklos Szeredi wrote:
> > > I still see a problem: what if old_nd.mnt is already detached, and
> > > bind is non-recursive.  Now it fails with EINVAL, though it used to
> > > work (and I think is very useful).
> > 
> > Hey, you just made another argument for not detaching mounts when the
> > last task with that current->namespace exits, but instead detaching
> > mounts when the last reference to any vfsmnt in the namespace is dropped.
> > 
> > Hint :)
> 
> I have a better idea:
> 
>  - create a "dead_mounts" namespace.
>  - chain each detached mount's ->mnt_list on dead_mounts->list
>  - set mnt_namespace to dead_mounts
>  - export the list via proc through the usual mount list interface
> 
> The last would be a nice bonus: I've always wanted to see the list of
> detached, but not-yet destroyed mounts.
> 
> Does anybody see a problem with that?


Yes. :) because I will have to change my 'rbind across namespace' patch
because now detached mounts will have dead_mounts namespace instead of
null namespace.

RP


> 
> Miklos

