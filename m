Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbVC3UuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbVC3UuH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 15:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVC3Uqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 15:46:55 -0500
Received: from fire.osdl.org ([65.172.181.4]:28874 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262432AbVC3Uo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 15:44:56 -0500
Date: Wed, 30 Mar 2005 12:44:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.12-rc1-mm3] BUG: atomic counter underflow in smbfs
Message-Id: <20050330124456.3da2a2b8.akpm@osdl.org>
In-Reply-To: <20050330201818.GA18967@ens-lyon.fr>
References: <20050330201818.GA18967@ens-lyon.fr>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benoit Boissinot <benoit.boissinot@ens-lyon.org> wrote:
>
> I had the following BUG with 2.6.12-rc1-mm3:
> 
> remote host is running 2.6.12-rc1-mm1 with samba 3.0.13.
> 
> [23156.357178] smb_lookup: find musique/Pink_Floyd-Dark_Side_of_the_Moon
> failed, error=-512
> [23157.057501] BUG: atomic counter underflow at:
> [23157.057508]  [<c0103c27>] dump_stack+0x17/0x20
> [23157.057516]  [<e0ed0f31>] smb_rput+0x51/0x60 [smbfs]
> [23157.057530]  [<e0ecd497>] smb_proc_query_cifsunix+0x77/0xa0 [smbfs]
> [23157.057538]  [<e0eca14c>] smb_newconn+0x2bc/0x310 [smbfs]
> [23157.057546]  [<e0ed05ac>] smb_ioctl+0xfc/0x100 [smbfs]
> [23157.057554]  [<c0162188>] do_ioctl+0x48/0x70
> [23157.057559]  [<c01622f9>] vfs_ioctl+0x59/0x1b0
> [23157.057563]  [<c0162489>] sys_ioctl+0x39/0x60
> [23157.057582]  [<c0102d8f>] sysenter_past_esp+0x54/0x75

Oh dear.  That warning is not necessarily telling us that there's a serious
problem - often it's fairly harmless.  Did the filesytem misbehave in any
other manner?

A problem we have here is that nobody really maintains smbfs any more, and
it has problems.  I was hoping that the stock answer to that would be "use
cifs", but for some reason that doesn't seem to be happening.  Have you
tried it?  (Last time I looked, cifs didn't work against win98 servers -
maybe that got fixed).


