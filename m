Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263874AbRFLX7R>; Tue, 12 Jun 2001 19:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263881AbRFLX7H>; Tue, 12 Jun 2001 19:59:07 -0400
Received: from jalon.able.es ([212.97.163.2]:29149 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S263874AbRFLX6y>;
	Tue, 12 Jun 2001 19:58:54 -0400
Date: Wed, 13 Jun 2001 01:48:01 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: "Albert D . Cahalan" <acahalan@cs.uml.edu>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        Christoph Hellwig <hch@ns.caldera.de>, linux-kernel@vger.kernel.org,
        ognen@gene.pbi.nrc.ca
Subject: Re: threading question
Message-ID: <20010613014801.A17093@werewolf.able.es>
In-Reply-To: <XFMail.20010612144449.davidel@xmailserver.org> <200106122158.f5CLwTR253610@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200106122158.f5CLwTR253610@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Tue, Jun 12, 2001 at 23:58:29 +0200
X-Mailer: Balsa 1.1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010612 Albert D. Cahalan wrote:
> 
> In that case, this could be a hardware issue. Note that he seems
> to be comparing an x86 PC against SGI MIPS, Sun SPARC, and Compaq
> Alpha hardware.
> 
> His data set is most likely huge. It's DNA data.
> 
> The x86 box likely has small caches, a fast core, and a slow bus.
> So most of the time the CPU will be stalled waiting for a memory
> operation.
> 

Perhaps is just synchronization of caches. 
say you want to sum all the elements of a vector in parallele split in
two pieces:

int total=0;
thread 1:
	for fist half
		total += v[i]
thread 2:
	for second half
		total += v[i]

and you tought: 'well, I need a mutex for access to total. that will slow
down things, lets use separate counters':

int bigtotal;
int total[2];
thread 1:
	for fist half
		total[0] += v[i]
thread 2:
	for second half
		total[1] += v[i]

bigtotal = total[0]+total[1]

The problem ? total[0] and total[1] are nearby one of each other. So in
the same cache line. So on every write to total[?], even if they are
independent, system has to synchrnize caches.

Big iron (SGI, Sparc), has special hardware, but cheap PC mobos...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac13 #1 SMP Sun Jun 10 21:42:28 CEST 2001 i686
