Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287784AbSAAKTp>; Tue, 1 Jan 2002 05:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287789AbSAAKTh>; Tue, 1 Jan 2002 05:19:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2579 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287784AbSAAKTV>; Tue, 1 Jan 2002 05:19:21 -0500
Subject: Re: [patch] Prefetching file_read_actor()
To: davej@suse.de (Dave Jones)
Date: Tue, 1 Jan 2002 10:29:20 +0000 (GMT)
Cc: akpm@zip.com.au (Andrew Morton), manfred@colorfullife.com (Manfred Spraul),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.33.0112312045130.17274-100000@Appserv.suse.de> from "Dave Jones" at Dec 31, 2001 08:47:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LMAa-0008DU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My initial guess is that some of the callers of copy_to_user are
> doing something that is harmed the prefetching.
> (Maybe they are doing additional prefetch() calls)

Most callers are dealing with cached data, and unless you checked the
length in advance to make a sensible decision it will just make things ugly.
If you aren't copying 512 bytes+ its probably not worth it.

