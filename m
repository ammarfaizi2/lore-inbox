Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269024AbUJKOxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269024AbUJKOxE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269013AbUJKOw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:52:26 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:32193 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269014AbUJKOuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:50:35 -0400
Subject: Re: [patch 2/3] lsm: add bsdjail module
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       chrisw@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041010104113.GC28456@infradead.org>
References: <1097094103.6939.5.camel@serge.austin.ibm.com>
	 <1097094270.6939.9.camel@serge.austin.ibm.com>
	 <20041006162620.4c378320.akpm@osdl.org>
	 <20041007190157.GA3892@IBM-BWN8ZTBWA01.austin.ibm.com>
	 <20041010104113.GC28456@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097502444.31259.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 11 Oct 2004 14:47:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-10-10 at 11:41, Christoph Hellwig wrote:
> Your filesystem handling code is completely superflous (and buggy).  Please
> remove all the code dealing with chroot-lookalikes.  In your userland script
> you simpl have to clone(.., CLONE_NEWNS) to detach your namespace from your
> parent, then you can lazly unmount all filesystems and setup your new namespace
> before starting the jail.  The added advantage is that you don't need any
> cludges to keep the user from exiting the chroot.

AF_UNIX socket and fchdir().

That however requires a co-operator outside the chroot so doesn't seem
to be a problem. I like the CLONE approach, its a lot cleaner.

