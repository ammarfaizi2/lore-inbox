Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262832AbVAQSgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262832AbVAQSgV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 13:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbVAQScu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 13:32:50 -0500
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:5019 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S262558AbVAQSbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 13:31:23 -0500
Date: Mon, 17 Jan 2005 13:31:02 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [RFC] shared subtrees
In-reply-to: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <41EC0466.9010509@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Al Viro wrote:
> 	3. bind
> 
> bind works almost identically to mount; new vfsmount is created for every
> place that gets propagation from mountpoint and propagation is set up to
> mirror that between the mountpoints.  However, there is a difference: unlike
> the case of mount, vfsmount we were going to attach (say it, A) has some
> history - it was created as a  copy of some pre-existing vfsmount V.  And
> that's where the things get interesting:
> 	* if V is contained in some p-node p, A is placed into the same
> p-node.  That may require merging one of the p-nodes we'd just created
> with p (that will be the counterpart of the p-node containing the mountpoint).
> 	* if V is owned by some p-node p, then A (or p-node containing A)
> becomes owned by p.
> 

Corner case: how do we handle the case where:

mount --make-shared /foo
mount --bind /foo /foo/bar

A nested --bind without sharing makes sense, but doesn't when sharing is
enabled (infinite loop).

How about a rule that states that for all Ai,Aj in p-node p, Ai must not
parent Aj in the vfsmount tree.  This can be enforced at graft time.

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

iD8DBQFB7ARmdQs4kOxk3/MRAjkjAKCEBWx7iOWhTu1EOR2ABMr5abW4RgCdGlMu
u/Isw16fgZaErR3BErWq3JI=
=mJnu
-----END PGP SIGNATURE-----
