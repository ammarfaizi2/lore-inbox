Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262183AbVERLdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbVERLdm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 07:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbVERLdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 07:33:41 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:42510 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262168AbVERLd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 07:33:29 -0400
To: trond.myklebust@fys.uio.no
CC: dhowells@redhat.com, linuxram@us.ibm.com, jamie@shareable.org,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1116414429.10773.57.camel@lade.trondhjem.org> (message from
	Trond Myklebust on Wed, 18 May 2005 07:07:09 -0400)
Subject: Re: [PATCH] fix race in mark_mounts_for_expiry()
References: <E1DYLvb-0000as-00@dorka.pomaz.szeredi.hu>
	 <E1DYLCv-0000W7-00@dorka.pomaz.szeredi.hu>
	 <1116005355.6248.372.camel@localhost>
	 <E1DWf54-0004Z8-00@dorka.pomaz.szeredi.hu>
	 <1116012287.6248.410.camel@localhost>
	 <E1DWfqJ-0004eP-00@dorka.pomaz.szeredi.hu>
	 <1116013840.6248.429.camel@localhost>
	 <E1DWprs-0005D1-00@dorka.pomaz.szeredi.hu>
	 <1116256279.4154.41.camel@localhost>
	 <20050516111408.GA21145@mail.shareable.org>
	 <1116301843.4154.88.camel@localhost>
	 <E1DXm08-0006XD-00@dorka.pomaz.szeredi.hu>
	 <20050517012854.GC32226@mail.shareable.org>
	 <E1DXuiu-0007Mj-00@dorka.pomaz.szeredi.hu>
	 <1116360352.24560.85.camel@localhost>
	 <E1DYI0m-0000K5-00@dorka.pomaz.szeredi.hu>
	 <1116399887.24560.116.camel@localhost>
	 <1116400118.24560.119.camel@localhost> <6865.1116412354@redhat.com>
	 <7230.1116413175@redhat.com>  <E1DYMB6-0000dw-00@dorka.pomaz.szeredi.hu> <1116414429.10773.57.camel@lade.trondhjem.org>
Message-Id: <E1DYMn1-0000kp-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 18 May 2005 13:32:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Some archs already have an atomic_dec_if_positive() (see for instance
> the PPC). It won't take much work to convert that to an
> atomic_inc_if_positive().
> 
> For those arches that don't have that sort of thing, then writing a
> generic atomic_inc_if_positive() using cmpxchg() will often be possible,
> but there are exceptions (for instance the original 386 does not have a
> cmpxchg, so there you will have to use something else).

The problem with introducing architecture specific code, is that it's
just asking for new bugs.

If it's something used all over the kernel, than obviously it's OK,
but for the sake of just one caller it's a bit crazy I think.

Miklos
