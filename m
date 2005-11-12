Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbVKLXbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbVKLXbn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 18:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbVKLXbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 18:31:42 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:32472
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S964864AbVKLXbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 18:31:41 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Why did oldconfig's behavior change in 2.6.15-rc1?
Date: Sat, 12 Nov 2005 17:31:25 -0600
User-Agent: KMail/1.8
References: <200511121656.29445.rob@landley.net>
In-Reply-To: <200511121656.29445.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511121731.25982.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 November 2005 16:56, Rob Landley wrote:
> Linus says if we're going to test something, test -rc1, so I did.
>
> It went boing.
>
> I'm still trying to get -skas0 working on x86-64, but this was a standard
> x86 build...
>
> Rob

Very, very strange:

> make ARCH=um allnoconfig
> cat >> .config << EOF
CONFIG_MODE_SKAS=y
CONFIG_BINFMT_ELF=y
CONFIG_HOSTFS=y
CONFIG_SYSCTL=y
CONFIG_STDERR_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_UBD=y
CONFIG_TMPFS=y
CONFIG_SWAP=y
CONFIG_LBD=y
CONFIG_EXT2_FS=y
CONFIG_PROC_FS=y
EOF
> make ARCH=um oldconfig
> grep SKAS .config
# CONFIG_MODE_SKAS is not set

Why did oldconfig switch off CONFIG_MODE_SKAS?  It didn't do that before.  
Hmmm...  Rummage, rummage...  Darn it, it's position dependent.  _And_ 
version dependent.

Ok, now I have to put the new entries at the _beginning_.  Appending them 
doesn't work anymore, it now ignores any symbol it's already seen, so you 
can't easily start with allnoconfig, switch on just what you want, and expect 
oldconfig to do anything intelligent.

That kinda sucks.  Oh well, I can have sed rip out the old symbols before I 
append the new ones.  Here's hoping it's not _that_ position dependent...

Rob
