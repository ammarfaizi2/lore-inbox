Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbVHPSNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbVHPSNg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 14:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbVHPSNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 14:13:36 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:14489 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1030277AbVHPSNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 14:13:36 -0400
Date: Tue, 16 Aug 2005 20:13:36 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Flash erase groups and filesystems
Message-ID: <20050816181336.GA2014@wohnheim.fh-wedel.de>
References: <4300F963.5040905@drzeus.cx> <20050816162735.GB21462@wohnheim.fh-wedel.de> <43021DB8.70909@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43021DB8.70909@drzeus.cx>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 August 2005 19:09:12 +0200, Pierre Ossman wrote:
> 
> I'm not sure we're talking about the same thing. I'm not suggesting new
> features in the VFS layer. I want to know if something breaks if I
> implement this erase feature in the MMC layer. In essence the file
> system has marked the sectors as "forget" by issuing a write to them.
> The question is if it is assumed that they are unchanged if the write
> fails half-way through.

Yes.  Most filesystems expect to find either 1) old data or 2) new
data.  Blocks full of 0xff are non-expected.

These expectations are quite reasonable for hard disk media, which is
what the filesystems were designed for.

> I'd have to say that this is a dangerous assumption to make already
> today since some systems might not be able to tell where it fails if a
> large chunk of data is given to it, perhaps because of a deep pipeline
> before it actually reaches the physical storage.

The assumption is merely that, at no time, there will be random data
on the medium.  Both old and new data is somewhat well-defined.  It
doesn't take a PhD to see a potential problem when moving to flash.

Jörn

-- 
Fancy algorithms are buggier than simple ones, and they're much harder
to implement. Use simple algorithms as well as simple data structures.
-- Rob Pike
