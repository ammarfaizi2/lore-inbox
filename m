Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135280AbRDRTvx>; Wed, 18 Apr 2001 15:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135274AbRDRTvm>; Wed, 18 Apr 2001 15:51:42 -0400
Received: from m193-mp1-cvx1c.col.ntl.com ([213.104.76.193]:34432 "EHLO
	[213.104.76.193]") by vger.kernel.org with ESMTP id <S135272AbRDRTvY>;
	Wed, 18 Apr 2001 15:51:24 -0400
To: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
        "'Pavel Machek'" <pavel@suse.cz>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <Pine.LNX.4.31.0104181715370.21805-100000@phobos.fachschaften.tu-muenchen.de>
From: John Fremlin <chief@bandits.org>
Date: 18 Apr 2001 20:51:12 +0100
In-Reply-To: Simon Richter's message of "Wed, 18 Apr 2001 17:26:42 +0200 (CEST)"
Message-ID: <m2u23m3s27.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de> writes:

[...]

> Yes, that will be a separate daemon that will also get the
> events. But I think it's a good idea to have a simple interface that
> allows the user to run arbitrary commands when ACPI events occur,
> even without acpid running (think of singleuser mode, embedded
> systems, ...).

The pmpolicy patch presents such a simple interface. An executable
(the location of which is configurable) is run from the kernel with
certain arguments.

The advantages of this: 

(1) No nasty magic number binary interface, everything is text ->

(2) Any sysadmin can easily write an event handler in sh, perl, or
whatever scripting language, i.e. the userspace handler is much
simpler.

(3) No events, no bloat. 

(4) Kernel code is probably shorter (tho' less standard) than having a
special device or procfs node.

(5) Efficiency: the alternative is to have a program like APMD
decoding the nasty binary interface and then spawning a shell script
to deal with it.

I myself am starting to dislike the idea: it was mostly motivated by
the need to exercise a veto on APM events. This is in fact not
necessary, if I understand correctly. An interface allowing multiple
listeners is preferable.

It remains to contact all the maintainers of the various PM and UPS
systems to flesh out exactly what the interface should be capable of
;-)

[...]

-- 

	http://www.penguinpowered.com/~vii
