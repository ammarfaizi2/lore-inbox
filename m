Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVAaRUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVAaRUf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 12:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVAaRUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 12:20:35 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:42984 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S261261AbVAaRUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 12:20:00 -0500
Date: Mon, 31 Jan 2005 12:19:03 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [RFC] shared subtrees
In-reply-to: <Pine.LNX.4.61.0501291218290.1607@donald.themaw.net>
To: raven@themaw.net
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <41FE6887.3090006@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk>
 <41FABD4E.6050701@sun.com> <Pine.LNX.4.61.0501291218290.1607@donald.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Sorry for the bad quoting below:

raven@themaw.net wrote:
> On Fri, 28 Jan 2005, Mike Waychison wrote:
> 
> Al Viro wrote:
> 
>>>> OK, here comes the first draft of proposed semantics for subtree
>>>> sharing.  What we want is being able to propagate events between
>>>> the parts of mount trees.  Below is a description of what I think
>>>> might be a workable semantics; it does *NOT* describe the data
>>>> structures I would consider final and there are considerable
>>>> areas where we still need to figure out the right behaviour.
>>>>
> 
> Okay, I'm not convinced that shared subtrees as proposed will work well
> with autofs.
> 
> 
>> OK. I've read the thread but haven't digested it so you'll have to put
>> up with some stupid questions.
> 
> 
> The idea discussed off-line was this:
> 
> When you install an autofs mountpoint, on say /home, a daemon is started
> to service the requests.  As far as the admin is concerned, an fs is
> mounted in the current namespace, call it namespaceA.  The daemon
> actually runs in it's one private namespace: call it namespaceB.
> namespaceB receives a new autofs filesystem: call it autofsB.  autofsB
> is in it's own p-node.  namespaceA gets an autofsA on /home as well, and
> autofsA is 'owned' by autofsB's p-node.
> 
> So:
> 
> autofsB -> autofsB
> and
> autofsB -> autofsA
> 
> Effectively, namespaceA has a private instance of autofsB in its tree.
> 
> The problem is this:
> 
> Assume /home/mikew is accessed in namespaceA.  The daemon running in
> namespaceB gets the event, and mounts an nfs vfsmount on autofsB.  This
> event is propagated back to autofsA.
> 
> 
>> Which condition (or action) in the definition implies
> 
>> autofsB -> autofsA
> 

autofsB -> autofsA indicates that mount events are propagated from
autofsB to autofsA.

Eg: if you have two mounts (A, B) in the same p-node, then

A -> B
and
B -> A

By definition, a mountpoint (A) alone in a one element p-node has the
property:

A -> A

Which doesn't mean much, other than to show that A is in a p-node.

If you have a p-node p' owned by p-node p, then all mountpoints i' in p'
will have the following relationship with all mountpoints i in p:

i -> i'

but not the reverse (one-way relationship).

> 
> (Problem 1: how do you block access to /home/mikew in namespaceA?)
> 
> Next, a CLONE_NS is done in namespaceA, creating namespaceA'.  the
> homedir on /home/mikew is also copied.
> 
> Now, in namespaceA', what happens when a user umount's /home/mikew?  We
> haven't yet determined how to handle umount event propagation, but it
> appears likely that it will be *a hard thing to do*.
> 
> 
>> No I haven't spent enough time on the RFC buy into this one.
>> So I'll just say it looks like something is missing in this argument.
> 
>> Perhaps the later is namespaceC?
> 

Sure, it doesn't matter, namespaceA' is an arbitrary name.

HTH,

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

iD8DBQFB/miHdQs4kOxk3/MRArCsAJ9PxyxE7crSRk4R0OMB4yppH10wpQCfeQO8
qk6kcExaN7rzJOi4KoRyXoY=
=VvFb
-----END PGP SIGNATURE-----
