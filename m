Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262920AbTIAFlg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 01:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbTIAFlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 01:41:36 -0400
Received: from pizda.ninka.net ([216.101.162.242]:47504 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262920AbTIAFkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 01:40:12 -0400
Date: Sun, 31 Aug 2003 22:31:02 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: mfedyk@matchmail.com, lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-Id: <20030831223102.3affcb34.davem@redhat.com>
In-Reply-To: <20030831224937.GA29239@mail.jlokier.co.uk>
References: <20030829053510.GA12663@mail.jlokier.co.uk>
	<20030829154101.GB16319@work.bitmover.com>
	<20030829230521.GD3846@matchmail.com>
	<20030830221032.1edf71d0.davem@redhat.com>
	<20030831224937.GA29239@mail.jlokier.co.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Aug 2003 23:49:37 +0100
Jamie Lokier <jamie@shareable.org> wrote:

> It uses POSIX shared memory and (necessarily) MAP_SHARED, which
> doesn't constrain the mapping alignment.

That's wrong.  If a platform needs to, it should properly
align the mapping when MAP_SHARED is used on a file.

If you look in arch/sparc64/kernel/sys_sparc.c, you'll see
that when we're mmap()'ing a file and MAP_SHARED is specified,
we align things to SHMLBA.

If userspace purposefully violates this alignment attempt,
then it's at it's own peril to keep the mappings coherent,
there is simply nothing the kernel should be doing to help
out that case.
