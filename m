Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWBVPwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWBVPwJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 10:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWBVPwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 10:52:09 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:30305 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751358AbWBVPwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 10:52:08 -0500
Date: Wed, 22 Feb 2006 07:48:21 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@suse.de>,
       penberg@cs.helsinki.fi, gregkh@suse.de, bunk@stusta.de, rml@novell.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060222154820.GJ16648@ca-server1.us.oracle.com>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Kay Sievers <kay.sievers@suse.de>, penberg@cs.helsinki.fi,
	gregkh@suse.de, bunk@stusta.de, rml@novell.com,
	linux-kernel@vger.kernel.org, johnstul@us.ibm.com
References: <1140383653.11403.8.camel@localhost> <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost> <20060221225718.GA12480@vrfy.org> <20060221153305.5d0b123f.akpm@osdl.org> <20060222000429.GB12480@vrfy.org> <20060221162104.6b8c35b1.akpm@osdl.org> <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org> <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org> <20060222112158.GB26268@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222112158.GB26268@thunk.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 06:21:58AM -0500, Theodore Ts'o wrote:
> with all of the kernel modules I need compiled into the kernel.  I
> still have no idea why mptscsi fails to detect SCSI disks when loaded
> as a module via initrd on various bits of IBM hardware (including the
> e326 and ls-20 blade), but works fine when compiled directly into the
> kernel....

Ted,
	Do you mean that you are using a distro (eg, RHEL4 or something)
with a mainline kernel?  We've seen something similar, and what we've
determined is happening is that insmod is returning before the module is
done initializing.  It's not that mptscsi fails to detect the disks.
Rather, it's still in the detection process when the boot process tries
to mount /.  So there's no / yet, and the thing hangs.  In the case we
see, it's some interaction between the RHEL4/SLES9 version of
module-init-tools and the latest version of the kernel.  Our first
attempt at fixing it was to change the linuxrc to sleep between each
insmod.  This works, but only if the modules load and initialize
themsleves fast enough.  Get a FC card in there, and it just doesn't
work.  So we've taken to compiling the modules in-kernel.

Joel

-- 

"Three o'clock is always too late or too early for anything you
 want to do."
        - Jean-Paul Sartre

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
