Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbUARRID (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 12:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUARRID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 12:08:03 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:9344
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S262901AbUARRIB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 12:08:01 -0500
Subject: Re: [RFC] kill sleep_on
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrew Morton <akpm@osdl.org>, dwmw2@infradead.org,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <400A4147.4090405@colorfullife.com>
References: <40098251.2040009@colorfullife.com>
	 <1074367701.9965.2.camel@imladris.demon.co.uk>
	 <20040117201000.GL21151@parcelfarce.linux.theplanet.co.uk>
	 <1074383111.9965.4.camel@imladris.demon.co.uk>
	 <20040117224139.5585fb9c.akpm@osdl.org>
	 <1074409074.1569.12.camel@nidelv.trondhjem.org>
	 <20040117233618.094c9d22.akpm@osdl.org> <400A396B.4090207@colorfullife.com>
	 <1074412980.1574.40.camel@nidelv.trondhjem.org>
	 <400A4147.4090405@colorfullife.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1074445656.1602.7.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 18 Jan 2004 12:07:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På su , 18/01/2004 klokka 03:18, skreiv Manfred Spraul:

> I think the purpose of i_sem or lock_kernel is to protect the file 
> pointer. Most local filesystems use i_sem, it's noticably faster - 
> global vs. per-object locking.

Err... Not in the case where someone else has the file open for writing.
In that case, the i_sem can be held for quite long periods of time 'cos
NFS has to flush out conflicting writes, and it has to serialize w/r
reads on pages.

> Btw, generic_mapping_read should also lock it's accesses to f_pos: right 
> now it reads and writes f_pos without any locking...

Is there really any sane application that relies on 2 threads sharing
the same file descriptor, and doing llseek()/read()/write() without some
form of userland serialization mechanism?
It sounds to me as if that is going to be pretty much broken whether or
not we protect the integrity of f_pos in the kernel.

Cheers,
  Trond
