Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbUCSJEr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 04:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUCSJEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 04:04:46 -0500
Received: from mail.shareable.org ([81.29.64.88]:32142 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262049AbUCSJEj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 04:04:39 -0500
Date: Fri, 19 Mar 2004 09:04:31 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unionfs
Message-ID: <20040319090431.GB2650@mail.shareable.org>
References: <20040315235243.GA21416@wohnheim.fh-wedel.de> <200403161618.i2GGITKK004831@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403161618.i2GGITKK004831@eeyore.valparaiso.cl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> Besides, the people asking for this mostly really
> want version control, or get what they want from symlink farms.

No.  Version control does not address the requirement: to have 30
checked out kernel trees, each with compiled images, because you're
actually working on 30 trees, sharing files to save time and space,
and normal shell commands in each directory not accidentally affecting
the others.

I have not heard of any version control system which offers that.
Perhaps one based around a virtual filesystem could.

Symlink farms do not solve it either.  They have the same problem as
hard links: namely, it is too easy to accidentally modify a file in
one tree while intending to modify only in another, plus they
introduce a whole bunch of other problems.

This idea of COW links is to solve one quite specific problem:
creating the illusion that large trees are copied and independent, so
that editors and compilers and makefiles and so on affect them
independently, while doing so fast and small, and allowing programs
which compare files (such as version control and diff) to know when
two files' contents are identical efficiently.

-- Jamie
