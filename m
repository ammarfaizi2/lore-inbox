Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262305AbUKDRPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbUKDRPu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 12:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbUKDRNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 12:13:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:47278 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262307AbUKDRJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 12:09:46 -0500
Date: Thu, 4 Nov 2004 09:09:25 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: foo@porto.bmb.uga.edu
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Bad UDP checksums with 2.6.9
Message-Id: <20041104090925.188fc471@dxpl.pdx.osdl.net>
In-Reply-To: <20041104062834.GE12763@porto.bmb.uga.edu>
References: <20041104054838.GC12763@porto.bmb.uga.edu>
	<20041104062834.GE12763@porto.bmb.uga.edu>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; x86_64-suse-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Nov 2004 01:28:34 -0500
foo@porto.bmb.uga.edu wrote:

> On Thu, Nov 04, 2004 at 12:48:38AM -0500, foo wrote:
> > 'm seeing the same problem as in:
> > Message-Id: 20041020191203.GA14356@merlin.emma.line.org
> > or http://www.ussg.iu.edu/hypermail/linux/kernel/0410.2/1310.html
> > 
> > I just upgraded a machine from 2.6.5 to 2.6.9, and when the amanda
> > backup server contacts it, it sometimes replies with a UDP packet with a
> > bad checksum.  I'm using e1000 here, so it seems to not be related to
> > the ethernet driver.  I have a binary tcpdump if anyone's interested.
> 
> I don't know why I didn't think of this at first, but I have another
> identical machine that I upgraded at the same time that doesn't have the
> problem.
> 
> Here's a diff between their .configs - albarino is the one having
> trouble.  Maybe CONFIG_PACKET_MMAP?  If someone can point me at a likely
> config option to change I'll boot a new kernel for the next backup run
> Friday night.

Do both machines have the same exact version of E1000?  Some support
TCP Segmentation Offload (TSO) and some do not.

You might try turning off  tso (and tx checksuming) and see if that
is related.
	ethtool -K eth0 tso off

