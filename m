Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUCHVvF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 16:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbUCHVvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 16:51:04 -0500
Received: from fungus.teststation.com ([212.32.186.211]:38406 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id S261234AbUCHVvB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 16:51:01 -0500
Date: Mon, 8 Mar 2004 22:50:52 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.local
To: Stian Jordet <liste@jordet.nu>
cc: =?ISO-8859-1?Q?S=F8ren?= Hansen <sh@warma.dk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: smbfs patch
In-Reply-To: <1078781118.4013.1.camel@buick.jordet>
Message-ID: <Pine.LNX.4.44.0403082234460.15861-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Mar 2004, Stian Jordet wrote:

> tor, 04.03.2004 kl. 23.20 skrev Søren Hansen:
> > I noticed that smbfs no longer respects the "uid" and "gid" mount
> > options passed to it by mount.(I think it stopped when the server was
> > upgraded to Samba 3.0. Not sure though, since my client was upgraded to
> > Linux 2.6.3 at around the same time). I've made this small patch that
> > fixes it (bear with me, this is my first patch to the kernel :-)  ):
> 
> I have the same problem as you have. I have not gotten around to test
> your patch yet (but will later tonight), but I read in another mail from
> you that you had discussed the patch with Urban Widmark. Is the any
> opinions against this patch? If not, will you try to submit it to
> Andrew/Linus?

There is nothing directly wrong with the patch, but maybe there are better 
solutions.

Here is my summary of our off-list discussion.

1. If you configure samba and disable the unix extensions ("UE") in
   smb.conf then smbfs will behave like it does with earlier samba 
   servers.

2. The idea with the UE is to communicate better over smb between unix 
   systems and uid/gid mapping isn't done in things like nfs.
   Perhaps what you really want is to disable the unix extensions on 
   the smbfs side?

3. If this is needed for smbfs+UE perhaps it is also useful for other
   filesystems in some cases. Some non-unixlike filesystems have these
   mappings already and perhaps they would be generally useable.
   (see also the "UID/GID mapping system" post to this list)

Sorry for taking that thread off-list, btw. I didn't read the message too
carefully when Andrew poked me for not responding.

/Urban

