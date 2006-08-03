Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWHCR4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWHCR4k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 13:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWHCR4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 13:56:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19904 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751217AbWHCR4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 13:56:39 -0400
Date: Thu, 3 Aug 2006 13:56:13 -0400
From: Dave Jones <davej@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       jbaron@redhat.com
Subject: Re: frequent slab corruption (since a long time)
Message-ID: <20060803175613.GK22448@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
	jbaron@redhat.com
References: <20060801.220538.89280517.davem@davemloft.net> <20060801.223110.56811869.davem@davemloft.net> <20060802222321.GH3639@redhat.com> <20060802.154954.112624420.davem@davemloft.net> <1154626843.23655.101.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154626843.23655.101.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 06:40:42PM +0100, Alan Cox wrote:
 > Ar Mer, 2006-08-02 am 15:49 -0700, ysgrifennodd David Miller:
 > > > None of the code manipulating tty->count seems to be under
 > > > the tty_mutex.  Should it be ?
 > > > Or is this protected through some other means?
 > > 
 > > It is in the primary code paths at least, all callers of init_dev()
 > > (which increments tty->count) grab the mutex and also release_dev()
 > > grabs the mutex around tty->count manipulations.
 > 
 > I've been auditing tty code and its joyously bad but only in harmless
 > places so far except for one.
 > 
 > init_dev (and caller) relies on tty_mutex to ensure that the
 > driver->ttys list is protected from things going away.
 > 
 > release_mem() removes stuff from the said list and frees memory. It is
 > not always called under tty_mutex and that appears very dubious to me at
 > the moment although tty->closing and the BKL *might* be sufficient.

Against my better judgment I was poring over that code until the wee
hours last night, and one thing crossed my mind re: the assumptions made
about the BKL in that subsystem.  Now that the BKL is preemtible, do
any of those assumptions break ?

		Dave


-- 
http://www.codemonkey.org.uk
