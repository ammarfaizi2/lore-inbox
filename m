Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbTKYRPc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 12:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbTKYRPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 12:15:32 -0500
Received: from mail4-141.ewetel.de ([212.6.122.141]:58611 "EHLO
	mail4.ewetel.de") by vger.kernel.org with ESMTP id S262777AbTKYRPZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 12:15:25 -0500
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-rc5
In-Reply-To: <VOyg.w9.11@gated-at.bofh.it>
References: <VOyg.w9.13@gated-at.bofh.it> <VOyg.w9.11@gated-at.bofh.it>
Date: Tue, 25 Nov 2003 18:15:21 +0100
Message-Id: <E1AOgmX-0000Oz-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Nov 2003 17:50:20 +0100, you wrote in linux.kernel:

>    "overcommit_memory < 0" supposed to not allow apps to overallocate 
> memory - but still it works not like it is said in 
> Documentation/filesystems/proc.txt.

Actually, looking at vm_enough_memory in mm/mmap.c in 2.4, which seems to
be the only user of sysctl_overcommit_memory, it is just used directly in
an if clause:

	if (sysctl_overcommit_memory)
		return 1;
		
This means any value different from 0 will turn overcommit on, no matter
whether positive or negative value.

Documentation bug, I would say.

-- 
Ciao,
Pascal
