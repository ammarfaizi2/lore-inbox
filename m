Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266154AbUFYBhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266154AbUFYBhi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 21:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266156AbUFYBhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 21:37:37 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:11915 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S266154AbUFYBhG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 21:37:06 -0400
Subject: Re: [RFC] Patch to allow distributed flock
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ken Preslan <kpreslan@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040625000720.GA13755@potassium.msp.redhat.com>
References: <20040624231057.GA13033@potassium.msp.redhat.com>
	 <1088121132.8906.29.camel@lade.trondhjem.org>
	 <20040625000720.GA13755@potassium.msp.redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1088127425.8906.40.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 24 Jun 2004 21:37:05 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På to , 24/06/2004 klokka 20:07, skreiv Ken Preslan:

> If the FS is managing the posix locks and/or flocks, is there really a
> reason to acquire the VFS versions of the locks too?  As long as there is
> some bit set that tells the VFS to call down into the FS to unlock the
> locks on process exit, keeping both sets of locks seems wasteful.
> What am I missing?

The only reason we care in NFS is in order to be able to deal with
server reboot recovery -- which requires you to have an extensive list
of all locks that are held -- and, as you note above, in order to ensure
that locks are all cleared upon process exit.

For flock() locks, I agree: you can probably whittle that information
down to a single bit per open file. For POSIX locks, you need the byte
ranges and lockowner/pid information too...

Cheers,
  Trond
