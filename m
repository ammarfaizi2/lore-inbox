Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318787AbSICPdM>; Tue, 3 Sep 2002 11:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318790AbSICPdM>; Tue, 3 Sep 2002 11:33:12 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:11910 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318787AbSICPdL>; Tue, 3 Sep 2002 11:33:11 -0400
Date: Tue, 3 Sep 2002 16:37:40 +0100 (BST)
From: Anton Altaparmakov <aia21@cantab.net>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mount flag "direct"
In-Reply-To: <200209031501.g83F1Oa31142@oboe.it.uc3m.es>
Message-ID: <Pine.SOL.3.96.1020903163309.14707D-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2002, Peter T. Breuer wrote:

> I'll rephrase this as an RFC, since I want help and comments.
> 
> Scenario:
> I have a driver which accesses a "disk" at the block level, to which
> another driver on another machine is also writing. I want to have
> an arbitrary FS on this device which can be read from and written to
> from both kernels, and I want support at the block level for this idea.

You cannot have an arbitrary fs. The two fs drivers must coordinate with
each other in order for your scheme to work. Just think about if the two 
fs drivers work on the same file simultaneously and both start growing the
file at the same time. All hell would break lose.

For your scheme to work, the fs drivers need to communicate with each
other in order to attain atomicity of cluster and inode (de-)allocations,
etc.

Basically you need a clustered fs for this to work. GFS springs to
mind but I never really looked at it...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

