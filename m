Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261608AbTCaLti>; Mon, 31 Mar 2003 06:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261609AbTCaLti>; Mon, 31 Mar 2003 06:49:38 -0500
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:6802 "EHLO
	dexter.hensema.net") by vger.kernel.org with ESMTP
	id <S261608AbTCaLth>; Mon, 31 Mar 2003 06:49:37 -0500
From: Erik Hensema <erik@hensema.net>
Subject: Re: Delaying writes to disk when there's no need
Date: Mon, 31 Mar 2003 12:00:57 +0000 (UTC)
Message-ID: <slrnb8gbfp.1d6.erik@bender.home.hensema.net>
References: <slrnb843gi.2tt.usenet@bender.home.hensema.net> <20030328231248.GH5147@zaurus.ucw.cz>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek (pavel@suse.cz) wrote:
> Hi!
> 
>> In all kernels I've tested writes to disk are delayed a long time even when
>> there's no need to do so.
>> 
>> A very simple test shows this: on an otherwise idle system, create a tar of
>> a NFS-mounted filesystem to a local disk. The kernel starts writing out the
>> data after 30 seconds, while a slow and steady stream would be much nicer
>> to the system, I think.
>> 
> 
> Well, doing writeback sooner when disks
> are idle might be good idea; detecting
> if disk is idle might not be too easy, through.

Helge Hafting already pointed out that writing out the data earlier isn't
desirable. The problem isn't in the waiting: the problem is in the writing.
I think the current kernel tries to write too much data too fast when
there's absolutely no reason to do so. It should probably gently write out
small amounts of data until there is a more pressing need for memory.

-- 
Erik Hensema <erik@hensema.net>
