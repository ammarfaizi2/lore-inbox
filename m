Return-Path: <linux-kernel-owner+w=401wt.eu-S1763003AbWLKSSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763003AbWLKSSG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763004AbWLKSSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:18:05 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:33485 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763003AbWLKSSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:18:03 -0500
Date: Mon, 11 Dec 2006 19:18:13 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>, Herbert Poetzl <herbert@13thfloor.at>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
Message-ID: <20061211181813.GB18963@aepfle.de>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de> <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org> <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org> <20061211180414.GA18833@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20061211180414.GA18833@aepfle.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, Olaf Hering wrote:

> On Mon, Dec 11, Linus Torvalds wrote:
> 
> > +static char __initdata linux_banner[] =
> > +	"Linux version " UTS_RELEASE
> > +	" (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ")"
> > +	" (" LINUX_COMPILER ")"
> > +	" " UTS_VERSION "\n";
> 
> main.o gets linked after misc.o, so this will not work. Having both as
> globals in the same c file in the right order, that will probably fix
> it. Let my try.

Hmm, even moving this to linux_banner doesnt work, just because
__initdata is in a different section.
Only 'const char static_linux_banner' works.
Maybe the guy who did it back in Summer 2000 should have asked for a standard?!


+++ linux-2.6/init/version.c
@@ -34,6 +34,13 @@ struct uts_namespace init_uts_ns = {
 };
 EXPORT_SYMBOL_GPL(init_uts_ns);
 
+/* keep this static string before linux_banner */
+char __initdata static_linux_banner[] =
+       "Linux version " UTS_RELEASE
+       " (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ")"
+       " (" LINUX_COMPILER ")"
+       " " UTS_VERSION "\n";
+
 const char linux_banner[] =
        "Linux version %s (" LINUX_COMPILE_BY "@"
        LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") %s\n";
