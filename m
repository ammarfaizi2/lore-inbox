Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbWJRLeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWJRLeK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 07:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbWJRLeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 07:34:10 -0400
Received: from mx1.suse.de ([195.135.220.2]:27577 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030239AbWJRLeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 07:34:08 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Cal Peake <cp@absolutedigital.net>, Andrew Morton <akpm@osdl.org>,
       Randy Dunlap <rdunlap@xenotime.net>, Jan Beulich <jbeulich@novell.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Undeprecate the sysctl system call
References: <453519EE.76E4.0078.0@novell.com>
	<20061017091901.7193312a.rdunlap@xenotime.net>
	<Pine.LNX.4.64.0610171401130.10587@lancer.cnet.absolutedigital.net>
	<1161123096.5014.0.camel@localhost.localdomain>
	<20061017150016.8dbad3c5.akpm@osdl.org>
	<Pine.LNX.4.64.0610171853160.25484@lancer.cnet.absolutedigital.net>
	<m1wt6y70kg.fsf@ebiederm.dsl.xmission.com>
	<1161169330.9363.11.camel@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 18 Oct 2006 13:33:56 +0200
In-Reply-To: <1161169330.9363.11.camel@localhost.localdomain>
Message-ID: <p737iyxdfiz.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> Its very simple: sysctl was a neat BSD syscall that turned out to be
> less ideal than using the fs for it. We added it, we supported it, we
> get to keep it. We just stick notes in the docs saying "please use /proc
> instead".

You call that numerical name space neat?  IMHO it was a totally bogus
idea. There is already a perfectly fine file system name space, why
add another one?

Anyways, imho the right solution is to remove the numerical
sysctl infrastructure (including most of sysctl.h), but keep
sys_sysctl() with a small mapping table that maps the few
numerical sysctls (mostly KERN_VERSION) that are actually used to 
path names internally. The rest should be ENOSYS.

-Andi
