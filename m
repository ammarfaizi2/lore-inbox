Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270061AbRHGENF>; Tue, 7 Aug 2001 00:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270062AbRHGEM4>; Tue, 7 Aug 2001 00:12:56 -0400
Received: from clavin.efn.org ([206.163.176.10]:29668 "EHLO clavin.efn.org")
	by vger.kernel.org with ESMTP id <S270061AbRHGEMo>;
	Tue, 7 Aug 2001 00:12:44 -0400
From: Steve VanDevender <stevev@efn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15215.27296.959612.765065@localhost.efn.org>
Date: Mon, 6 Aug 2001 21:12:16 -0700
To: Justin Guyett <justin@soze.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Encrypted Swap
In-Reply-To: <Pine.LNX.4.33.0108062047310.17919-100000@kobayashi.soze.net>
In-Reply-To: <20010807042810.A23855@foobar.toppoint.de>
	<Pine.LNX.4.33.0108062047310.17919-100000@kobayashi.soze.net>
X-Mailer: VM 6.95 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Guyett writes:
 > On Tue, 7 Aug 2001, David Spreen wrote:
 > 
 > > I was just searching for swap-encryption-solutions in the lkml-archive.
 > > Did I get the point saying ther's no way to do swap encryption
 > > in linux right now? (Well, a swapfile in an encrypted kerneli
 > > partition r something like that is not really what I want to
 > > do I think).
 > 
 > What's the benefit?  Sure, attackers have to know that encrypted swap is
 > in use, and have to be able to find the key in memory, but they already
 > can do both if they're root, and non-root can't [shouldn't be able to]
 > read swap devices on a properly secured machine.  Swap isn't meant for
 > storage across reboots/remounts, which is the only reason I can think of
 > for using encrypted loopback.  Once it's mounted, unless you have to enter
 > the password for every write, or unless it locks after some period of
 > inactivity (locking swap and requiring the password to unlock it sounds
 > like a fun proposition when the vm needs to swap), it's insecure until
 > it's locked/unmounted again.  Unmounting swap in a running system isn't
 > typical behavior.

It does prevent one means of recovering possibly security-critical
information for attackers who do have physical access to the machine.

The obvious approach to me would to generate a random session key at
boot time and use that for encrypting/decrypting swap pages.  If the
machine is unplugged and the disk pulled out, then the swap area on that
disk could not be recovered the attacker, who presumably is prevented by
other security measures from gaining root on the machine before it's
unplugged to try to get that session key out of the kernel.  I haven't
studied this problem, though, so the real solution may be quite a bit
more clever.
