Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262865AbVAQUMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbVAQUMR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 15:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbVAQUMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 15:12:16 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:21746 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S262865AbVAQULl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 15:11:41 -0500
Date: Mon, 17 Jan 2005 15:11:18 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [RFC] shared subtrees
In-reply-to: <20050117193206.GH24830@fieldses.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <41EC1BE6.1030506@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk>
 <41EC0466.9010509@sun.com> <20050117190028.GF24830@fieldses.org>
 <41EC1253.8080902@sun.com> <20050117193206.GH24830@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

J. Bruce Fields wrote:
> On Mon, Jan 17, 2005 at 02:30:27PM -0500, Mike Waychison wrote:
> 
>>Well, if I understand it correctly:
>>
>>(assuming /foo is vfsmount A)
>>
>>$> mount --make-shared /foo
>>
>>will make A->A
>>
>>$> mount --bind /foo /foo/bar
>>
>>will create a vfsmount B based off A, but because A is in a p-node,
>>A->B, B->A.
>>
>>Then, we attach B to A in the vfsmount tree, but because A->B in the
>>propagation tree, B also gets a vfsmount C added on dentry 'bar'.
>>Recurse ad infinitum.
>>
>>Make sense?
> 
> 
> Yes, but couldn't the whole thing be avoided if we just agreed that the
> propagation wasn't set up till after B was attached to A?

I don't think that solves the problem.  B should receive copies (with
shared semantics if called for) of all mountpoints C1,..,Cn that are
children of A if A->A.  This is regardless of whether or not propagation
occurs before or after the attach.

Allowing this is like allowing directory aliasing in the sense that an
aliased directory that is nested within itself opens us to
badness/headaches 8)

I still think the only way to handle this is to disallow vfsmounts in a
p-node to have (grand)parent-child relationships.  This may have to be
extended to the 'owned by' case as well.

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

iD8DBQFB7BvmdQs4kOxk3/MRAkDnAJ0SgZ4KJJXu5gHpCAmgZY199ts3sgCeKFoD
qpQqB+hkExDyuGLOfG8Hnso=
=H4nE
-----END PGP SIGNATURE-----
