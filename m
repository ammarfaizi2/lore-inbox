Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbTL2Jbx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 04:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbTL2Jbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 04:31:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:46296 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263125AbTL2Jbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 04:31:52 -0500
Date: Mon, 29 Dec 2003 01:30:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jakma <paul@clubi.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: chmod of active swap file blocks
Message-Id: <20031229013040.0a953dd0.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.56.0312290434360.2270@fogarty.jakma.org>
References: <Pine.LNX.4.56.0312290434360.2270@fogarty.jakma.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jakma <paul@clubi.ie> wrote:
>
> Hi,
> 
> Trying to chmod a file being used for swap causes chmod() to block,
> with permissions change /not/ having taken effect, until the swap
> file is swapoff'd, at which point chmod() carries on and chmod (the
> command) finishes.

The kernel holds the swapfile's i_sem while it is in use.  This is to
prevent the filesystem destruction which would result if some silly person
were to truncate a swapfile while it was in active use.

It is not a particularly important safety feature ("don't do that") and it
can be taken out if it is causing serious side-effects.

Is chmod of an in-use swapfile an important thing to be able to do?
