Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267530AbTBLTfa>; Wed, 12 Feb 2003 14:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267554AbTBLTfa>; Wed, 12 Feb 2003 14:35:30 -0500
Received: from 12-252-67-253.client.attbi.com ([12.252.67.253]:56755 "EHLO
	morningstar.nowhere.lie") by vger.kernel.org with ESMTP
	id <S267530AbTBLTf3>; Wed, 12 Feb 2003 14:35:29 -0500
From: "John W. M. Stevens" <john@betelgeuse.us>
Date: Wed, 12 Feb 2003 12:45:01 -0700
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: Olaf Titz <olaf@bigred.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: Setjmp/Longjmp in the kernel?
Message-ID: <20030212194501.GA28626@morningstar.nowhere.lie>
References: <20030209221044.GA8761@morningstar.nowhere.lie> <1044882041.418.1.camel@irongate.swansea.linux.org.uk> <E18iMLx-00020k-00@bigred.inka.de> <3E4A2824.5D915F9F@daimi.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E4A2824.5D915F9F@daimi.au.dk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 11:55:32AM +0100, Kasper Dupont wrote:
> Olaf Titz wrote:
> > 
> > Not that this matters any bit, but the proper order is of course
> >         alloc this
> >         alloc that
> >         _foo_func()
> >         free that
> >         free this
> > 
> > even if only for aesthetical reasons :-)
> > 
> > (with locks, it does matter...)
> 
> For locks it is only when you lock the order matters, not when
> you unlock. For allocations there is of course the possibility
> that the first allocation suceeds and the second fails, which
> you must handle in some way.

The usual way is with "pools".

Every resource allocated after a "mark" point gets dumped into
a separate pool, and then when processing returns to the mark
point, the pools are drained, one way or the other.

For locks, the pools are ordered, and you swim backwards through
the pool.

John S.
