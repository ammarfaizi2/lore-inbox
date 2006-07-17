Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWGQTGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWGQTGz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 15:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWGQTGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 15:06:55 -0400
Received: from ns2.suse.de ([195.135.220.15]:4535 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751152AbWGQTGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 15:06:54 -0400
Message-ID: <44BBE007.1030209@suse.com>
Date: Mon, 17 Jul 2006 15:07:51 -0400
From: Jeff Mahoney <jeffm@suse.com>
Organization: SUSE Labs, Novell, Inc
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
Cc: Valdis.Kletnieks@vt.edu, 7eggert@gmx.de,
       Eric Dumazet <dada1@cosmosbay.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] reiserfs: fix handling of device names with /'s in them
References: <6xQ4C-6NB-43@gated-at.bofh.it> <6xQea-6ZX-13@gated-at.bofh.it> <E1G1QFx-0001IO-K6@be1.lrz> <44B7D97B.20708@suse.com> <44B9E6D5.2040704@namesys.com> <44BA61A2.5090404@suse.com> <44BA8214.7040005@namesys.com> <44BABB14.6070906@suse.com> <44BAE619.9010307@namesys.com> <44BAECE2.8070301@suse.com>            <44BAFDC3.7020301@namesys.com> <200607171808.k6HI8kjL018161@turing-police.cc.vt.edu> <44BBD400.3060504@suse.com> <44BBDCB5.8070906@namesys.com>
In-Reply-To: <44BBDCB5.8070906@namesys.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hans Reiser wrote:
> Jeff Mahoney wrote:
> 
>> Valdis.Kletnieks@vt.edu wrote:
>>
>>> On Sun, 16 Jul 2006 20:02:27 PDT, Hans Reiser said:
>>>> Create a mountpoint which knows how to resolve a/b without using a
>>>> "directory".
>>> And said mountpoint gets past the '/' interpretation in the VFS, how,
>> exactly?
>>
>>> fs/namei.c, do_path_lookup() does magic on a '/' on about the 3rd line.
>>> So you're going to get handed 'a'.
>>
>> That's where he started talking about how BSD gets namei() right by
>> allowing each file system to deal with it how it chooses.
>>
>> Personally, I think it's insane. On occasion, I've started to port
>> ReiserFS to BSD-like systems, 
> 
> Porting V3 to anything is insane.  Why would you even consider it?

Because I have an iBook I dual boot, and I wanted access to my reiserfs
file systems while using OSX. I'd call it more of a write-from-scratch
than a port, actually.

>> and I get so fed up with how you have to
>> reinvent the wheel for everything. There's something to be said for
>> replaceable-anything semantics, but personally I like the Linux model
>> and having an agreed-upon framework to work with.
> 
> Linux vs. BSD's namei is the difference between thinking you know how to
> do things and everyone should be forced into your mold, and thinking
> that someone will always be more clever, at the very least with regards
> to some special case you could never have anticipated.

That's great, except that by and large, the Linux VFS covers all the
common cases for you. This is such a ridiculous corner case that it
hardly justifies using the BSD namei() semantics.

>> I also think it's insane to come up with a reisermetafs to export procfs
>> information when a simple s#/#!# _on a single directory name_ will do
>> the job.
> 
> Or just create a parent directory and skip the metafs.  Look, I don't
> much care about the other details of coding it, but if you are changing
> !'s to /'s, as an architect my intuition says something is wrong and
> being papered over.  /'s are just fine, and what the block devices do is
> elegant.   You are doing a quick hack.

Yes, it is a quick hack. It's called being practical and consistent
until we can get around to removing slashes. Slashes *were* ok in block
device names until we started using them as path name components.

I've stated the reasons why adding a subdirectory is a bad idea multiple
times. The fix is already accepted. I'm done discussing this.

- -Jeff

- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEu+AGLPWxlyuTD7IRAjzqAKCk/nSheinL6AL4m+9YbG5FIo7f/ACeKWOd
Urif7U9OMFwX9JzywowrMiM=
=86sM
-----END PGP SIGNATURE-----
