Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbVCIAjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbVCIAjr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 19:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVCIAgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 19:36:55 -0500
Received: from smtp09.auna.com ([62.81.186.19]:51691 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S262230AbVCHXhL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 18:37:11 -0500
Date: Tue, 08 Mar 2005 23:36:58 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.11-mm2
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
References: <20050308033846.0c4f8245.akpm@osdl.org>
In-Reply-To: <20050308033846.0c4f8245.akpm@osdl.org> (from akpm@osdl.org on
	Tue Mar  8 12:38:46 2005)
X-Mailer: Balsa 2.3.0
Message-Id: <1110325018l.6106l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI all...

On 03.08, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm2/
> 

(replied to this because this is the kernel I am testing on :) )

Can cpu affinity really be changed for a running process ?
Does it need something like io or yielding to take effect ?

I am playin with Robert Love's taskset (symlinked to runon, it is easier
to type and I'm more used to it), because I want to play with hyperthreading
and wanted a method to force two threads on the same physical package.
It works fine to bound a new process to a cpu set, but I does not change
anything for a running process.

I try runon -c -p 0 <pid> for my numbercruncher and it does nothing, top
shows it is in the same cpus where it started:

werewolf:~# runon -c -p 0 8277
pid 8277's current affinity list: 0-3
pid 8277's new affinity list: 0
werewolf:~# runon -c -p 8277
pid 8277's current affinity list: 0

The program uses posix threads, 2 in this case. The two threads change from
cpu sometimes (not too often), but do not go into the same processor
immediately as when I start the program directly with runon/taskset.

Any idea ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.11-jam3 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-3mdk)) #1


