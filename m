Return-Path: <linux-kernel-owner+w=401wt.eu-S1426090AbWLHTMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426090AbWLHTMM (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 14:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426139AbWLHTMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 14:12:12 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:33111 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1426090AbWLHTML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 14:12:11 -0500
Date: Fri, 8 Dec 2006 11:12:03 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk,
       "Myaskouvskey, Artiom" <artiom.myaskouvskey@intel.com>,
       shai.satt@intel.com, Andi Kleen <ak@suse.de>, hpa@zytor.com
Subject: Re: [PATCH] efi is_memory_available ia64 hack build fix
Message-Id: <20061208111203.7bf56b97.randy.dunlap@oracle.com>
In-Reply-To: <20061208025312.70a72d4c.akpm@osdl.org>
References: <20061208103336.4644.96389.sendpatchset@jackhammer.engr.sgi.com>
	<20061208025312.70a72d4c.akpm@osdl.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006 02:53:12 -0800 Andrew Morton wrote:

> On Fri, 08 Dec 2006 02:33:36 -0800
> Paul Jackson <pj@sgi.com> wrote:
> 
> > The addition of an is_available_memory() routine to some arch i386
> > code, along with an extern for it in efi.h, caused the ia64 build
> > to fail, which has the apparently identical routine, marked 'static'.
> > 
> > The ia64 build fails with:
> > 
> > arch/ia64/kernel/efi.c:229: error: static declaration of 'is_available_memory' follows non-static declaration
> > include/linux/efi.h:305: error: previous declaration of 'is_available_memory' was here              
> 
> That already got named to is_memory_available()
> 
> (Which I suspect is the wrong fix, because the function serves the same
> purpose on ia64 as it does on x86[_64], but nobody listens to me)

Paul's patch looks better to me than renaming one of them.
And the predicate name on ia64 now seems confusing, at least to me.

And EFI for x86_64 is being worked on, so it will either
use arch/i386/kernel/efi.c or duplicate lots of it.

Summary:  There needs to be a place to share this and possibly other
common functions.

---
~Randy
