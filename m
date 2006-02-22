Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161132AbWBVReE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161132AbWBVReE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 12:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161135AbWBVReE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 12:34:04 -0500
Received: from boogie.lpds.sztaki.hu ([193.225.12.226]:38366 "EHLO
	boogie.lpds.sztaki.hu") by vger.kernel.org with ESMTP
	id S1161132AbWBVReC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 12:34:02 -0500
Date: Wed, 22 Feb 2006 18:33:54 +0100
From: Gabor Gombas <gombasg@sztaki.hu>
To: "Theodore Ts'o" <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@suse.de>,
       penberg@cs.helsinki.fi, gregkh@suse.de, bunk@stusta.de, rml@novell.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060222173354.GJ14447@boogie.lpds.sztaki.hu>
References: <1140562261.11278.6.camel@localhost> <20060221225718.GA12480@vrfy.org> <20060221153305.5d0b123f.akpm@osdl.org> <20060222000429.GB12480@vrfy.org> <20060221162104.6b8c35b1.akpm@osdl.org> <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org> <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org> <20060222112158.GB26268@thunk.org> <20060222154820.GJ16648@ca-server1.us.oracle.com> <20060222162533.GA30316@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222162533.GA30316@thunk.org>
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 11:25:34AM -0500, Theodore Ts'o wrote:

> Sounds like this is another of example of system support programs
> (insmod in this case) breaking with modern kernels.

I don't think isnmod is broken. It's job is to load a chunk of code into
the kernel, and it's doing just that.

The asynchronous device discovery is caused/required by hotplug. If you
can recreate the problem with a kernel that has CONFIG_HOTPLUG disabled,
then I agree that this is a kernel bug which should be fixed.

But if your kernel has CONFIG_HOTPLUG enabled, then _you_ have asked for
this exact behavior, therefore you should better fix userspace to cope
with it. Your initrd should use the notification mechanisms provided by
the kernel to wait for the would-be root device really becoming
available; if it's not doing that, then IMHO you should not use a
CONFIG_HOTPLUG enabled kernel.

As I see, a lot of people spent a lot of work making the kernel
hotplug-friendly. Unfortunately a lot less work was done on the
userspace side, that's why there are still a lot of initscripts that
assume they can immediately access the device after insmod have
returned, even if they are running on a hotplug-enabled kernel.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------
