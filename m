Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbTDKAhg (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 20:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264276AbTDKAhf (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 20:37:35 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:8153 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id S262186AbTDKAhd (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 20:37:33 -0400
Date: Thu, 10 Apr 2003 17:47:03 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit kdev_t - just for playing
Message-ID: <20030411004703.GQ31739@ca-server1.us.oracle.com>
References: <1049913637.1993.73.camel@mulgrave> <Pine.LNX.4.44.0304092202570.5042-100000@serv> <1049941189.4467.186.camel@mulgrave> <Pine.LNX.4.44.0304101033500.5042-100000@serv> <1049988660.1998.100.camel@mulgrave> <Pine.LNX.4.44.0304102029430.5042-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304102029430.5042-100000@serv>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 01:53:07AM +0200, Roman Zippel wrote:
> So we do break compatibility! Wow, it really took quite some time until 
> someone confirmed this...

	No, the current patch DOES NOT BREAK compatibility.  Device
numbers from 00:00 to FF:FF are not munged in any way.  As long as
regular drivers don't expect anything else (eg, a new scsi driver that
uses a new larger major), nothing is broken or changed.

> The current numbering matches the naming, 0x0301 is /dev/hda1, 0x0802 is 
> /dev/sda2 and 0x4103 is /dev/sdq3, the proposed patch does change the 
> numbering _and_ naming policy.

	The proposed patch changes none of it.  Folks have proposed
other changes based upon it, but Andreas' patch as it stands (at least,
last time I looked at it) does not break this.

> This may be true in the kernel, but you move all the compatibility 
> problems into user space and so we just added another ugly emulation 
> layer.

	Naming is entirely a userspace problem.  It is also an extremely
hard problem.  Consider that the UK folks will want /dev/disc and the US
folks will want /dev/disk.  That's before we even approach persistent
naming.

> Oh, I do listen, you can be sure of that, but what am I supposed to so, 
> when it even takes weeks to get a clear answer about something simple as 
> compatibility? When I ask questions, I get evading answers, when I say 
> it's broken, I get silence, what else can I do?

	I will repeat:  The patch does not break compatibility, and any
discussion of new device spaces based on the larger number have been
theoretical.  If you had read the patch, you would have seen this.

> Producing a patch isn't that difficult, but I'd rather be interested, if 
> there is even interest in such a patch? I already got not a single comment 
> about the last patch.

	Propose a dynamic system.  Show us your code.  Until you do,
do not clutter the simple task of "expand the size of dev_t" with the
orthogonal task of "how do we use this new dev_t".

Joel

-- 

"You cannot bring about prosperity by discouraging thrift. You cannot
 strengthen the weak by weakening the strong. You cannot help the wage
 earner by pulling down the wage payer. You cannot further the
 brotherhood of man by encouraging class hatred. You cannot help the
 poor by destroying the rich. You cannot build character and courage by
 taking away a man's initiative and independence. You cannot help men
 permanently by doing for them what they could and should do for themselves."
	- Abraham Lincoln 


Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
