Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbVERTHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbVERTHU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 15:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbVERTHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 15:07:20 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:32016 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262218AbVERTHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 15:07:07 -0400
To: jamie@shareable.org
CC: trond.myklebust@fys.uio.no, dhowells@redhat.com, linuxram@us.ibm.com,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <20050518173419.GB993@mail.shareable.org> (message from Jamie
	Lokier on Wed, 18 May 2005 18:34:19 +0100)
Subject: Re: [PATCH] fix race in mark_mounts_for_expiry()
References: <E1DYI0m-0000K5-00@dorka.pomaz.szeredi.hu> <1116399887.24560.116.camel@localhost> <1116400118.24560.119.camel@localhost> <6865.1116412354@redhat.com> <7230.1116413175@redhat.com> <E1DYMB6-0000dw-00@dorka.pomaz.szeredi.hu> <1116414429.10773.57.camel@lade.trondhjem.org> <E1DYMn1-0000kp-00@dorka.pomaz.szeredi.hu> <20050518125041.GA29107@mail.shareable.org> <E1DYOTs-0000ub-00@dorka.pomaz.szeredi.hu> <20050518173419.GB993@mail.shareable.org>
Message-Id: <E1DYTri-0001SL-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 18 May 2005 21:05:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That makes less sense if we allow other tasks to be using a namespace
> through a passing a file descriptor, and then the last task which has
> current->namespace equal to that namespace exits.  It makes no sense
> to me that the mount which is still accessible through the file
> descriptor is suddenly detached from it's parent and children mounts.

I see your point.  I don't yet see a solution.

Currently detach is an explicit action, not something automatic which
happens when there are no more references to a vfsmount.

> Why is it not good enough to detach each vfsmnt when the last
> reference to each vfsmnt is dropped?  In other words, simply when the
> vfsmnt becomes unreachable?

Define unreachable.  Then define a mechanism, by which it can be
detected.

Miklos
