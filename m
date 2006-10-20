Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWJTRZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWJTRZn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 13:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWJTRZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 13:25:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14754 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932237AbWJTRZn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 13:25:43 -0400
Date: Fri, 20 Oct 2006 10:25:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: linux-kernel@vger.kernel.org, Dave Airlie <airlied@linux.ie>,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.19-rc2-mm2
Message-Id: <20061020102520.67b8c2ab.akpm@osdl.org>
In-Reply-To: <200610201854.43893.m.kozlowski@tuxland.pl>
References: <20061020015641.b4ed72e5.akpm@osdl.org>
	<200610201339.49190.m.kozlowski@tuxland.pl>
	<20061020091901.71a473e9.akpm@osdl.org>
	<200610201854.43893.m.kozlowski@tuxland.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 18:54:43 +0200
Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:

> Hello, 
> 
> > Don't know.   Nothing has changed in the git-pcmcia tree since July.
> >
> > Are you able to bisect it, as per
> > http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt ?
> >
> > > When running without debug options enabled also these were seen amongst
> > > dmesg lines:
> > >
> > > [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
> > > [drm:drm_unlock] *ERROR* Process 5131 using kernel context 0
> >
> > <googles>
> >
> > This? http://lkml.org/lkml/2005/9/10/78
> 
> I think I found the culprit. It's CONFIG_PCI_MULTITHREAD_PROBE option. It is 
> actually marked as EXPERIMENTAL and there is even a proper warning included 
> on the help page. Disabling it makes the kernel behave the right way. So 
> should what I reported be considered a real error or not? Then the next 
> question is should I report errors caused by options marked as EXPERIMENTAL 
> or just leave it the way it is until the option is not EXPERIMENTAL anymore?

Ow.  Multithreaded probing was probably a bt ambitious, given the current
status of kernel startup..

Greg, does it actually speed anything up or anything else good?

As for what to do about it: tell David ;) I'm not sure that he'll be
super-motivated about it though.

