Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262457AbVCHXvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbVCHXvc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 18:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbVCHXq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 18:46:59 -0500
Received: from loon.tech9.net ([69.20.54.92]:53991 "EHLO loon.tech9.net")
	by vger.kernel.org with ESMTP id S262206AbVCHXl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 18:41:26 -0500
Subject: Re: 2.6.11-mm2
From: Robert Love <rlove@rlove.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1110325018l.6106l.0l@werewolf.able.es>
References: <20050308033846.0c4f8245.akpm@osdl.org>
	 <1110325018l.6106l.0l@werewolf.able.es>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 18:44:02 -0500
Message-Id: <1110325442.30255.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-08 at 23:36 +0000, J.A. Magallon wrote:

> Can cpu affinity really be changed for a running process ?

Yes.

> Does it need something like io or yielding to take effect ?

No.

> I am playin with Robert Love's taskset (symlinked to runon, it is easier
> to type and I'm more used to it), because I want to play with hyperthreading
> and wanted a method to force two threads on the same physical package.
> It works fine to bound a new process to a cpu set, but I does not change
> anything for a running process.
> 
> I try runon -c -p 0 <pid> for my numbercruncher and it does nothing, top
> shows it is in the same cpus where it started:
> 
> werewolf:~# runon -c -p 0 8277
> pid 8277's current affinity list: 0-3
> pid 8277's new affinity list: 0
> werewolf:~# runon -c -p 8277
> pid 8277's current affinity list: 0

This looks fine.  As expected.

Although, you have the syntax wrong.  It should be

	taskset -c 0 -p 8277

and

	taskset -p 8277

> The program uses posix threads, 2 in this case. The two threads change from
> cpu sometimes (not too often), but do not go into the same processor
> immediately as when I start the program directly with runon/taskset.

You have to bind all of the threads individually.

	Robert Love


