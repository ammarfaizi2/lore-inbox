Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264441AbSIQSU1>; Tue, 17 Sep 2002 14:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264445AbSIQSU1>; Tue, 17 Sep 2002 14:20:27 -0400
Received: from air-2.osdl.org ([65.172.181.6]:65294 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264441AbSIQSU0>;
	Tue, 17 Sep 2002 14:20:26 -0400
Date: Tue, 17 Sep 2002 11:22:10 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Jonathan Corbet <corbet@lwn.net>
cc: <gen-lists@blueyonder.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Problems accessing USB Mass Storage
In-Reply-To: <20020917181513.9217.qmail@eklektix.com>
Message-ID: <Pine.LNX.4.33L2.0209171119430.14033-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2002, Jonathan Corbet wrote:

| Don't know if this is helpful or not, but, based on my messing around with
| SmartMedia USB stuff...
|
| SmartMedia cards are weird in that they have a (seemingly) random amount of
| waste space at the beginning of the card.  Your 8MB card, in particular,
| has nothing of interest in the first 25 sectors.  Some cards have a
| reasonable partition table in the first sector, and some don't.  Modern
| Windows systems (and cameras, of course) seem to be able to access the
| filesystem on the card without needing to see a partition table.
|
| A little while I posted a Lexar SmartMedia driver patch which hacked around
| this by substituting a fake partition table when the first sector was read.
| I'm not sure it's the right solution, though.  A better way, perhaps, is a
| little user-space program which writes the appropriate partition table
| depending on the card capacity.  Note that fdisk doesn't (easily) work for
| this purpose, since it wants partitions to start on cylinder boundaries.
|
| You might try just using dd to copy your card to disk with an offset of 25
| sectors, and see of you can mount the resulting image.
|
| Then again, the interface to some SmartMedia readers is vastly more
| complicated, as the sddr09 driver shows.

This is a bit like what we (JE, David Brownell, and I) saw at
the USB plugfest in 1999.  We had a camera device that we
couldn't mount as a filesystem, but we could dd it.
When we did that and studied the dd-ed file, we could see a
FAT filesystem beginning after the first <N> blocks (but more than
25 sectors IIRC -- more like after 50-100 KB, or maybe even more).

-- 
~Randy
"Linux is not a research project. Never was, never will be."
  -- Linus, 2002-09-02

