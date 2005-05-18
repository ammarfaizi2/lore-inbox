Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbVERTUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbVERTUQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 15:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVERTUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 15:20:16 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:40203 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262299AbVERTT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 15:19:59 -0400
To: linuxram@us.ibm.com
CC: dhowells@redhat.com, jamie@shareable.org,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1116442073.24560.142.camel@localhost> (message from Ram on Wed,
	18 May 2005 11:47:54 -0700)
Subject: Re: [PATCH] fix race in mark_mounts_for_expiry()
References: <E1DYMVf-0000hD-00@dorka.pomaz.szeredi.hu>
	 <E1DYMB6-0000dw-00@dorka.pomaz.szeredi.hu>
	 <E1DYLvb-0000as-00@dorka.pomaz.szeredi.hu>
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
	 <7230.1116413175@redhat.com> <8247.1116413990@redhat.com>
	 <9498.1116417099@redhat.com> <E1DYNLt-0000nu-00@dorka.pomaz.szeredi! .hu>
	 <E1DYNjR-0000po-00@dorka.pomaz.szeredi.hu>
	 <E1DYRnw-0001J6-00@dorka.pomaz.szeredi.hu> <1116442073.24560.142.camel@localhost>
Message-Id: <E1DYU4Z-0001U5-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 18 May 2005 21:19:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> First of all the reason this race exists implies Al Viro may have had
> assertion in his mind that "All tasks that have access to a namespace
> has a refcount on that namespace".  If that was what he was thinking,
> than the I would stick with that assertion being true. The overall idea
> I am thinking off is:
> 
> 1) have the automounter hold a refcount on any new namespace created
>     the mounts in which the automounter has interest in.
> 2) have a refcount on the namespace when a new task gains access to
>    a namespace through the file descriptor or any other 
>    similar mechanisms and remove the reference
>    once the fd gets closed. (bit tricky to implement)
> 
> Do you agree with the overall idea? 

I don't really understand it.

A reference count usually means, the number of references (pointers)
to an object.  You can sometimes get away with schemes that deviate
from this in various ways, but it's usually asking for trouble.

The usage in mark_mounts_for_expiry() deviated from it so much, that
the result was a subtle race.

Doing some tricky thing like what you propose will just likely
introduce more subtle problems.

Miklos
