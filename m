Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUEGCuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUEGCuk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 22:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbUEGCuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 22:50:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:16770 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262406AbUEGCuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 22:50:39 -0400
Date: Thu, 6 May 2004 19:50:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jakma <paul@clubi.ie>
Cc: arjanv@redhat.com, Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
Message-Id: <20040506195002.520b0793.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405070136010.1979@fogarty.jakma.org>
References: <20040505013135.7689e38d.akpm@osdl.org>
	<200405051312.30626.dominik.karall@gmx.net>
	<200405051822.i45IM2uT018573@turing-police.cc.vt.edu>
	<20040505215136.GA8070@wohnheim.fh-wedel.de>
	<200405061518.i46FIAY2016476@turing-police.cc.vt.edu>
	<1083858033.3844.6.camel@laptop.fenrus.com>
	<Pine.LNX.4.58.0405070136010.1979@fogarty.jakma.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jakma <paul@clubi.ie> wrote:
>
> On Thu, 6 May 2004, Arjan van de Ven wrote:
> 
>  > Ok I don't want to start a flamewar but... Do we want to hold linux
>  > back until all binary only module vendors have caught up ??
> 
>  What about normal linux modules though? Eg, NFS (most likely):
> 
>  	https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=121804

That's a misdiagnosis.  The problem here is that the kernel is taking a
pagefault within show_trace(), and the pagefault handler calls
show_trace().  It has gone infinitely recursive.

The bug is unrelated to the stack size.  It is in show_trace() or
thereabouts.  That code tries to protect itself from recursive faults, but
it's a vendor kernel and may be different from the public tree.
