Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbTKOUOs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 15:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTKOUOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 15:14:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30948 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261953AbTKOUOr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 15:14:47 -0500
Date: Sat, 15 Nov 2003 20:14:46 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: Harald Welte <laforge@netfilter.org>, linux-kernel@vger.kernel.org
Subject: Re: seq_file and exporting dynamically allocated data
Message-ID: <20031115201444.GO24159@parcelfarce.linux.theplanet.co.uk>
References: <20031115173310.GA4786@obroa-skai.de.gnumonks.org> <Pine.LNX.4.44.0311151937190.743-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311151937190.743-100000@einstein.homenet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 15, 2003 at 07:49:43PM +0000, Tigran Aivazian wrote:
> Dear Harald,
> 
> The thing to be aware of is that seq API is limited to 1 page of data per
> read(2) call. Some people loudly proclaim "seq API is unlimited, unlike
> the old /proc formalism which was limited to 1 page" but they are 
> quiet about 1-page limitation for a single read(2) (due to hardcoded
> kmalloc(size) in seq_file.c). Why is this important? Because if your

What?  It will happily return more than 1 page if you get an entry longer
than that.

What hardcoded kmalloc(size)?

> ->start/stop routines take/drop some spinlocks then you have to know your
> position and re-verify it on the next read(2) if your data is more than 1
> page and thus could not be read atomically (i.e. while holding the
> spinlocks).

If you mean that read(2) can decide to return less than full user buffer even
though more data is available - tough, that's something userland *must* be
able to deal with.

Especially on syntetic and potentially large files - the only alternative
would be immediate DoS on OOM.  Regardless of the implementation.
