Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbVL3KP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbVL3KP3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 05:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbVL3KP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 05:15:29 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:5030 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751237AbVL3KP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 05:15:28 -0500
Date: Fri, 30 Dec 2005 11:15:27 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: "Linda A. Walsh" <lkml@tlinx.org>
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: patch for "scripts/package/buildtar" to pickup "localversion" on "/boot" file objects
Message-ID: <20051230101527.GA18045@harddisk-recovery.com>
References: <43A5F058.1060102@tlinx.org> <20051219071959.GJ13985@lug-owl.de> <43A7304B.2070103@tlinx.org> <20051219223030.GM13985@lug-owl.de> <43A762E0.5020608@tlinx.org> <43B4D4AC.5020303@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B4D4AC.5020303@tlinx.org>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 10:33:16PM -0800, Linda A. Walsh wrote:
> BTW -- here is a "quick" patch to pick up the "local version" to append to
> the files in "/boot" for the "tar[x]-pkg's"...
> 
> --- scripts/package/buildtar.orig       2005-11-24 14:10:21.000000000 -0800
> +++ scripts/package/buildtar    2005-12-29 22:26:34.543513254 -0800
> @@ -15,7 +15,8 @@
> #
> # Some variables and settings used throughout the script
> #
> -version="${VERSION}.${PATCHLEVEL}.${SUBLEVEL}${EXTRAVERSION}${EXTRANAME}"
> +version="$(grep UTS_RELEASE include/linux/version.h| \
> +       sed 's/^#[^"]*"// ; s/"$// ')"

A much easier way is to use:

  version="${KERNELRELEASE}"

A patch for this is already in -mm, I expect/hope Linus will pick it up
after 2.6.15.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
