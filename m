Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbVCIAJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbVCIAJl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 19:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbVCIAFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 19:05:49 -0500
Received: from smtp09.auna.com ([62.81.186.19]:25840 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S262439AbVCHXvb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 18:51:31 -0500
Date: Tue, 08 Mar 2005 23:51:30 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.11-mm2
To: Robert Love <rlove@rlove.org>
Cc: linux-kernel@vger.kernel.org
References: <20050308033846.0c4f8245.akpm@osdl.org>
	<1110325018l.6106l.0l@werewolf.able.es>
	<1110325442.30255.8.camel@localhost>
In-Reply-To: <1110325442.30255.8.camel@localhost> (from rlove@rlove.org on
	Wed Mar  9 00:44:02 2005)
X-Mailer: Balsa 2.3.0
Message-Id: <1110325890l.6106l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.09, Robert Love wrote:
> On Tue, 2005-03-08 at 23:36 +0000, J.A. Magallon wrote:
> 
> > Can cpu affinity really be changed for a running process ?
> 
> Yes.
> 
> > Does it need something like io or yielding to take effect ?
> 
> No.
> 
...
> 
> Although, you have the syntax wrong.  It should be
> 
> 	taskset -c 0 -p 8277
> 

That was what I first tried, but:

werewolf:~> ps -ef | grep box
magallon  8638  8629 99 00:47 pts/0    00:01:54 box-d --out box.srf @opt
magallon  8733  8643  0 00:48 pts/2    00:00:00 grep box
werewolf:~> taskset -c 0 -p 8638
execvp: No such file or directory
failed to execute -p

> 
> > The program uses posix threads, 2 in this case. The two threads change from
> > cpu sometimes (not too often), but do not go into the same processor
> > immediately as when I start the program directly with runon/taskset.
> 
> You have to bind all of the threads individually.
> 

Ahh, damn, that explains it. I use a main thread that does nothing but
wait for the worker threads. So it sure gets moved to CPU0, but as it
does not waste CPU time, I do not see it...

Thanks. Will see what can I do with my threads. cpusets, perhaps...

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.11-jam3 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-3mdk)) #1


