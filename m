Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312412AbSDCWWa>; Wed, 3 Apr 2002 17:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312418AbSDCWWU>; Wed, 3 Apr 2002 17:22:20 -0500
Received: from ns.exp-math.uni-essen.de ([132.252.150.18]:27663 "EHLO
	irmgard.exp-math.uni-essen.de") by vger.kernel.org with ESMTP
	id <S312412AbSDCWWA>; Wed, 3 Apr 2002 17:22:00 -0500
Date: Thu, 4 Apr 2002 00:21:58 +0200 (MESZ)
From: "Dr. Michael Weller" <eowmob@exp-math.uni-essen.de>
To: linux-kernel@vger.kernel.org
Subject: Is this /dev/sg security hole from 2.2.* already fixed?
Message-Id: <Pine.A32.3.95.1020404001954.18784A-100000@werner.exp-math.uni-essen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry,

I probably should just check myself in recent 2.4.* kernels, but I don't
have one at hand on an SCSI capable machine.

Playing around with generic scsi on my 2.2.18 SCSI based Intel machine, I
noticed that if one reads a large allocated SCSI reply packet from the
/dev/sg device, but the physical scsi device did only use part of the
allocated reply space, then the remaining, unused bytes of the reply
packet are not initialized. 

Typically they seem to contain data from other files (some no longer used
diskbuffers or so) [in my case: C-source of the same program].

In case of several accesses to /dev/sg device (same process or same
program run anew on a different /dev/sg device) the remaining bytes
often contained data of previously issued, longer generic scsi
transactions.

Esp. since AFAIK /dev/sg can be used by non-root users (given write access
to /dev/sg) and other peoples data might pop up in the uninitialized reply
packet, I consider this an (albeit difficult to exploit) security hole.

I assume such a simple problem must have been detected and solved already,
but I can't get a specific answer from any search machine or list archive.

Can someone please comment or try on recent kernels?

THX,
Michael.


--

Michael Weller: eowmob@exp-math.uni-essen.de, eowmob@ms.exp-math.uni-essen.de,
or even mat42b@spi.power.uni-essen.de. If you encounter an eowmob account on
any machine in the net, it's very likely it's me.


