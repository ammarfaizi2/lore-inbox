Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269784AbUHZX6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269784AbUHZX6j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 19:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUHZX4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 19:56:04 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:17615 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S269435AbUHZXyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:54:39 -0400
Message-ID: <412E783C.9050202@namesys.com>
Date: Thu, 26 Aug 2004 16:54:36 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christophe Saout <christophe@saout.de>
CC: Andrew Morton <akpm@osdl.org>, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>	 <20040825152805.45a1ce64.akpm@osdl.org> <412D9FE6.9050307@namesys.com>	 <20040826014542.4bfe7cc3.akpm@osdl.org> <1093522729.9004.40.camel@leto.cs.pocnet.net>
In-Reply-To: <1093522729.9004.40.camel@leto.cs.pocnet.net>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout wrote:

>Am Donnerstag, den 26.08.2004, 01:45 -0700 schrieb Andrew Morton:
>
>  
>
>>And describe the "plugin" system.  Why does the filesystem need such a
>>thing (other filesystems get their features via `patch -p1')?
>>    
>>
>
>Ok, let me try. (Hans, please don't shoot me if I don't get every detail
>right, I'm trying to simplify and translate)
>
>The reiser4 core is just a big and fast storage layer using a single
>tree. It is bound to a mount point and uses the page cache to manage its
>memory. The only thing it can do on its own is to flush dirty data to
>the disk when the VM wants to (memory pressure) or the VFS wants to
>(unmount, sync) or some "plugin" wants to.
>Additionally it's completely atomic (with respect to crashes, no
>isolation like in databases), comparable to data=journal but without the
>overhead of using a journal for everything.
>
>Up to this point there are no users of this "database" and it does not
>implement any of the VFS methods for a filesystem (except mount and
>unmount perhaps).
>
>All the functionality is provided to
>
^to^via
apologies for the correction but it might confuse some

> the plugins. You can insert,
>remove, lookup or modify key:object pairs (with an index into the
>object). The object
>
^object^item
perform that substitution everywhere in this email

> is a sequence of units. For files a unit would be 1
>byte and the index would be the byte offset. For directories the unit
>would be 1 entry and the index would be the filename.
>
>Now there are some plugins that define how the storage layout on the
>disk is (some kind of "backend" plugins).
>
>*And* there are plugins which are users of the "reiser4 client API" and
>implement the actual VFS methods.
>
>There's a UNIX directory plugin and a UNIX file plugin.
>
>Directories, inodes and file content are just key:object pairs and the
>plugins know how to operate on these.
>
>There's a new plugin in work that also implements UNIX file semantics
>but stores the data for that file encrypted and/or compressed.
>
>These plugins live between the VFS and the storage layer.
>
>Just like the filesystems live between the VFS and the block layer (Hans
>would say that filesystems are VFS plugins ;-)).
>
>  
>
>>And what are the licensing implications of plugins?  Are they derived
>>works?  Must they be GPL'ed?
>>    
>>
>
>I suppose yes, at least currently, since they can only be linked with
>reiser4, there's no module infrastructure.
>
>  
>

