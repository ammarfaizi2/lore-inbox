Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTFBNjE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 09:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbTFBNjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 09:39:04 -0400
Received: from vena.lwn.net ([206.168.112.25]:39296 "HELO eklektix.com")
	by vger.kernel.org with SMTP id S262323AbTFBNjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 09:39:03 -0400
Message-ID: <20030602135228.10819.qmail@eklektix.com>
To: Gong Su <gongsu@cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.x block device driver question 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Sun, 01 Jun 2003 18:54:56 EDT."
             <5sukdv4jvcd417f7chvla92je3su1le1r8@4ax.com> 
Date: Mon, 02 Jun 2003 07:52:28 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was trying to see how __make_request throttles a fast writing process
> from overrunning a slow device. So I took Alessandro Rubini's spull.c
> code from his device driver book (2nd edition)

Alessandro's...and that other guy's...:)

> dd if=/dev/zero of=/dev/pda bs=1024 count=1000000
> 
> What I expect is that the kernel will quickly stop dd after all 128 (64
> on machines with less than 32MB of ram) free request slots are taken.

As you noted, that didn't happen.  My guess is you ran out of memory.  The
requests you are generating will be, shall we say, easily merged in the
block subsystem.  So you have a bunch of requests in the device's queue,
but each one will have a long chain of buffer heads hanging off it.  You
may not have even managed to use up all the available request structures
before things came to a halt.  Try dropping the max_sectors[] count way
down, and things might work a little better.  After your fsck completes,
that is. 

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
