Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbVERLWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVERLWm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 07:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbVERLTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 07:19:34 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:17158 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262180AbVERLPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 07:15:34 -0400
To: dhowells@redhat.com
CC: linuxram@us.ibm.com, jamie@shareable.org,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <8247.1116413990@redhat.com> (message from David Howells on Wed,
	18 May 2005 11:59:50 +0100)
Subject: Re: [PATCH] fix race in mark_mounts_for_expiry()
References: <E1DYMB6-0000dw-00@dorka.pomaz.szeredi.hu>  <E1DYLvb-0000as-00@dorka.pomaz.szeredi.hu> <E1DYLCv-0000W7-00@dorka.pomaz.szeredi.hu> <1116005355.6248.372.camel@localhost> <E1DWf54-0004Z8-00@dorka.pomaz.szeredi.hu> <1116012287.6248.410.camel@localhost> <E1DWfqJ-0004eP-00@dorka.pomaz.szeredi.hu> <1116013840.6248.429.camel@localhost> <E1DWprs-0005D1-00@dorka.pomaz.szeredi.hu> <1116256279.4154.41.camel@localhost> <20050516111408.GA21145@mail.shareable.org> <1116301843.4154.88.camel@localhost> <E1DXm08-0006XD-00@dorka.pomaz.szeredi.hu> <20050517012854.GC32226@mail.shareable.org> <E1DXuiu-0007Mj-00@dorka.pomaz.szeredi.hu> <1116360352.24560.85.camel@localhost> <E1DYI0m-0000K5-00@dorka.pomaz.szeredi.hu> <1116399887.24560.116.camel@localhost> <1116400118.24560.119.camel@localhost> <6865.1116412354@redhat.com> <7230.1116413175@redhat.com> <8247.1116413990@redhat.com>
Message-Id: <E1DYMVf-0000hD-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 18 May 2005 13:14:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > There's still the problem of cmpxchg meddling in the internals of an
> > atomic_t.  Is that OK?  Will that work on all archs?
> 
> Probably. It might be worth defining an atomic_cmpxchg() op to formalise it
> though:
> 
> 	int atomic_cmpxchg(atomic_t *p, int old, int new);
> 
> The main reason for this is that atomic_t is mostly a 32-bit value, I think,
> and cmpxchg() may sometimes enforce a 64-bit value.
> 
> It can be made to work on PPC, PPC64, x86, x86_64, frv. I imagine it'll work
> on MIPS, sparc and alpha too without too much trouble. Dunno about the rest.

Any takers?

I'd rather not do this, if I don't have to :)

Do you think my original fix is wrong, or is this just cosmetics?

Thanks,
Miklos
