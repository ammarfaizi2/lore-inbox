Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262490AbVGMTDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbVGMTDq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 15:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbVGMTAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 15:00:50 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:45968 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S262340AbVGMS74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:59:56 -0400
Date: Wed, 13 Jul 2005 11:59:55 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: linux-kernel@vger.kernel.org
Subject: resuming swsusp twice
Message-ID: <20050713185955.GB12668@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday I booted my laptop to 2.6.13-rc2-mm1, suspended to swsusp, and
then resumed.  It ran fine overnight, including a fair amount of IO
(running firefox, rsyncing ~/Mail/archive from my mail server, hg pull,
etc).  This morning I did a swsusp:

	echo shutdown > /sys/power/disk
	echo disk > /sys/power/state

and got a panic along the lines of "Unable to find swap space, try
swapon -a".  Unfortunately I was in a hurry and didn't record the error
messages.  I powered off, then a few minutes later powered on again.

At this point, it resumed *to the swsusp state from yesterday*!
As soon as I realized what had happened, I powered off (not
shutdown) and rebooted.

On the next boot it did not find a swsusp signature and booted normally;
ext3 did a normal recovery and seemed OK, but I was suspicious and did a
fsck -f, which revealed a lot of damage; most of the damage seemed to be
in the hg repo which had been pulled from www.kernel.org/hg/.

It's extremely unfortunate that there is *any* failure mode in swsusp
that can result in this behavior.

I will try to reproduce, but I'm curious if anyone else has seen this.

-andy
