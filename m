Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262473AbVEMSfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbVEMSfU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 14:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbVEMSfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 14:35:20 -0400
Received: from nef2.ens.fr ([129.199.96.40]:3086 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S262473AbVEMSe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 14:34:57 -0400
Subject: Re: Hyper-Threading Vulnerability
From: Eric Rannaud <eric.rannaud@ens.fr>
To: Andi Kleen <ak@muc.de>
Cc: Gabor MICSKO <gmicsko@szintezis.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <m164xnatpt.fsf@muc.de>
References: <1115963481.1723.3.camel@alderaan.trey.hu>
	 <m164xnatpt.fsf@muc.de>
Content-Type: text/plain
Date: Fri, 13 May 2005 13:34:14 -0500
Message-Id: <1116009254.5914.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Fri, 13 May 2005 20:34:18 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-13 at 20:03 +0200, Andi Kleen wrote:
> This is not a kernel problem, but a user space problem. The fix 
> is to change the user space crypto code to need the same number of cache line
> accesses on all keys. 

Well, this might not be trivial in general, and as pointed out by Colin
Perceval, this would require a major rewrite of OpenSSL RSA key
generation procedure. He also notes that other applications, a priori
less sensible, might also be targeted. And obviously, it would be
impractical to ensure this property in all application code.


> Disabling HT for this would the totally wrong approach, like throwing
> out the baby with the bath water.

Colin also mentions another work-around, at the level of the scheduler:

"[...] action must be taken to ensure that no pair of threads execute
simultaneously on the same processor core if they have different
privileges. Due to the complexities of performing such privilege checks
correctly and based on the principle that security fixes should be
chosen in such a way as to minimize the potential for new bugs to be
introduced, we recommend that existing operating systems provide the
necessary avoidance of inappropriate co-scheduling by never scheduling
any two threads on the same core, i.e., by only scheduling threads on
the first thread associated with each processor core. The more complex
solution of allowing certain "blessed" pairs of threads to be scheduled
on the same processor core is best delayed until future operating
systems where it can be extensively tested. In light of the potential
for information to be leaked across context switches, especially via the
L2 and larger cache(s), we also recommend that operating systems provide
some mechanism for processes to request special "secure" treatment,
which would include flushing all caches upon a context switch. It is not
immediately clear whether it is possible to use the occupancy of the
cache across context switches as a side channel, but if an unprivileged
user can cause his code to pre-empt a cryptographic operation
(e.g., by operating with a higher scheduling priority and being
repeatedly woken up by another process), then there is certainly a
strong possibility of a side
channel existing even in the absence of Hyper-Threading."

Is that relevant to the Linux kernel?

  /er.
-- 
"Sleep, she is for the weak"
http://www.eleves.ens.fr/home/rannaud/

