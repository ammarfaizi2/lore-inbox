Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVAOFVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVAOFVP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 00:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVAOFVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 00:21:14 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:24593 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262217AbVAOFUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 00:20:52 -0500
Date: Sat, 15 Jan 2005 06:20:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.29-rc2
Message-ID: <20050115052050.GF4274@stusta.de>
References: <20050112151334.GC32024@logos.cnet> <20050114225555.GA17714@steffen-moser.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050114225555.GA17714@steffen-moser.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 11:55:55PM +0100, Steffen Moser wrote:

>...
>  - fsa01 (problem occurs):
>...
>  | modutils               2.4.5
>...
>  - gateway (no problem):
>...
>  | modutils               2.4.12
>....

OK, this seems to be the problem:
modutils before 2.4.10 don't know about EXPORT_SYMBOL_GPL.


Please upgrade modutils on fsa01 and report whether it fixes the 
problem.


If this was the problem, the patch below should be sufficient
(modutils 2.4.10 isn't a very strong dependency - even Debian stable 
ships 2.4.15).


<--  snip  -->


For support of EXPORT_SYMBOL_GPL, at least modutils 2.4.10 is required.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.4.29-rc2-full/Documentation/Changes.old	2005-01-15 06:17:46.000000000 +0100
+++ linux-2.4.29-rc2-full/Documentation/Changes	2005-01-15 06:18:26.000000000 +0100
@@ -52,7 +52,7 @@
 o  Gnu make               3.77                    # make --version
 o  binutils               2.9.1.0.25              # ld -v
 o  util-linux             2.10o                   # fdformat --version
-o  modutils               2.4.2                   # insmod -V
+o  modutils               2.4.10                  # insmod -V
 o  e2fsprogs              1.25                    # tune2fs
 o  jfsutils               1.0.12                  # fsck.jfs -V
 o  reiserfsprogs          3.6.3                   # reiserfsck -V 2>&1|grep reiserfsprogs
@@ -156,11 +156,8 @@
 Modutils
 --------
 
-Upgrade to recent modutils to fix various outstanding bugs which are
-seen more frequently under 2.4.x, and to enable auto-loading of USB
-modules.  In addition, the layout of modules under
-/lib/modules/`uname -r`/ has been made more sane.  This change also
-requires that you upgrade to a recent modutils.
+Upgrade to recent modutils is required for support of
+EXPORT_SYMBOL_GPL.
 
 Mkinitrd
 --------

