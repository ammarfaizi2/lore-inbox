Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161003AbWJRMqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161003AbWJRMqj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 08:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161007AbWJRMqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 08:46:39 -0400
Received: from mail.suse.de ([195.135.220.2]:37574 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161003AbWJRMqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 08:46:38 -0400
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Undeprecate the sysctl system call
Date: Wed, 18 Oct 2006 14:41:51 +0200
User-Agent: KMail/1.9.3
Cc: Cal Peake <cp@absolutedigital.net>, Andrew Morton <akpm@osdl.org>,
       Randy Dunlap <rdunlap@xenotime.net>, Jan Beulich <jbeulich@novell.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <453519EE.76E4.0078.0@novell.com> <p737iyxdfiz.fsf@verdi.suse.de> <1161173741.9363.22.camel@localhost.localdomain>
In-Reply-To: <1161173741.9363.22.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610181441.51748.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 October 2006 14:15, Alan Cox wrote:

> > Anyways, imho the right solution is to remove the numerical
> > sysctl infrastructure (including most of sysctl.h), but keep
> > sys_sysctl() with a small mapping table that maps the few
> > numerical sysctls (mostly KERN_VERSION) that are actually used to 
> > path names internally. The rest should be ENOSYS.
> 
> More work for less compatibility, that doesn't sound very clever.

It's less work long term, mostly because all the rejects for sysctl.h will 
go away. And it's more compatible than just removing sysctl(2) completely.

The main reason i think at least emulating KERN_VERSION is a good idea is that
it will save a bit of time with older executables who do this 
on every startup. /proc/sys/* is a little slow to do that often.

Normally sysctls are not that time critical so this is really a 
exception.

-Andi 
