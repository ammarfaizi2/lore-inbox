Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVEPJBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVEPJBA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 05:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVEPJA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 05:00:59 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:23558 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261459AbVEPJAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 05:00:54 -0400
To: miklos@szeredi.hu
CC: linuxram@us.ibm.com, viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <E1DXbD5-0007UI-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Mon, 16 May 2005 10:44:23 +0200)
Subject: Re: [PATCH] namespace.c: fix bind mount from foreign namespace
References: <E1DWXeF-00017l-00@dorka.pomaz.szeredi.hu>
	 <20050513170602.GI1150@parcelfarce.linux.theplanet.co.uk>
	 <E1DWdn9-0004O2-00@dorka.pomaz.szeredi.hu>
	 <1116005355.6248.372.camel@localhost>
	 <E1DWf54-0004Z8-00@dorka.pomaz.szeredi.hu>
	 <1116012287.6248.410.camel@localhost>
	 <E1DWfqJ-0004eP-00@dorka.pomaz.szeredi.hu>
	 <1116013840.6248.429.camel@localhost>
	 <E1DWprs-0005D1-00@dorka.pomaz.szeredi.hu> <1116256279.4154.41.camel@localhost> <E1DXbD5-0007UI-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1DXbSB-0007Wb-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 16 May 2005 10:59:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A vfsmount can only be in a single namespace at a time, since each
> mount tree is rooted in a single namespace.  So what you are saying is
> impossible.

To be more precise a vfsmount can only be in _at_ _most_ one
namespace.  When it is detached from a mount tree, it's no longer in
_any_ namespace.

There even seems to be some confusion about that in namespace.c.  I
think mnt_namespace should be set to NULL in detach_mnt() instead of
__put_namespace().

Miklos
