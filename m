Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWIRVyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWIRVyM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 17:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWIRVyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 17:54:11 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:52207 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751117AbWIRVyK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 17:54:10 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: [RFC] Alignment of fields in struct dentry
Date: Mon, 18 Sep 2006 23:54:04 +0200
User-Agent: KMail/1.9.1
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060914093123.GA10431@wohnheim.fh-wedel.de> <200609152244.07889.arnd@arndb.de> <20060918212423.GB6899@wohnheim.fh-wedel.de>
In-Reply-To: <20060918212423.GB6899@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609182354.04781.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 September 2006 23:24, Jörn Engel wrote:
> On Fri, 15 September 2006 22:44:07 +0200, Arnd Bergmann wrote:
> >
> > I'd guess that a 32 byte alignment is much better here, 64 byte sounds
> > excessive. It should have the same effect with the current dentry layout
> > and default config options, but would keep the d_iname length in the
> > 16-44 byte range instead of 16-76 byte as your patch does.
> > 
> > Since all important fields are supposed to be kept in 32 bytes anyway,
> > they are still either at the start or the end of a given cache line,
> > but never cross two.
> 
> Another take would be to use a cacheline.  But I guess the difference
> between 32/64/cacheline is mostly academic, given the rate of changes
> to struct dentry.

There have been so many optimizations and misoptimizations regarding
the dentry struct over the years. See http://lkml.org/lkml/2004/5/8/117
for the almost exact opposite of this patch, along with the same discussion
that we're having now.

	Arnd <><
