Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262983AbTIFXOI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 19:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbTIFXOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 19:14:08 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:26510 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262983AbTIFXOG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 19:14:06 -0400
Date: Sun, 7 Sep 2003 00:14:01 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Joshua Weage <weage98@yahoo.com>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: NFS client problems in 2.4.18 to 2.4.20
Message-ID: <20030906231401.GB12392@mail.jlokier.co.uk>
References: <16218.5318.401323.630346@charged.uio.no> <20030906212250.64809.qmail@web40414.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030906212250.64809.qmail@web40414.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Weage wrote:
> There aren't any clues in the kernel logs, except that the kernel does
> report "nfs server not responding" and never comes back with "nfs
> server OK".  I've enabled kernel debugging on all of the cluster nodes,
> but the above message is all that I get in the logs.
> 
> I'll have to try out tcpdump the next time this happens.

Look for lots of retransmits from the client.  This might be the bug
where it adjusts the retransmit timeout to a ridiculously small
sub-millisecond value, because of a sequence of fast cached responses
from the server, then when the server responds slowly due to a disk
access the client times out within milliseconds.  Repeatedly.

-- Jamie
