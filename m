Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbULLWCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbULLWCS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 17:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbULLWCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 17:02:18 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:63907 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262147AbULLWCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 17:02:01 -0500
Date: Sun, 12 Dec 2004 23:01:51 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: how to detect a 32 bit process on 64 bit kernel
In-Reply-To: <20041212215110.GA11451@mellanox.co.il>
Message-ID: <Pine.LNX.4.61.0412122255390.29854@yvahk01.tjqt.qr>
References: <20040901072245.GF13749@mellanox.co.il> <20040903080058.GB2402@wotan.suse.de>
 <20040907104017.GB10096@mellanox.co.il> <20040907121418.GC25051@wotan.suse.de>
 <20041212215110.GA11451@mellanox.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello!
>Is there a reliable way e.g. on x86-64 (or ia64, or any other
>64-bit system), from the char device driver,
>to find out that I am running an operation in the context of a 32-bit
>task?

I doubt you can distinguish these two (with the exception of looking at the 
ELF header of a file), because

	mov eax, 12345;

is valid for classic IA-32 -and- amd64, just as "mov ax,12" works for
any >= 80286.

>If no - would not it make a sence to add e.g. a flag in the
>task struct, to make it possible?

I do not see a reason why I would want to know this kind of information ATM, 
so this is something you will probably have keep in your own tree.

Basically, it is possible, you probably have to patch fs/binfmt_elf.c
a little to store a flag whether an ELF32 or ELF64 is currently being 
executed, and store it preferably in current->some_var_name;

Then you will also need to poke in fs/proc/* to export this information to 
userspace, otherwise there is no meaning in patching the task struct.



Jan Engelhardt
-- 
ENOSPC
