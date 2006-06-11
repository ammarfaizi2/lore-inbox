Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWFKMrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWFKMrY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 08:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWFKMrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 08:47:23 -0400
Received: from canuck.infradead.org ([205.233.218.70]:28119 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751244AbWFKMrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 08:47:23 -0400
Subject: Re: [PATCH] header install: cosmetic cleanups to kbuild
	infrastructure
From: David Woodhouse <dwmw2@infradead.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060611121005.GA1342@mars.ravnborg.org>
References: <20060611121005.GA1342@mars.ravnborg.org>
Content-Type: text/plain
Date: Sun, 11 Jun 2006 13:47:19 +0100
Message-Id: <1150030039.5213.254.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-11 at 14:10 +0200, Sam Ravnborg wrote:
> -headers_install: include/linux/version.h
> +headers_install: prepare 

That breaks cross-export of headers when we don't have a cross-compiler.

I care about this case because it's how we do glibc-kernheaders for
Fedora at the moment -- we build a tarball containing _all_ the headers,
and that tarball is used as source for a separate glibc-kernheaders
package, after reviewing the changes in it.

for a in x86_64 s390 ia64 powerpc sparc64; do
        make ARCH=$a INSTALL_HDR_PATH=/tmp/fish/$a headers_install
done
cd /tmp/fish
mv usr usr.$$
mv x86_64 usr
mv usr/include/asm usr/include/asm-bix86
mv sparc64/include/asm usr/include/asm-bisparc
mv sparc64/include/asm-sparc{,64} usr/include
for a in s390 ia64 powerpc; do
        mv -v $a/include/asm usr/include/asm-$a
        rm -rf $a
done


-- 
dwmw2

