Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264440AbSIQSKO>; Tue, 17 Sep 2002 14:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264441AbSIQSKN>; Tue, 17 Sep 2002 14:10:13 -0400
Received: from vena.lwn.net ([206.168.112.25]:16389 "HELO eklektix.com")
	by vger.kernel.org with SMTP id <S264440AbSIQSKN>;
	Tue, 17 Sep 2002 14:10:13 -0400
Message-ID: <20020917181513.9217.qmail@eklektix.com>
To: gen-lists@blueyonder.co.uk
Subject: Re: Problems accessing USB Mass Storage
cc: linux-kernel@vger.kernel.org
From: Jonathan Corbet <corbet@lwn.net>
Date: Tue, 17 Sep 2002 12:15:13 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't know if this is helpful or not, but, based on my messing around with
SmartMedia USB stuff...

SmartMedia cards are weird in that they have a (seemingly) random amount of
waste space at the beginning of the card.  Your 8MB card, in particular,
has nothing of interest in the first 25 sectors.  Some cards have a
reasonable partition table in the first sector, and some don't.  Modern
Windows systems (and cameras, of course) seem to be able to access the
filesystem on the card without needing to see a partition table.

A little while I posted a Lexar SmartMedia driver patch which hacked around
this by substituting a fake partition table when the first sector was read.
I'm not sure it's the right solution, though.  A better way, perhaps, is a
little user-space program which writes the appropriate partition table
depending on the card capacity.  Note that fdisk doesn't (easily) work for
this purpose, since it wants partitions to start on cylinder boundaries.

You might try just using dd to copy your card to disk with an offset of 25
sectors, and see of you can mount the resulting image.

Then again, the interface to some SmartMedia readers is vastly more
complicated, as the sddr09 driver shows.

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
