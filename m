Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbUJYPuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbUJYPuD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbUJYPeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:34:12 -0400
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:3043 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S261963AbUJYP32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:29:28 -0400
Date: Mon, 25 Oct 2004 11:29:17 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [PATCH 20/28] HOTPLUG: call_usermodehelper callback support
In-reply-to: <20041025151842.GA1858@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       raven@themaw.net
Message-id: <417D1BCD.6020005@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <10987156903663@sun.com> <10987157204162@sun.com>
 <20041025151842.GA1858@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christoph Hellwig wrote:
> On Mon, Oct 25, 2004 at 10:48:40AM -0400, Mike Waychison wrote:
> 
>>This patch extends the call_usermodehelper api by adding a callback variant.
>>The callback is made right when the system is about to call execve into the
>>new process.  This allows for the caller to provide changes to the default
>>environment right before the exec takes place.  Note: the context of the
>>callback will be _from within another process_.
> 
> 
> I don't like this at all.  First it's the usual fork() + exec() vs spawn() with
> gazillions of arguments debatte, second this sounds far too complex to do it in
> kernelspace to me.  Why can't you do the enviroment changes from the program
> beeing executed?
> 

I want to be able to do two things:

- - To 'call_usermodehelper' a program, but in current's namespace.
Namespaces can't be passed around in userspace.

- - To give the execed program an open file.  The current interface
doesn't allow me to do that.

I figured the _cb way of doing it remove any need for adding ad-hoc api
anytime somebody wants to tweak a task before calling execve.

Does this clarify why I added this?

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

iD4DBQFBfRvNdQs4kOxk3/MRAvInAJYmn4GlPasI0r7VcwSKv03GXoygAJ90FWDM
LVQOfOrpbKp7NDSmlFRt+A==
=aQ04
-----END PGP SIGNATURE-----
