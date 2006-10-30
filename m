Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161485AbWJ3VIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161485AbWJ3VIq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 16:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161366AbWJ3VIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 16:08:46 -0500
Received: from hera.kernel.org ([140.211.167.34]:2459 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1422661AbWJ3VIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 16:08:45 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: splice blocks indefinitely when len > 64k?
Date: Mon, 30 Oct 2006 13:08:13 -0800
Organization: OSDL
Message-ID: <20061030130813.12b3adc1@freekitty>
References: <1162226390.7280.18.camel@systems03.lan.brontes3d.com>
	<20061030195426.GO14055@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1162242494 22741 10.8.0.54 (30 Oct 2006 21:08:14 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Mon, 30 Oct 2006 21:08:14 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2006 20:54:27 +0100
Jens Axboe <jens.axboe@oracle.com> wrote:

> On Mon, Oct 30 2006, Daniel Drake wrote:
> > Hi,
> > 
> > I'm experimenting with splice and have run into some unusual behaviour.
> > 
> > I am using the utilities in git://brick.kernel.dk/data/git/splice.git
> > 
> > In splice.h, when changing SPLICE_SIZE from:
> > 
> > #define SPLICE_SIZE (64*1024)
> > 
> > to
> > 
> > #define SPLICE_SIZE ((64*1024)+1)
> > 
> > splice-cp hangs indefinitely when copying files sized 65537 bytes or
> > more. It hangs on the first splice() call.
> > 
> > Is this a bug? I'd like to be able to copy much more than 64kb on a
> > single splice call.
> 
> You can't, internally splice is using a pipe which is currently confined
> to 16 pages. The SPLICE_SIZE define isn't a suggestion in the code, it
> reflects that. You could fix splice-cp to not stall on changing that,
> however that still doesn't change the fact that you can only move chunks
> of 64kb (on your arch) right now.
> 

It could accept larger values but only move SPLICE_SIZE, assuming
caller checked for partial completions.

-- 
Stephen Hemminger <shemminger@osdl.org>
