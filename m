Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264276AbUESQHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264276AbUESQHz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 12:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264277AbUESQHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 12:07:55 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:43770 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S264276AbUESQHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 12:07:52 -0400
Date: Wed, 19 May 2004 12:03:01 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: overlaping printk
In-Reply-To: <Pine.GSO.4.58.0405191848430.10266@stekt37>
Message-ID: <Pine.GSO.4.33.0405191153500.14297-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2004, Tuukka Toivonen wrote:
>Do you get CRC errors during transfer (would definitely point to serial
>driver then).
...

The serial driver is not at fault.  It's processing exactly as it is asked
to.  The kernel's console logic is causing the problem. (in fact, there
are specific checks to make sure there aren't two CPUs attempting to
write to the serial registers at the same time.)

It looks like somewhere in the path of release_console_sem() more than
one CPU is running the log.  The "printk_cpu" patch might fix this.  I'll
konw in a day (the box crashs every night... the jack***'s turn the AC
off after 6pm everyday.)

--Ricky


