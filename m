Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVA0Vi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVA0Vi4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 16:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVA0Vi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 16:38:56 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:52726 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261231AbVA0Vil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 16:38:41 -0500
Message-ID: <41F95F79.6080904@comcast.net>
Date: Thu, 27 Jan 2005 16:39:05 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
References: <20050127101117.GA9760@infradead.org>  <20050127101322.GE9760@infradead.org>  <41F92721.1030903@comcast.net> <1106848051.5624.110.camel@laptopd505.fenrus.org> <41F92D2B.4090302@comcast.net> <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Linus Torvalds wrote:
> 

[...]

> 
> Your suggestion of 256MB of randomization for the stack SIMPLY IS NOT 
> ACCEPTABLE for a lot of uses. People on 32-bit archtiectures have issues 
> with usable virtual memory areas etc.
> 

I feel the need to point something out here.

[TEXT][BRK][MMAP---------------][STACK]

Here's a normal layout.

[TEXT][BRK][MMAP-------][STACK][MMAP--]

Is this one any worse?  Just bias non-executable mappings above the
stack when, say, half of VMA is used up.  Prevent executable mappings
from being created up there because PaX' PAGEEXEC and Exec Shield's
emulation will be affected by a high-mapping (PaX falls back to
kernel-assisted MMU walking, which can be very high overhead; ES just
makes everything below the area executable).

So, you can do it without losing VMA, in theory.


[...]

> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+V94hDd4aOud5P8RAqv1AJ9iazEKh//yeaTdraUou9KLQCUG0wCfVbo2
kXYvkauZ8+wC7J3nN5IzoTY=
=tvyp
-----END PGP SIGNATURE-----
