Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263014AbTCWKiK>; Sun, 23 Mar 2003 05:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263015AbTCWKiK>; Sun, 23 Mar 2003 05:38:10 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16873 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263014AbTCWKiI>;
	Sun, 23 Mar 2003 05:38:08 -0500
Date: Sun, 23 Mar 2003 11:49:16 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE todo list
Message-ID: <20030323104916.GI837@suse.de>
References: <1048352492.9219.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048352492.9219.4.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22 2003, Alan Cox wrote:
> -	Finish verifying 256 sector I/O or larger on LBA48
> 	[How to handle change dynamically on hotplug ?]

That is basically impossible. How are you going to handle the case where
you have a queue full of 256 request writes, and the plugged in disk
chokes on them? And insolvable unless you start setting aside requests
simply for this purpose. Also breaks the pseudo atomic segments that a
single request represents. This is just way beyond ugly...

This is a generic problem of course, and the typical answer is to go by
the rules of the lowest common denominator if hot plug can cause you
queue limits to be violated (may be other problems than simply max
sector count).

-- 
Jens Axboe

