Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVEKVez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVEKVez (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 17:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVEKVez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 17:34:55 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:43276 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261236AbVEKVes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 17:34:48 -0400
To: jamie@shareable.org
CC: 7eggert@gmx.de, miklos@szeredi.hu, ericvh@gmail.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
In-reply-to: <20050511212343.GC5093@mail.shareable.org> (message from Jamie
	Lokier on Wed, 11 May 2005 22:23:43 +0100)
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
References: <406SQ-5P9-5@gated-at.bofh.it> <40rNB-6p8-3@gated-at.bofh.it> <40t37-7ol-5@gated-at.bofh.it> <42VeB-8hG-3@gated-at.bofh.it> <42WNo-1eJ-17@gated-at.bofh.it> <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org> <20050511170700.GC2141@mail.shareable.org> <Pine.LNX.4.58.0505112121190.11888@be1.lrz> <20050511212343.GC5093@mail.shareable.org>
Message-Id: <E1DVyqd-0002U1-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 11 May 2005 23:34:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Still easy.
> 
> To keep persistent named namespaces in /var/namespaces, thus:
> 
>      # Just once please!
>      mount -t tmpfs none /var/namespaces
> 
>      # Make a named namespace.
>      NSNAME='fred'
>      mkdir /var/namespaces/$NSNAME
>      run_in_new_namespace mount -t bind / /var/namespaces/$NSNAME

That's not going to work, since the mount will only affect the new
namespace.  You'd need clone(), and then in the original namespace

   mount --bind /proc/CHILDPID/root /var/namespace/$NSNAME

and then child process can safely exit.

Miklos
