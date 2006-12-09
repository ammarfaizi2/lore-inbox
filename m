Return-Path: <linux-kernel-owner+w=401wt.eu-S1161191AbWLIPtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161191AbWLIPtE (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 10:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030645AbWLIPtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 10:49:04 -0500
Received: from mail.tbdnetworks.com ([204.13.84.99]:42507 "EHLO
	mail.tbdnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936995AbWLIPtB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 10:49:01 -0500
Subject: Re: Why is "Memory split" Kconfig option only for EMBEDDED?
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
To: Alejandro Riveira =?ISO-8859-1?Q?Fern=E1ndez?= 
	<ariveira@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061209132742.7a25dcb5@localhost.localdomain>
References: <1165405350.5954.213.camel@titan.tbdnetworks.com>
	 <1165406299.3233.436.camel@laptopd505.fenrus.org>
	 <1165407548.5954.224.camel@titan.tbdnetworks.com>
	 <20061206131003.GF24140@stusta.de>
	 <20061209132742.7a25dcb5@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Organization: TBD Networks
Date: Sat, 09 Dec 2006 16:45:04 +0100
Message-Id: <1165679105.7455.116.camel@titan.tbdnetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-09 at 13:27 +0100, Alejandro Riveira Fernández wrote:
> El Wed, 6 Dec 2006 14:10:03 +0100
> Adrian Bunk <bunk@stusta.de> escribió:
> 
> > On Wed, Dec 06, 2006 at 01:19:08PM +0100, Norbert Kiesel wrote:
> > > On Wed, 2006-12-06 at 12:58 +0100, Arjan van de Ven wrote:
> > > > On Wed, 2006-12-06 at 12:42 +0100, Norbert Kiesel wrote:
> > > > > Hi,
> > > > > 
> > > > > I remember reading on LKML some time ago that using VMSPLIT_3G_OPT would
> > > > > be optimal for a machine with exactly 1GB memory (like my current
> > > > > desktop). Why is that option only prompted for after selecting EMBEDDED
> > > > > (which I normally don't select for desktop machines
> > > > 
> > > > because it changes the userspace ABI and has some other caveats.... this
> > > > is not something you should muck with lightly 
> > > > 
> > > 
> > > Hmm, but it's also marked EXPERIMENTAL. Would that not be the
> > > sufficient?  Assuming I don't use any external/binary drivers and a
> > > self-compiled kernel w//o any additional patches: is there really any
> > > downside?
> > 
> > - Wine doesn't work (I'm not sure about VMSPLIT_3G_OPT, but
> >                      VMSPLIT_2G definitely breaks Wine)
> 
>  I use VMSPLIT_3G_OPT=y and wine works just fine (only tested with one
>  program). Edgy + 2.6.19-rc1
> 
> 
> 
> > - AFAIR some people reported problems with some Java programs
> >   after fiddling with the vmsplit options
> > 
> > EMBEDDED isn't exactly the right way to hide it, but the vmsplit options 
> > aren't something you can safely change.
> > 

So far all first-hand experiences I heard of were positive (i.e. I did
not get an emaail from anyone saying: It had a negative effect for me),
so I propose to apply the patch from Con Kolivas. The wording in the
description still very strongly recommends to not change that value, and
it's still dependent on EXPERIMENTAL. I append the patch just because
it's short, it's also available from
http://www.kernel.org/pub/linux/kernel/people/ck/patches/2.6/2.6.19/2.6.19-ck2/patches/kconfig-expose_vmsplit_option.patch

The options to alter the vmsplit to enable more lowmem are hidden behind the
embedded option. Make it more exposed for -ck users and make the help menu
more explicit about what each option means.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 arch/i386/Kconfig |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6.19-ck2/arch/i386/Kconfig
===================================================================
--- linux-2.6.19-ck2.orig/arch/i386/Kconfig	2006-11-30 11:30:32.000000000 +1100
+++ linux-2.6.19-ck2/arch/i386/Kconfig	2006-12-09 09:01:36.000000000 +1100
@@ -500,7 +500,7 @@ endchoice
 
 choice
 	depends on EXPERIMENTAL
-	prompt "Memory split" if EMBEDDED
+	prompt "Memory split"
 	default VMSPLIT_3G
 	help
 	  Select the desired split between kernel and user memory.
@@ -519,14 +519,14 @@ choice
 	  option alone!
 
 	config VMSPLIT_3G
-		bool "3G/1G user/kernel split"
+		bool "Default 896MB lowmem (3G/1G user/kernel split)"
 	config VMSPLIT_3G_OPT
 		depends on !HIGHMEM
-		bool "3G/1G user/kernel split (for full 1G low memory)"
+		bool "1GB lowmem (3G/1G user/kernel split)"
 	config VMSPLIT_2G
-		bool "2G/2G user/kernel split"
+		bool "2GB lowmem (2G/2G user/kernel split)"
 	config VMSPLIT_1G
-		bool "1G/3G user/kernel split"
+		bool "3GB lowmem (1G/3G user/kernel split)"
 endchoice
 
 config PAGE_OFFSET


