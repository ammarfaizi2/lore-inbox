Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267615AbRGZEm4>; Thu, 26 Jul 2001 00:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267620AbRGZEmr>; Thu, 26 Jul 2001 00:42:47 -0400
Received: from ns.suse.de ([213.95.15.193]:35334 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S267615AbRGZEmc>;
	Thu, 26 Jul 2001 00:42:32 -0400
Date: Thu, 26 Jul 2001 06:42:37 +0200
From: Thorsten Kukuk <kukuk@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Leif Sawyer <lsawyer@gci.com>, linux-kernel@vger.kernel.org
Subject: Re: Sparc-64 kernel build fails on version.h during 'make oldconfig'
Message-ID: <20010726064237.A26837@suse.de>
Mail-Followup-To: Thorsten Kukuk <kukuk@suse.de>,
	"David S. Miller" <davem@redhat.com>, Leif Sawyer <lsawyer@gci.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <BF9651D8732ED311A61D00105A9CA315053E1265@berkeley.gci.com> <15199.18841.458617.411246@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <15199.18841.458617.411246@pizda.ninka.net>; from davem@redhat.com on Wed, Jul 25, 2001 at 03:35:05PM -0700
Organization: SuSE GmbH, Nuernberg, Germany
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, Jul 25, David S. Miller wrote:

> 
> Leif Sawyer writes:
>  > When 'bootstrapping' a new kernel:
>  > 
>  > cp ../oldlinux/.config .
>  > make oldconfig
>  > make dep
>  > ...
>  > /usr/src/linux/include/linux/udf_fs_sb.h:22: linux/version.h: No such file
>  > or directory
> 
> Something is terribly wrong with either your system tools or
> this ".config" you are using.

No, I send you and on the sparclinux list already a patch for 
this 2 weeks ago. The problem is, that make dep will build at first
sparc specific programs (archdep) which needs linux/version.h, but 
make dep does create linux/version.h only after building this tools. The
following patch solved the problem for me:

--- linux/Makefile
+++ linux/Makefile      2001/05/21 12:57:07
@@ -440,7 +440,7 @@
 sums:
        find . -type f -print | sort | xargs sum > .SUMS
 
-dep-files: scripts/mkdep archdep include/linux/version.h
+dep-files: include/linux/version.h scripts/mkdep archdep
        scripts/mkdep -- init/*.c > .depend
        scripts/mkdep -- `find $(FINDHPATH) -name SCCS -prune -o -follow -name \
*.h ! -name modversions.h -print` > .hdepend
        $(MAKE) $(patsubst %,_sfdep_%,$(SUBDIRS)) _FASTDEP_ALL_SUB_DIRS="$(SUBDI
RS)"


-- 
Thorsten Kukuk       http://www.suse.de/~kukuk/        kukuk@suse.de
SuSE GmbH            Deutschherrenstr. 15-19       D-90429 Nuernberg
--------------------------------------------------------------------    
Key fingerprint = A368 676B 5E1B 3E46 CFCE  2D97 F8FD 4E23 56C6 FB4B
