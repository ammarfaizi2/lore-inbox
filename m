Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317416AbSGJOhV>; Wed, 10 Jul 2002 10:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317439AbSGJOhU>; Wed, 10 Jul 2002 10:37:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39943 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317416AbSGJOhT>;
	Wed, 10 Jul 2002 10:37:19 -0400
Date: Wed, 10 Jul 2002 15:40:03 +0100
From: Matthew Wilcox <willy@debian.org>
To: Marco Colombo <marco@esi.it>
Cc: Larry McVoy <lm@bitmover.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
Message-ID: <20020710154003.Z27706@parcelfarce.linux.theplanet.co.uk>
References: <20020708222127.G11300@work.bitmover.com> <Pine.LNX.4.44.0207101144010.728-100000@Megathlon.ESI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207101144010.728-100000@Megathlon.ESI>; from marco@esi.it on Wed, Jul 10, 2002 at 12:03:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2002 at 12:03:08PM +0200, Marco Colombo wrote:
> Larry, there's something I've always wanted to ask you about your
> idea of the "locking cliff": when you're counting the number of locks,
> are you looking at the running image of an OS or at the source? 

Larry normally talks about the number of conceptual locks.  So in order
to manipulate a `struct file', it really doesn't matter whether you have
to grab the BKL, the files_struct lock or the filp->lock.  There's a big
difference if you have to grab the filp->pos_lock, the filp->ra_lock and
the filp->iobuf_lock.  You'd have to know what order to grab them in,
for a start.

-- 
Revolutions do not require corporate support.
