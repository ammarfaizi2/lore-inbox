Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbTJQICG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 04:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263334AbTJQICG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 04:02:06 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1664 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263330AbTJQICD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 04:02:03 -0400
Date: Fri, 17 Oct 2003 09:03:36 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310170803.h9H83ahx000164@81-2-122-30.bradfords.org.uk>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
In-Reply-To: <20031016231235.GB29279@pegasys.ws>
References: <1066163449.4286.4.camel@Borogove>
 <20031015133305.GF24799@bitwizard.nl>
 <3F8D6417.8050409@pobox.com>
 <20031016162926.GF1663@velociraptor.random>
 <3F8ECA3E.4030208@draigBrady.com>
 <20031016231235.GB29279@pegasys.ws>
Subject: Re: Transparent compression in the FS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What might be worth considering is internal NUL detection.
> Build the block-of-zeros detection into the filesystem
> write resulting in automatic creation of sparse files.
> This could even work with extent based filesystems where
> using hashes to identify shared blocks would not.

Another idea could be writing uncompressed data to the disk, and
background-compressing it with something like bzip2, but keeping the
uncompressed data on disk as well, only over-writing it when disk
space is low, and then overwriting the least recently used files
first.

The upshot of all that would be that if you needed space, it would be
there, (just overwrite the uncompressed versions of files), but until
you do, you can access the uncompressed data quickly.

You could even take it one step further, and compress files with gzip
by default, and re-compress them with bzip2 after long periods of
inactivity.

John.
