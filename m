Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVGSUIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVGSUIh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 16:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVGSUIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 16:08:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42387 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261488AbVGSUIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 16:08:36 -0400
Date: Tue, 19 Jul 2005 13:11:42 -0700
From: Nick Wilson <njw@osdl.org>
To: randy_dunlap <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [announce] 'patchview' script
Message-ID: <20050719201142.GB19437@njw.pdx.osdl.net>
References: <20050719115103.3e10ce0a.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050719115103.3e10ce0a.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2005 at 11:51:03AM -0700, randy_dunlap wrote:
> 
> Hi,
> 
> Someone asked me about a tool like this and I didn't know of one,
> so I made this little script.
> 
> 'patchview' merges a patch file and a source tree to a set of
> temporary modified files.  This enables better patch (re)viewing
> and more viewable context.  (hopefully)
> 
> Are there already other tools that do something similar to this?
> (other than SCMs)
> 
> 
> The patchview script is here:
>   http://www.xenotime.net/linux/scripts/patchview

Hey Randy,

The mktemp command fails for me, but patchview keeps on going.

[njw@njw ~/tmp]$ patchview mypatch.patch linux-2.6.13-rc3
mktemp: cannot make temp dir /home/njw/tmp/XXXXXX/tmp.xV1xRT: No such file or directory
failed mktemp for patch files dir.
mkdir: cannot create directory `/fs': Permission denied
cp: cannot create regular file `/fs/Kconfig': No such file or directory
mkdir: cannot create directory `/fs': Permission denied
cp: cannot create regular file `/fs/Makefile': No such file or directory
[ ... ]


This patch makes mktemp work correctly for me and causes patchview to exit
if it happens to fail.

Thanks,

Nick Wilson

--- patchview.orig	2005-07-19 12:50:20.000000000 -0700
+++ patchview	2005-07-19 13:07:12.000000000 -0700
@@ -48,7 +48,7 @@
 else
 	TMPDIR=/tmp
 fi
-WORKDIR=`mktemp -d -p ${TMPDIR}/XXXXXX` || echo "failed mktemp for patch files dir."
+WORKDIR=`mktemp -d -p ${TMPDIR} XXXXXX` || { echo "failed mktemp for patch files dir."; exit 1; }
 
 pfiles=`lsdiff --strip 1 $patchfile`
 
