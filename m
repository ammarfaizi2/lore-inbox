Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272427AbTGZIut (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 04:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272401AbTGZIuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 04:50:35 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:33419 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S272418AbTGZIu1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 04:50:27 -0400
Date: Sat, 26 Jul 2003 11:05:23 +0200
From: Marco Roeland <marco.roeland@xs4all.nl>
To: Ben Greear <greearb@candelatech.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Repost: Bug with select?
Message-ID: <20030726090523.GA25539@localhost>
References: <20030725134155.GA19211@localhost> <3F21C93D.6000005@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3F21C93D.6000005@candelatech.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday July 25th 2003 at 17:20 uur Ben Greear wrote:

> I thought select is supposed to tell you when you can read/write at least
> something without failing. Otherwise it would be worthless when doing
> non-blocking IO because you can both read and write w/out blocking at all
> times. If you run similar code on a tcp socket instead of std-out, do you see
> the same busy spin? (To do it right, make sure the network between source and
> destination is slower than the CPU can handle, ie 10bt hub.)

My 'analysis' was indeed based on experience with sockets, where you
don't get the busy spin. It's indeed a bit baffling why select keeps
insisting that fd 1 is writable. A quick test on kernel versions
2.2.12-20, 2.4.20 and 2.6.0-test1 all give the same results, so I
suppose select itself is doing it's expected duty, and that in that case
the special underlying mechanics of stdout require special mechanics to
find out if it's blocked?! Beats me, but that's pretty easy... ;-)
 
Marco Roeland
