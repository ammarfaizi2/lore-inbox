Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267313AbTBFOpl>; Thu, 6 Feb 2003 09:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267319AbTBFOpl>; Thu, 6 Feb 2003 09:45:41 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:19442 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id <S267313AbTBFOpk>;
	Thu, 6 Feb 2003 09:45:40 -0500
Message-Id: <200302061502.KAA06538@moss-shockers.ncsc.mil>
Date: Thu, 6 Feb 2003 10:02:37 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: [BK PATCH] LSM changes for 2.5.59
To: hch@infradead.org
Cc: greg@kroah.com, torvalds@transmeta.com, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: wWxe6jvvExDOR7bwD0OaLA==
X-Mailer: dtmail 1.2.0 CDE Version 1.2 SunOS 5.6 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig wrote:
> The wrong thing here is that you pass in the object itself, not
> it's ACC-relevant attributes.

That's no different than permission(), and it is the style of interface
suggested by Linus originally for LSM.  SELinux did provide an
interface more akin to what you describe (passing the security
identifiers of the process and relevant objects and a value indicating
the operation).  But SELinux was also more tightly integrated into the
kernel.  The original guidance for LSM was to simply pass the objects
and to use separate hooks for different operations, moving the
processing entirely into the module.

Bringing this all up now is definitely pointless.  LSM wasn't developed
in secret, and you could have made your case for a different
approach/interface at the very beginning.  If you had made a case early
on, and had gotten Linus to sign off on it, then we certainly wouldn't
have objected to such an approach.

> No it seems not pointless.  You add tons of undesigned cruft to 2.5 that
> will have to be maintained through all of 2.6. unless Linus hopefully
> pulls the plug soon enough.  You still haven't even submitted a single
> example that actually uses LSM into mainline.

Not undesigned, but designed to meet guidance with which you disagree.
There is a difference.

The capabilities module is one example, albeit a limited one.  As for
modules like SELinux, it seems better to wait until all of the
necessary hooks have either been accepted or definitively rejected
before submitting an adapted form of the module for mainline.  After
this set of changes, the only thing remaining is the networking hooks,
which have already gone through a feedback cycle with the networking
maintainers and are being pruned and revised accordingly.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil



