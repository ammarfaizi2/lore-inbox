Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbVBBCKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbVBBCKa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 21:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbVBBCK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 21:10:29 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:28084 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S262203AbVBBCKV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 21:10:21 -0500
Date: Tue, 1 Feb 2005 21:10:20 -0500
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Ram <linuxram@us.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] shared subtrees
Message-ID: <20050202021020.GC23662@fieldses.org>
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk> <41FABD4E.6050701@sun.com> <1107224911.8118.65.camel@localhost> <41FF2985.8000903@sun.com> <1107286073.8118.80.camel@localhost> <41FFF178.902@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FFF178.902@sun.com>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 04:15:36PM -0500, Mike Waychison wrote:
> No.  I want to allow the mount.  However, if there are several shared
> '/home' (through CLONE_NS or mount --bind), there remains the following
> two key problems:
> 
> - - How do you expire the mounts and umount them?  (undefined with shared
> subtrees thus far)
> - - How do you handle the case where '/home/mikew' is automounted in all
> instances of it, and then umounted in a single namespace.  Walking back
> into '/home/mikew' in that namespace will trigger the daemon to mount
> again, but the filesystem is already mounted in it's namespace.
> 
> I guess a solution to ponder is what if we included the following rule:
> 
> "An attempt to umount a vfsmount X will induce the umounting of all
> vfsmounts in X's p-node as well as all vfsmounts/p-nodes 'owned' by said
> p-node."

>From Viro's proposal:

> 	5. umount
> umount everything that gets propagation from victim.

I think that agrees with your description.

What *should* be the behaviour when someone unmounts something that was
mounted by the automounter?  That seems like a strange thing to do.

--b.
