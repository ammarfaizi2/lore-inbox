Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWFZUtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWFZUtz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWFZUtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:49:55 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:46022 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750787AbWFZUty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:49:54 -0400
Date: Mon, 26 Jun 2006 22:49:09 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Dave Jones <davej@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-390@vm.marist.edu
Subject: Re: [PATCH] s390: fix duplicate export of overflow{ug}id
Message-ID: <20060626204909.GF10431@osiris.ibm.com>
References: <20060626193141.GB32035@sergelap.austin.ibm.com> <20060626193704.GF18599@redhat.com> <20060626194812.GD32035@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626194812.GD32035@sergelap.austin.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 02:48:12PM -0500, Serge E. Hallyn wrote:
> Quoting Dave Jones (davej@redhat.com):
> > On Mon, Jun 26, 2006 at 02:31:41PM -0500, Serge E. Hallyn wrote:
> >  > overflowuid and overflowgid were exported twice.  Remove the export
> >  > from s390_ksyms.c
> > 
> > There's a gotcha with this.  in kernel/sys.c, we only export those
> > symbols if CONFIG_UID16 is set.  iirc, there was some part of
> > arch/s390 that expected to use those symbols even if it wasn't set.
> > 
> > Does everything still link with that option both set and unset ?
> 
> It does on my partition; near as I can tell the only use of overflowuid
> is in compat_linux.c, which is always compiled in.

arch/s390/kernel/binfmt_elf32.c which can be build as a module uses this too.
But only with the two NEW_TO_OLD_UID and NEW_TO_OLD_GID defines which seem
to be unused and could be removed as well.
