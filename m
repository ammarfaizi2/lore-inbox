Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130113AbQKNLNS>; Tue, 14 Nov 2000 06:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129507AbQKNLNJ>; Tue, 14 Nov 2000 06:13:09 -0500
Received: from oxmail1.ox.ac.uk ([129.67.1.1]:12260 "EHLO oxmail.ox.ac.uk")
	by vger.kernel.org with ESMTP id <S129429AbQKNLNF>;
	Tue, 14 Nov 2000 06:13:05 -0500
Date: Tue, 14 Nov 2000 10:42:41 +0000
From: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
To: Keith Owens <kaos@ocs.com.au>
Cc: Peter Samuelson <peter@cadcamlab.org>, Torsten.Duwe@caldera.de,
        Chris Evans <chris@scary.beasts.org>, linux-kernel@vger.kernel.org
Subject: Re: Modprobe local root exploit
Message-ID: <20001114104240.A30388@sable.ox.ac.uk>
In-Reply-To: <20001113230210.F18203@wire.cadcamlab.org> <3864.974181019@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3864.974181019@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Tue, Nov 14, 2000 at 04:50:19PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:
> All these patches against request_module are attacking the problem at
> the wrong point.  The kernel can request any module name it likes,
> using any string it likes, as long as the kernel generates the name.
> The real problem is when the kernel blindly accepts some user input and
> passes it straight to modprobe, then the kernel is acting like a setuid
> wrapper for a program that was never designed to run setuid.

Rather than add sanity checking to modprobe, it would be a lot easier
and safer from a security audit point of view to have the kernel call
/sbin/kmodprobe instead of /sbin/modprobe. Then kmodprobe can sanitise
all the data and exec the real modprobe. That way the only thing that
needs auditing is a string munging/sanitising program.

--Malcolm

-- 
Malcolm Beattie <mbeattie@sable.ox.ac.uk>
Unix Systems Programmer
Oxford University Computing Services
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
