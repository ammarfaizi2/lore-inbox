Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262487AbVCBWph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbVCBWph (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 17:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVCBWlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:41:46 -0500
Received: from fire.osdl.org ([65.172.181.4]:52676 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262503AbVCBWjr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 17:39:47 -0500
Date: Wed, 2 Mar 2005 14:39:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: dhowells@redhat.com, davidm@snapgear.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] BDI: Provide backing device capability information
Message-Id: <20050302143934.30d191d7.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503021423420.25732@ppc970.osdl.org>
References: <20050302090734.5a9895a3.akpm@osdl.org>
	<9420.1109778627@redhat.com>
	<31789.1109799287@redhat.com>
	<20050302135146.2248c7e5.akpm@osdl.org>
	<Pine.LNX.4.58.0503021423420.25732@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> On Wed, 2 Mar 2005, Andrew Morton wrote:
> >
> > Why not make these bitfields as well?
> 
> Side note: bitfields aren't exactly wonderful.

Yup.  In this application the fields are initialised once (usually at
compile time) and are never modified.  So the compiler should be able to
generate the same code as it would with an open-coded bit test.  Which is
about the only situation where we should use bitfields, IMO.

That being said, there aren't many backing_dev_info's in a system, so we
won't be saving much memory.  Some architectures will presumably generate
faster code with plain old integers.  You'd only ever lose if the
backing_dev_info happened to straddle a cacheline boundary.  It's marginal.

