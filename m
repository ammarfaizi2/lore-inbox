Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129696AbRB0KTK>; Tue, 27 Feb 2001 05:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129699AbRB0KTA>; Tue, 27 Feb 2001 05:19:00 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:8530
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129696AbRB0KSr>; Tue, 27 Feb 2001 05:18:47 -0500
Date: Tue, 27 Feb 2001 11:18:39 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rsync over ssh on 2.4.2 to 2.2.18
Message-ID: <20010227111839.F2736@jaquet.dk>
In-Reply-To: <200102271002.f1RA2B408058@brick.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200102271002.f1RA2B408058@brick.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Tue, Feb 27, 2001 at 10:02:11AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2001 at 10:02:11AM +0000, Russell King wrote:
> Hi,
> 
> I'm seeing odd behaviour with rsync over ssh between two x86 machines -
> one if the is an UP PIII (Katmai) running 2.4.2 (isdn-gw) and the other
> is an UP Pentium 75-200 (pilt-gw) running 2.2.15pre13 with some custom
> serial driver hacks (for running Amplicon cards with their ISA interrupt-
> sharing scheme).

[...]

I have seen behaviour similar to this (descibed in 
http://marc.theaimsgroup.com/?l=linux-kernel&m=98262067309185&w=2)
locally on a 2.4.X machine where the rsync completes but fails to
terminate, apparently because the child does not receive the KILLUSR1
(wild speculation)? Anyways, the parent process waits in wait4 and
the child loops, waiting for the signal. This is not reproducable
in 2.2.X (for me).

I have found that in order to reproduce this problem I need to
make rsync do a certain amount of work. Ie., rsync linux/drivers
new-dir will make rsync hang, but rsync linux/drivers/[a-p]* does
not. Does the same thing apply for you? stracing the rsync does
make it all work if I specify that rsync should trace the child,
too.


Regards,
  Rasmus
