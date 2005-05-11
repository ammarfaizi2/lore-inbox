Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbVEKV2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbVEKV2y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 17:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVEKV2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 17:28:54 -0400
Received: from mail.shareable.org ([81.29.64.88]:51920 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262064AbVEKV2f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 17:28:35 -0400
Date: Wed, 11 May 2005 22:28:10 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ram <linuxram@us.ibm.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 7eggert@gmx.de, ericvh@gmail.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Message-ID: <20050511212810.GD5093@mail.shareable.org>
References: <406SQ-5P9-5@gated-at.bofh.it> <40rNB-6p8-3@gated-at.bofh.it> <40t37-7ol-5@gated-at.bofh.it> <42VeB-8hG-3@gated-at.bofh.it> <42WNo-1eJ-17@gated-at.bofh.it> <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org> <20050511170700.GC2141@mail.shareable.org> <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu> <1115840139.6248.181.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115840139.6248.181.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram wrote:
> What if proc filesystem is removed from the kernel?
> 
> Ability to access some other namespace through the proc filesystem does
> not look clean. I think it should be cleanly supported through VFS.

You don't have to use /proc/NNN/root - that's just one convenient way
to do it.

Other ways are

    run_in_namespace mount -t bind / /var/namespaces/$NAME

and

    clone + open("/") + pass to parent using unix socket

which I think both work already.

> Also cd'ing into a new namespace just allows you to browse through
> the other namespace. But it does not effectively change the process's
> namespace.  Things like mount in the other namespace will be failed
> by check_mount() anyway.

That's correct.

> I think, we need sys calls like sys_cdnamespace() which switches to a
> new namespace.

Can you give a reason why sys_chdir() shouldn't have that behaviour?

> Effectively the process's current->namespace has to be modified,
> for the process to be effectively work in the new namespace.

Or just remove current->namespace.  It's entire purpose seems to be to
prevent namespaces from being first class objects.  The idea of
"current namespace" is adequately represented by
current->fs->mnt_root->mnt_namespace IMHO.

-- Jamie
