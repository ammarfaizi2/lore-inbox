Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbTEIM2M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 08:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbTEIM2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 08:28:12 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:39552 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262499AbTEIM2L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 08:28:11 -0400
Date: Fri, 9 May 2003 13:40:42 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@digeo.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 uaccess to fixmap pages
Message-ID: <20030509124042.GB25569@mail.jlokier.co.uk>
References: <20030508213119.58dd490d.akpm@digeo.com> <200305090855.h498t4b12921@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305090855.h498t4b12921@magilla.sf.frob.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath wrote:
> The address is valid, but above TASK_SIZE.  The purpose of access_ok
> is to say that it's ok to try it and let it fault, because it's a
> user-visible address and not the kernel memory mapped into the high
> part of every process's address space.  The accesses that follow are
> done in kernel mode, so there is no fault for pages marked as not
> user-visible.  The fixmap addresses are > TASK_SIZE and so fail the
> __range_ok test, heretofore making access_ok return false.  Those
> are the code paths leading to EFAULT that I mentioned.
> 
> So far I can't think of a better way to do it.

Why don't you change TASK_SIZE to 0xc0001000 (or so) and place the
user-visible fixmaps at 0xc0000000?

That would have no cost at all.

-- Jamie
