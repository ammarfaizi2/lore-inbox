Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130521AbRCPPiv>; Fri, 16 Mar 2001 10:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130587AbRCPPil>; Fri, 16 Mar 2001 10:38:41 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:4526 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130582AbRCPPic>;
	Fri, 16 Mar 2001 10:38:32 -0500
Date: Fri, 16 Mar 2001 10:37:49 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Wayne.Brown@altec.com
cc: linux-kernel@vger.kernel.org
Subject: Re: How to mount /proc/sys/fs/binfmt_misc ?
In-Reply-To: <86256A11.005489D0.00@smtpnotes.altec.com>
Message-ID: <Pine.GSO.4.21.0103161030330.12618-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Mar 2001 Wayne.Brown@altec.com wrote:

>   The release notes specify this:
> 
>      mount -t binfmt_misc none /proc/sys/fs/binfmt_misc
> 
> but this doesn't work because
> 
>      mount: mount point /proc/sys/fs/binfmt_misc does not exist

Grr... OK, I've been an overoptimistic idiot and missed that ugliness.

Solutions:
	a) mount it on some real place. And write there to register
entries instead of the bogus /proc/sys/fs/binfmt_misc
	b) add a couple of proc_mkdir() into fs/proc/root.c
That is, add
	proc_mkdir("sys/fs", 0):
	proc_mkdir("sys/fs/binfmt_misc", 0);
after the line that says
	proc_mkdir("sys", 0);

I would strongly recommend (a). In the long run we'll need to go that
way.

