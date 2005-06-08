Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVFHTRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVFHTRE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 15:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVFHTRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 15:17:04 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:45464 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261545AbVFHTRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 15:17:00 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] ppc64: Fix PER_LINUX32 behaviour
Date: Wed, 8 Jun 2005 20:49:48 +0200
User-Agent: KMail/1.7.2
Cc: Paul Mackerras <paulus@samba.org>, akpm@osdl.org, anton@samba.org,
       linux-kernel@vger.kernel.org, jk@blackdown.de
References: <17062.56723.535978.961340@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0506081022030.2286@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506081022030.2286@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506082049.51707.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Middeweken 08 Juni 2005 19:24, Linus Torvalds wrote:

> I think this is a feature, not a bug, and I suspect you just broke
> compiling a 64-bit kernel by default on ppc64.
> 
> Dammit, the system _is_ ppc64. The fact that the uname binary is not is
> neither here nor there. It's like x86 that reports i386/i486/.. depending 
> on what the machine is. If uname wants to make it clear that uname has 
> been compiled for 32-bit ppc, then it can damn well output "ppc" on its 
> own without asking the kernel what the kernel is.

The whole point of the LINUX32 personality is to mangle the output of
uname, it doesn't do anything else on the architectures I have worked 
with (s390, x86_64 and ppc64).

Even with the patch, the normal operation would be to use PER_LINUX
for everything, so the kernel build works as expected unless you pass
the obsolete "fakeppc" boot parameter.

With the LINUX32 personality, you can build 32 bit binaries through
autoconf, rpmbuild, or the kernel without pretending to be
cross-compiling. It may not be the best solution, but people seem to
rely on it and the patch brings ppc64 in line with how it works on
the other architectures.

	Arnd <><
