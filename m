Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVEXR4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVEXR4i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 13:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVEXR4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 13:56:38 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:49420 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261432AbVEXR4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 13:56:35 -0400
To: mikew@google.com
CC: miklos@szeredi.hu, jamie@shareable.org, linuxram@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <42936807.2000807@google.com> (message from Mike Waychison on
	Tue, 24 May 2005 10:44:39 -0700)
Subject: Re: [RFC][PATCH] rbind across namespaces
References: <1116627099.4397.43.camel@localhost> <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu> <1116660380.4397.66.camel@localhost> <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu> <20050521134615.GB4274@mail.shareable.org> <E1DZlVn-0007a6-00@dorka.pomaz.szeredi.hu> <429277CA.9050300@google.com> <E1DaSCb-0003Tw-00@dorka.pomaz.szeredi.hu> <4292D416.5070001@waychison.com> <E1DaUj1-0003eq-00@dorka.pomaz.szeredi.hu> <42935FCB.1010809@google.com> <E1DadFv-0004Te-00@dorka.pomaz.szeredi.hu> <42936807.2000807@google.com>
Message-Id: <E1DaddR-0004Ws-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 24 May 2005 19:56:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So you'd say 'mount /dev/foo /proc/self/fd/4' if 4 was an fd pointing to 
> a directory in another namespace?
> 
> That does require proc_check_root be removed.  :\

Or just make an exception to self?

proc_check_root() could begin with:

	if (current == proc_task(inode))
		return 0;

For all other tasks it would still be effective.

Miklos
