Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVA2TY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVA2TY2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 14:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVA2TTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 14:19:47 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:26029 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261556AbVA2TSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 14:18:50 -0500
Message-ID: <41FBE18B.2010105@lsrfire.ath.cx>
Date: Sat, 29 Jan 2005 20:18:35 +0100
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Restrict procfs permissions
References: <20050129024542.GB12270@lsrfire.ath.cx> <20050129044109.GR8859@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050129044109.GR8859@parcelfarce.linux.theplanet.co.uk>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Sat, Jan 29, 2005 at 03:45:42AM +0100, Rene Scharfe wrote:
> 
>> The patch is inspired by the /proc restriction parts of the
>> GrSecurity patch.  The main difference is the ability to configure
>> the restrictions dynamically.  You can change the umask setting by
>> running
>> 
>> # mount -o remount,umask=007 /proc
>> 
>> Testing has been *very* light so far -- it compiles and boots.
>> Patch is against 2.6.11-rc2-bk6.
>> 
>> Comments are very welcome.
> 
> 
> It leaves already existing inodes with whatever mode they used to
> have.

I said "configure the restrictions dynamically" but I meant "doesn't
need a recompile to change settings".  I expect the umask to be
specified in /etc/fstab and rarely changed in a running system.  With
that in mind I think the patch is useful as-is, especially because it's
so small.  But I agree, that thing is a dirty hack. :]

> _IF_ you want to do that sort of things, do it right - add
> ->permission() that would apply that umask before checks and if you
> want it to be seen in results of stat(2) - add ->gettattr() and do
> the same there.

Aww, that sounds expensive.  My favourite solution would be to only 
allow the umask to be changed at mount time, not when remounting.

Calling parse_options from proc_fill_super, only and not from 
proc_remount does not help very much because proc_fill_super is only 
called at boot (or proc module load time).  Is there another way?

While we are here: how would one change the uid or gid parameter? With a 
built-in proc fs the mount -a -t proc in the init scripts only results 
in a proc_remount call which (in mainline) doesn't bother looking at 
parameters at all.  The same is true for a unmount, mount sequence.

Thanks,
Rene
