Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263890AbUDNFUZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 01:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263888AbUDNFUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 01:20:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:47761 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263883AbUDNFUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 01:20:23 -0400
Date: Tue, 13 Apr 2004 22:19:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Olof Johansson <olof@austin.ibm.com>
Cc: nathanl@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Increase number of dynamic inodes in procfs (2.6.5)
Message-Id: <20040413221956.448f7d67.akpm@osdl.org>
In-Reply-To: <Pine.A41.4.44.0404132332170.80688-100000@forte.austin.ibm.com>
References: <20040413170642.22894ebc.akpm@osdl.org>
	<Pine.A41.4.44.0404132332170.80688-100000@forte.austin.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olof Johansson <olof@austin.ibm.com> wrote:
>
> On Tue, 13 Apr 2004, Andrew Morton wrote:
> 
>  > > and changes the inode number
>  > >  allocator to use a growable linked list of bitmaps.
>  >
>  > This open-codes a simple version of lib/idr.c.  Please use lib/idr.c
>  > instead.  There's an example in fs/super.c
> 
>  The drawback of using lib/idr.c is the increased memory consumption for
>  keeping track of the pointers that are not used. For 100k entries that's
>  800KB lost (64-bit arch).

Which is less that 2% of the space which is used by the 100k inodes.

We've previously discussed allocating the idr pointer array separately, but
the extra cache miss for the users who need it, plus the 2% argument keep
on trumping that.  (We could avoid the cache miss with zero-length-array
tricks, actually).

>  I've abstracted out Martin Bligh's and Ingo Molnar's scalable bitmap
>  allocator that is used by the PID allocator.

Your current requirement does not appear to justify this additional
infrastructure.
