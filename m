Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVBAHDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVBAHDL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 02:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVBAHDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 02:03:10 -0500
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:52407 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S261593AbVBAHC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 02:02:58 -0500
Date: Tue, 01 Feb 2005 02:02:29 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [RFC] shared subtrees
In-reply-to: <1107224911.8118.65.camel@localhost>
To: Ram <linuxram@us.ibm.com>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <41FF2985.8000903@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk>
 <41FABD4E.6050701@sun.com> <1107224911.8118.65.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ram wrote:
> On Fri, 2005-01-28 at 14:31, Mike Waychison wrote:
> 
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>Al Viro wrote:
>>
>>
>>>OK, here comes the first draft of proposed semantics for subtree
>>>sharing.  What we want is being able to propagate events between
>>>the parts of mount trees.  Below is a description of what I think
>>>might be a workable semantics; it does *NOT* describe the data
>>>structures I would consider final and there are considerable
>>>areas where we still need to figure out the right behaviour.
>>>
>>
>>Okay, I'm not convinced that shared subtrees as proposed will work well
>>with autofs.
>>
>>The idea discussed off-line was this:
>>
>>When you install an autofs mountpoint, on say /home, a daemon is started
>>to service the requests.  As far as the admin is concerned, an fs is
>>mounted in the current namespace, call it namespaceA.  The daemon
>>actually runs in it's one private namespace: call it namespaceB.
>>namespaceB receives a new autofs filesystem: call it autofsB.  autofsB
>>is in it's own p-node.  namespaceA gets an autofsA on /home as well, and
>>autofsA is 'owned' by autofsB's p-node.
> 
> 
> Mike, multiple parsing through the problem definition, still did not
> make the problem clear. What problem is autofs trying to solve using
> namespaces?
> 
> My guess is you dont want to see a automount taking place in namespaceA,
> when a automount takes place in namespaceB, even though
> the automount-point is in a shared subtree?
> 
> Sorry don't understand automount's requirement in the first place,
> RP

The major concern for automounting is that currently, if you start an
automount daemon in the primary namespace, and some process clones off
into a new namespace with clone(CLONE_NS), then there is no way for the
daemon running in the first namespace to automount (let alone expire)
any mounts in the second namespace.  There doesn't exist a way for the
daemon to mount(2) nor umount(2) across namespaces.

The proposed solution for this is to use shared and private subtrees to
have the daemon run in it's own namespace, with the primary and any
derivative namespaces inheriting the automounts.  I'm not convinced that
it'd work though.

Does this clarify?

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB/ymFdQs4kOxk3/MRAjuWAKCJfX+jZMUlm9ncM199Q0nJpxwPKQCgjQFE
VTNmwXtmKOLVlrqBd2AzfYk=
=tESv
-----END PGP SIGNATURE-----
