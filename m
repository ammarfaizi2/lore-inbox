Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262933AbVCWUzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262933AbVCWUzS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 15:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262924AbVCWUwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 15:52:45 -0500
Received: from smtp-out.tiscali.no ([213.142.64.144]:28944 "EHLO
	smtp-out.tiscali.no") by vger.kernel.org with ESMTP id S262927AbVCWUsn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 15:48:43 -0500
Subject: Re: forkbombing Linux distributions
From: Natanael Copa <mlists@tanael.org>
To: aq <aquynh@gmail.com>
Cc: "Hikaru1@verizon.net" <Hikaru1@verizon.net>, linux-kernel@vger.kernel.org
In-Reply-To: <9cde8bff05032309056c9643a7@mail.gmail.com>
References: <e0716e9f05032019064c7b1cec@mail.gmail.com>
	 <20050322112628.GA18256@roll>
	 <Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr>
	 <20050322124812.GB18256@roll> <20050322125025.GA9038@roll>
	 <9cde8bff050323025663637241@mail.gmail.com> <1111581459.27969.36.camel@nc>
	 <9cde8bff05032305044f55acf3@mail.gmail.com> <1111586058.27969.72.camel@nc>
	 <9cde8bff05032309056c9643a7@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 23 Mar 2005 21:48:42 +0100
Message-Id: <1111610922.20101.41.camel@nc>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-24 at 02:05 +0900, aq wrote:

> I agree that make kernel more restrictive by default is a good approach.

Thank you! For a moment I thought I was the only human on this planet
who thought that.

Next question is where and how and what is an appropiate limit? I have
not heard any better suggestions than this:

--- kernel/fork.c.orig  2005-03-02 08:37:48.000000000 +0100
+++ kernel/fork.c       2005-03-21 15:22:50.000000000 +0100
@@ -119,7 +119,7 @@
         * value: the thread structures can take up at most half
         * of memory.
         */
-       max_threads = mempages / (8 * THREAD_SIZE / PAGE_SIZE);
+       max_threads = mempages / (16 * THREAD_SIZE / PAGE_SIZE);

        /*
         * we need to allow at least 20 threads to boot a system


(FYI: A few lines below the default RLIMIT_NPROC is calculated from
max_threads/2)

This would give default maximum number of processes from the amount of
low memory:

RAM     RLIMIT_NPROC
64MiB   256
128MiB  512
256MiB  1024
512MiB  2048
1GiB    4096

That would be sufficent for the users to play their games, compile ther
stuff etc while it would protect everyone from that classic shell fork
bomb by default.

Actually, Alan Cox tried this in the 2.4.7-ac1 kernel
http://marc.theaimsgroup.com/?l=linux-kernel&m=99617009115570&w=2

but I have no idea why it was raised to the double afterwards.

--
Natanael Copa


