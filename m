Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262848AbVAQTbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbVAQTbH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 14:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbVAQTbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 14:31:07 -0500
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:64959 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S262848AbVAQTau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 14:30:50 -0500
Date: Mon, 17 Jan 2005 14:30:27 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [RFC] shared subtrees
In-reply-to: <20050117190028.GF24830@fieldses.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <41EC1253.8080902@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk>
 <41EC0466.9010509@sun.com> <20050117190028.GF24830@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

J. Bruce Fields wrote:
> On Mon, Jan 17, 2005 at 01:31:02PM -0500, Mike Waychison wrote:
> 
>>Corner case: how do we handle the case where:
>>
>>mount --make-shared /foo
>>mount --bind /foo /foo/bar
>>
>>A nested --bind without sharing makes sense, but doesn't when sharing is
>>enabled (infinite loop).
> 
> 
> How does this force an infinite loop?  I don't see it.
> 

Well, if I understand it correctly:

(assuming /foo is vfsmount A)

$> mount --make-shared /foo

will make A->A

$> mount --bind /foo /foo/bar

will create a vfsmount B based off A, but because A is in a p-node,
A->B, B->A.

Then, we attach B to A in the vfsmount tree, but because A->B in the
propagation tree, B also gets a vfsmount C added on dentry 'bar'.
Recurse ad infinitum.

Make sense?

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

iD8DBQFB7BJTdQs4kOxk3/MRAm9HAJ9gLZC9N1QkpriYtwE6pfJ7u47FyACfYXwU
tTIEFgSUeoocka4RZVe9McI=
=iWNB
-----END PGP SIGNATURE-----
