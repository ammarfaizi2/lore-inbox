Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWBRTaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWBRTaW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 14:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWBRTaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 14:30:22 -0500
Received: from stinky.trash.net ([213.144.137.162]:15356 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S932125AbWBRTaV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 14:30:21 -0500
Message-ID: <43F77571.7020100@trash.net>
Date: Sat, 18 Feb 2006 20:28:49 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?T=F6r=F6k_Edwin?= <edwin@gurde.com>
CC: netfilter-devel@lists.netfilter.org, fireflier-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, martinmaurer@gmx.at
Subject: Re: [PATCH 2.6.15.4 1/1][RFC] ipt_owner: inode match supporting both
 incoming and outgoing packets
References: <200602181420.02791.edwin@gurde.com>
In-Reply-To: <200602181420.02791.edwin@gurde.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Török Edwin wrote:
> First of all this is what I'd like to achieve:
> - filter packets by the program who sent the packet
> - filter packets by the program who is going to receive the packet
> - when multiple programs share a socket (i.e. they listen on the same socket), 
> allow the packet only if all programs are allowed to receive the packet

Besides the tasklist_lock issues, there is no 1:1 relationship between
sockets and processes, which is why this can never work. You don't know
which process is going to receive a packet until it calls recvmsg().

There is some work in progress to solve this problem in a different way,
by adding new hooks to the protocols that get the socket as context,
and using SElinux labels instead of process names/inodes/whatever for
matching.
