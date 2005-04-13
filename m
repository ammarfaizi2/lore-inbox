Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVDMQ6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVDMQ6T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 12:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVDMQ6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 12:58:19 -0400
Received: from mail.shareable.org ([81.29.64.88]:22689 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261396AbVDMQ6L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 12:58:11 -0400
Date: Wed, 13 Apr 2005 17:57:46 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bulb@ucw.cz, 7eggert@gmx.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Message-ID: <20050413165746.GI12825@mail.shareable.org>
References: <20050412160409.GH10995@mail.shareable.org> <E1DLOI6-0001ws-00@dorka.pomaz.szeredi.hu> <20050412164401.GA14149@mail.shareable.org> <E1DLOfW-00020V-00@dorka.pomaz.szeredi.hu> <20050412171338.GA14633@mail.shareable.org> <E1DLQkL-0002DS-00@dorka.pomaz.szeredi.hu> <20050413125609.GA9571@vagabond> <E1DLjTV-0004oO-00@dorka.pomaz.szeredi.hu> <20050413161344.GC12825@mail.shareable.org> <E1DLl1x-0004uT-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DLl1x-0004uT-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> > Look up the rather large linux-kernel & linux-fsdevel thread "silent
> > semantic changes with reiser4" and it's followup threads, from last
> > year.
> 
> Wow, it's 700+ messages.  I got through the first 40, and already feel
> dizzy :)

It's easier if you skip the ones by Hans and their immediate followups :)

(Nothing personal, it's that Hans is mostly justifying reiser4's
behaviour, and the posts you really need to read aren't about reiser4).

> > It's already been tried.  You will also find sensible ideas on what
> > semantics it should have to do it properly.
> 
> OK, I understand the "slash -> directory, no-slash -> regular file"
> semantics.
> 
> How do you envision implementing this for "mount directory over file"?

Somewhere deep in that thread is a discussion between Al Viro and
Linus on it.

> A new mount flag indicating that it's only to be followed down if
> there's a slash after the mountpoint?

The new flag would indicate more than that: These mounts should be
detachable in the sense that deleting the file is possible, and
perhaps renamable/linkable too.  That's the stuff Al Viro discusses in
some detail in the big thread.

Ideally we'd like automounting, a bit like the Hurd's translators.
Attached to files (using an xattr or something, and executed with the
uid/gid of the file owner), and also per-user "pattern->action"
options for matching files with a certain type (e.g. tgz/zip/deb/rpm/xml).

But that can be added much later, as it's an orthogonal feature.

-- Jamie
