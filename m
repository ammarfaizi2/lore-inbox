Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422687AbWCWVlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422687AbWCWVlW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 16:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422702AbWCWVlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 16:41:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23268 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422687AbWCWVlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 16:41:21 -0500
Date: Thu, 23 Mar 2006 13:37:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: 2.6.16-mm1
Message-Id: <20060323133741.21a72249.akpm@osdl.org>
In-Reply-To: <20060323175822.GA7816@redhat.com>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
	<20060323175822.GA7816@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> On Thu, Mar 23, 2006 at 01:40:46AM -0800, Andrew Morton wrote:
> 
>  > - Be aware that someone-who-doesn't-know-about-allmodconfig has screwed up
>  >   AGP on x86_64: if your link fails with various missing AGP symbols you'll
>  >   need to set the various CONFIG_AGP* symbols to `y' rather than `m'.  Then
>  >   work out which other Kconfig rule keeps on flipping them back to `m' again,
>  >   then fix that too.
> 
> I haven't merged anything into agpgart-git for a week or two, so it's
> more than likely..
> 
>  > +x86_64-mm-via-agp.patch
>  > +x86_64-mm-sis-agp.patch
>  > 
>  >  x86_64 tree updates
> 
> 
> whatever these are.
> 

THose patches come from someone who is pretending to be davej@redhat.com ;)

We suspect the culprit is git-intelfb, which does

 config FB_INTEL
 	tristate "Intel 830M/845G/852GM/855GM/865G support (EXPERIMENTAL)"
-	depends on FB && EXPERIMENTAL && PCI && X86_32
+	depends on FB && EXPERIMENTAL && PCI && X86
 	select AGP
 	select AGP_INTEL
 	select FB_MODE_HELPERS

It's rather nasty that this can break the build.

It also seems plain wrong to me that a "select AGP" can force CONFIG_AGP=y
into CONFIG_AGP=m.  There's no sense in that.

