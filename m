Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbWFBTrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbWFBTrP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbWFBTrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:47:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42127 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932541AbWFBTqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:46:43 -0400
Date: Fri, 2 Jun 2006 12:46:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH] cramfs corruption after BLKFLSBUF on loop device
Message-Id: <20060602124635.2d7a1d96.akpm@osdl.org>
In-Reply-To: <20060602193702.GA9888@suse.de>
References: <20060529214011.GA417@suse.de>
	<20060530182453.GA8701@suse.de>
	<20060601184938.GA31376@suse.de>
	<20060601121200.457c0335.akpm@osdl.org>
	<20060601201050.GA32221@suse.de>
	<20060601142400.1352f903.akpm@osdl.org>
	<20060601214158.GA438@suse.de>
	<20060601145747.274df976.akpm@osdl.org>
	<20060602084327.GA3964@suse.de>
	<20060602021115.e42ad5dd.akpm@osdl.org>
	<20060602193702.GA9888@suse.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2006 21:37:02 +0200
Olaf Hering <olh@suse.de> wrote:

> > I'd suggest you run SetPagePrivate() and SetPageChecked() on the locked
> > page and implement a_ops.releasepage(), which will fail if PageChecked(),
> > and will succeed otherwise:
> 
> No leak without tweaking PG_private.

Odd.  That would imply that PG_private is being left set somehow (it will
make the page unreclaimable).  But I don't see it.

Plus if we have lots of PagePrivate() pages floating about you should see
your ->releasepage() being called.

