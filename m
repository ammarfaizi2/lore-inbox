Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbUADG2Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 01:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbUADG2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 01:28:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:985 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264411AbUADG2N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 01:28:13 -0500
Date: Sun, 4 Jan 2004 06:28:12 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jeff Woods <kazrak+kernel@cesmail.net>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: Should struct inode be made available to userspace?
Message-ID: <20040104062812.GX4176@parcelfarce.linux.theplanet.co.uk>
References: <200312292040.00409.mmazur@kernel.pl> <20031229195742.GL4176@parcelfarce.linux.theplanet.co.uk> <bt71ip$cer$1@gatekeeper.tmr.com> <20040103185712.GV4176@parcelfarce.linux.theplanet.co.uk> <6.0.1.1.0.20040103214203.038dceb0@no.incoming.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6.0.1.1.0.20040103214203.038dceb0@no.incoming.mail>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 09:45:47PM -0800, Jeff Woods wrote:
> At 1/3/2004 06:57 PM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> >On Sat, Jan 03, 2004 at 01:39:41PM -0500, Bill Davidsen wrote:
> >>Moving the definitions is fine, but some user programs, like backup 
> >>programs, do benefit from direct interpretation of the inode. Clearly 
> >>that's not a normal user program, but this information is not only useful 
> >>inside the kernel.
> >
> >No, they do not.  They care about on-disk structures, not the in-core ones 
> >fs driver happens to build.
> 
> They may if trying to do an online backup of open files, especially if 
> attempting to maintain transactional integrity (i.e. make the backup 
> logically atomic).

*ROTFL*

Excuse me, what sort of atomicity are you talking about?  If that "program"
pokes around in kernel memory and accesses (nevermind how found) in-core
inodes, it's not just not atomic, it's obviously racy in all sorts of
interesting ways.  struct inode can be freed at any point _and_ userland
code can lose timeslice and not regain it in quite a while.

If any backup program tries to pull that off, I would really like to see
the names of its "designers" posted for public ridicule.  If such duhvelopers
actually exist, they more than deserve recognition.
