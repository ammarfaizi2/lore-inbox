Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262168AbRFMNei>; Wed, 13 Jun 2001 09:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262389AbRFMNe2>; Wed, 13 Jun 2001 09:34:28 -0400
Received: from jalon.able.es ([212.97.163.2]:29943 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S262168AbRFMNeY>;
	Wed, 13 Jun 2001 09:34:24 -0400
Date: Wed, 13 Jun 2001 15:35:28 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Kurt Garloff <garloff@suse.de>
Cc: ognen@gene.pbi.nrc.ca, Christoph Hellwig <hch@ns.caldera.de>,
        linux-kernel@vger.kernel.org
Subject: Re: threading question
Message-ID: <20010613153528.A1711@werewolf.able.es>
In-Reply-To: <200106121858.f5CIwmX05650@ns.caldera.de> <Pine.LNX.4.30.0106121304320.24593-100000@gene.pbi.nrc.ca> <20010613142026.B13623@garloff.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010613142026.B13623@garloff.etpnet.phys.tue.nl>; from garloff@suse.de on Wed, Jun 13, 2001 at 14:20:26 +0200
X-Mailer: Balsa 1.1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010613 Kurt Garloff wrote:
> 
> What I do in my numerics code to avoid this problem, is to create all the
> threads (as many as there are CPUs) on program startup and have then wait
> (block) for a condition. As soon as there's something to to, variables for
> the thread are setup (protected by a mutex) and the thread gets signalled
> (cond_signal).
> If you're interested in the code, tell me.
> 

I use the reverse approach. you feed work to the threads, I create the threads
and let them ask for work to a master until it says 'done'. When the
master is queried for work, it locks a mutex, decide the next work for
that thread, and unlocks it. I think it gives the lesser contention and
is simpler to manage.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac13 #1 SMP Sun Jun 10 21:42:28 CEST 2001 i686
