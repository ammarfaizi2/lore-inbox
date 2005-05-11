Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVEKVgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVEKVgn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 17:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVEKVgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 17:36:42 -0400
Received: from mail.shareable.org ([81.29.64.88]:55760 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261185AbVEKVge
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 17:36:34 -0400
Date: Wed, 11 May 2005 22:36:24 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: 7eggert@gmx.de, ericvh@gmail.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, smfrench@austin.rr.com, hch@infradead.org
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Message-ID: <20050511213624.GF5093@mail.shareable.org>
References: <406SQ-5P9-5@gated-at.bofh.it> <40rNB-6p8-3@gated-at.bofh.it> <40t37-7ol-5@gated-at.bofh.it> <42VeB-8hG-3@gated-at.bofh.it> <42WNo-1eJ-17@gated-at.bofh.it> <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org> <20050511170700.GC2141@mail.shareable.org> <Pine.LNX.4.58.0505112121190.11888@be1.lrz> <20050511212343.GC5093@mail.shareable.org> <E1DVyqd-0002U1-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DVyqd-0002U1-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> >      # Make a named namespace.
> >      NSNAME='fred'
> >      mkdir /var/namespaces/$NSNAME
> >      run_in_new_namespace mount -t bind / /var/namespaces/$NSNAME
> 
> That's not going to work, since the mount will only affect the new
> namespace.

Ah, good point.  I'm still thinking in terms of shared subtrees, where
it might work.

> You'd need clone(), and then in the original namespace
> 
>    mount --bind /proc/CHILDPID/root /var/namespace/$NSNAME
> 
> and then child process can safely exit.

Or pass the file descriptor over a unix domain socket, so that it
doesn't need /proc.

-- Jamie
