Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWFYSoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWFYSoZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 14:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWFYSoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 14:44:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15003 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751376AbWFYSoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 14:44:24 -0400
Date: Sun, 25 Jun 2006 11:40:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: rjw@sisk.pl, davej@redhat.com, linux-kernel@vger.kernel.org,
       sekharan@us.ibm.com, rusty@rustcorp.com.au, rdunlap@xenotime.net
Subject: Re: 2.6.17-mm2
Message-Id: <20060625114051.e9d5cbde.akpm@osdl.org>
In-Reply-To: <20060625182352.GB17945@mars.ravnborg.org>
References: <20060624061914.202fbfb5.akpm@osdl.org>
	<20060624172014.GB26273@redhat.com>
	<20060624143440.0931b4f1.akpm@osdl.org>
	<200606251051.55355.rjw@sisk.pl>
	<20060625032243.fcce9e2e.akpm@osdl.org>
	<20060625081610.9b0a775a.akpm@osdl.org>
	<20060625182352.GB17945@mars.ravnborg.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2006 20:23:52 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> On Sun, Jun 25, 2006 at 08:16:10AM -0700, Andrew Morton wrote:
> > On Sun, 25 Jun 2006 03:22:43 -0700
> > 
> > Actually we should be able to address this pretty simply by disallowing
> > exports of symbols which are in the __init section.  There's no sense in
> > exporting something which ain't there.
> > 
> > IOW, any reference from __ksymtab, __ksymtab_gpl or __ksymtab_gpl_future
> > into __init or __initdata should be a hard error.
> We could let modpost error out. Then the module does not get build but
> we detect it a bit later than optimal.
> 

Well, it doesn't have anything to do with modules per-se.  When vmlinux is
post-processed we want to error out if vmlinux is exporting any
__init/__initdata symbols to modules.

