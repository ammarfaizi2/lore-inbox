Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318020AbSG3KN4>; Tue, 30 Jul 2002 06:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318101AbSG3KN4>; Tue, 30 Jul 2002 06:13:56 -0400
Received: from dsl-213-023-043-226.arcor-ip.net ([213.23.43.226]:3996 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318020AbSG3KN4>;
	Tue, 30 Jul 2002 06:13:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch 1/13] misc fixes
Date: Tue, 30 Jul 2002 12:18:33 +0200
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
References: <3D439E09.3348E8D6@zip.com.au> <E17Z4v0-0002io-00@starship> <3D459ECE.C5BD53DE@zip.com.au>
In-Reply-To: <3D459ECE.C5BD53DE@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ZU5J-0001li-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 July 2002 22:00, Andrew Morton wrote:
> > For this to work, anon pages will need to have something in page->index.
> > This isn't too much of a challenge.  A reasonable value to put in there is
> > the creator's virtual address, shifted right, and perhaps mangled a little to
> > reduce contention.
> 
> Well you want the likely-to-be-temporally-adjacent anon pages to
> use the same lock.  So maybe
> 
> 	page->index = some_global_int++;

Actually, thinking again... the nice thing about this scheme is the
opportunity to take the lock once for a whole batch of add_rmaps while
walking through a page table, and the same for remove_rmap.  So it
definitely wants to be based on the virtual address.

-- 
Daniel
