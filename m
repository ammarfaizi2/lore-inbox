Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265899AbSKBIvy>; Sat, 2 Nov 2002 03:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265900AbSKBIvy>; Sat, 2 Nov 2002 03:51:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34827 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265899AbSKBIvw>;
	Sat, 2 Nov 2002 03:51:52 -0500
Message-ID: <3DC3937F.80504@pobox.com>
Date: Sat, 02 Nov 2002 03:57:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2/11  Ext2/3 Updates: Extended attributes, ACL, etc.
References: <E186ZRR-0006tS-00@snap.thunk.org> <3DBEC3E6.9050908@pobox.com> <20021101032159.GA12031@think.thunk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:

>I'm not sure ext2meta will be sufficient.  It's not just a matter of
>modifying the on-disk metadata, as would be needed for defrag, but I
>would also need to modify some of the in-core data structions in the
>ext2/3 filesystem data structures.  For example, when you resize the
>filesystem, you need to increase the number of group descriptors,
>which means you need to kmalloc, copy, and then kfree sbi->group_desc
>out from under the mounted filesystem.
>
>No doubt ext2meta could be modified so it could "reach out and touch"
>internal ext2/3 fileststem data structures in core.  But the locking
>issues involved get really messy.
>  
>

Like Al mentioned... any merge of ext[23]meta would be inside ext[23].o, 
so it would be a first class object and not some random module sticking 
its fingers in there.  I looked at the locking issue too (though 
admittedly not in-depth for filesystem resize), and it's not different 
at all from existing locking, both in 2.4.x and 2.5.x.  It's 
intentionally pretty darn compatible with existing locking :)

I'll post a patch in the next couple weeks...

    Jeff




