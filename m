Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbTEKXKE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 19:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbTEKXKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 19:10:04 -0400
Received: from corky.net ([212.150.53.130]:15506 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S261450AbTEKXKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 19:10:03 -0400
Date: Mon, 12 May 2003 02:22:40 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <1052689591.30506.9.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0305120149280.19268-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Security to some people means that nothing happens unrecorded. Most high
> security environments treat DoS attacks as the least interesting. You
> knocked down my military server - who cares. You stole my list of secret
> command centres - Im deeply upset.

You're right, but panic() is seldom the right solution, even in such case.
In most cases, killing the process generating the noise (or all the
processes of its uid) is enough and keeps the system more robust.  Even if
the system runs out of log-space and fails to stop the noise-maker, it can
usually take down network interfaces and alert the admin.  Still cleaner
than crashing.  Thats what Cray Unicos does when low on certain resources.
It stops the attack while minimizing recovery time.  (Rebooting these
beasts can be painful).  The system stops network traffic while it still
has some space left, and panics only if it still runs out of space
(unlikely).  No audit trail lost and its more graceful.
I'm not saying there is no possible situation where crashing
is required, but its rare.

>
> Security requirements are heavily dependant on role and people sometimes
> forget that. Being down is bad news for an ecommerce site but in many
> other situations its infinite preferably to most other situations
>

Right.  Thats why such systems usually come clustered.  The panic()ed
system stays down until checked, but another system takes its role.
Still, military systems have to "think twice" before resorting to crash.
Remember that they're usually attacked just as war commences and all hell
breaks loose.  If your defense systems are too easy to DoS, you can't rely
on them and their secrecy won't help you.  In such cases an unreliable
system can be worse than no system at all.  If allies could DoS the Enigma
and force the Nazis to use their fallback system (which was kinda lame),
they wouldn't have to spend resources on cracking the Enigma.

