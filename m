Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbUBRDwG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 22:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbUBRDwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 22:52:05 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:46241 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262652AbUBRDwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 22:52:00 -0500
Date: Wed, 18 Feb 2004 03:49:25 +0000
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com
Subject: Re: 2.6.3rc4 ali1535 i2c driver rmmod oops.
Message-ID: <20040218034925.GI6242@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com
References: <20040218031544.GB26304@redhat.com> <Pine.LNX.4.58.0402171941580.2686@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402171941580.2686@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 07:47:01PM -0800, Linus Torvalds wrote:
 > 
 > 
 > On Wed, 18 Feb 2004, Dave Jones wrote:
 > >
 > > Erk, whats going on here ?
 > 
 > Normally this would mean that somebody is trying to "kfree" a pointer that 
 > wasn't allocated with "kmalloc()". That seems unlikely in this case, so it 
 > might be a double free or some other internal corruption..
 > 
 > That "sys_delete_module()" thing seems like some stale kernel stack 
 > contents, so it's possible that that is the thing that messed up and left 
 > something in an inconsistent state.
 > 
 > Do you know what module it was?

I felt masochistic, so decided to 'see what would happen' when I ran this..

for i in `find /lib/modules/2.6.2-prep/ -name *.ko`
do
	MOD=`basename $i | sed s/.ko//`
	echo module: $i
	echo inserting
	/sbin/modprobe $MOD
	sync
	echo removing
	/sbin/rmmod $MOD
	echo
	sync
	#sleep 1
done

.. And then sat back and watched the carnage.

After the ali1535 i2c module blew up and took the box with it,
I rebooted, and did a modprobe / rmmod of that module alone.
Exactly the same result. Reproducable every time.

		Dave

