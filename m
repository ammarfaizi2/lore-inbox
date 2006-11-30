Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967970AbWK3XIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967970AbWK3XIA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 18:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967969AbWK3XIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 18:08:00 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:974 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S967970AbWK3XH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 18:07:59 -0500
Date: Thu, 30 Nov 2006 15:08:11 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, bugme-daemon@bugzilla.kernel.org,
       linux-kernel@vger.kernel.org, mjw99@ic.ac.uk
Subject: Re: [Bugme-new] [Bug 7602] New: Failure on compilation:
 include/asm/bitops.h:122: error: inconsistent operand constraints in an
 `asm' in nfs_access_add_cache()
Message-Id: <20061130150811.0a7851b0.randy.dunlap@oracle.com>
In-Reply-To: <200611302349.12261.ak@suse.de>
References: <200611302118.kAULIrxS011661@fire-2.osdl.org>
	<200611302322.00167.ak@suse.de>
	<20061130143246.4a4bb970.akpm@osdl.org>
	<200611302349.12261.ak@suse.de>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 23:49:12 +0100 Andi Kleen wrote:

> On Thursday 30 November 2006 23:32, Andrew Morton wrote:
> > On Thu, 30 Nov 2006 23:22:00 +0100
> > Andi Kleen <ak@suse.de> wrote:
> > 
> > > > 
> > > > static __inline__ int __test_and_set_bit(int nr, volatile void * addr)
> > > > {
> > > > 	int oldbit;
> > > > 
> > > > 	__asm__(
> > > > 		"btsl %2,%1\n\tsbbl %0,%0"
> > > > 		:"=r" (oldbit),"+m" (ADDR)
> > > > 		:"dIr" (nr));
> > > > 	return oldbit;
> > > > }
> > > > 
> > > > explodes with gcc-3.4.4.
> > > 
> > > Known issue.  The new form is correct and needed, but the old gcc doesn't accept
> > > it. I haven't gotten a form that is both and correct and works on the old compiler
> > > out of the gcc hackers I asked.
> > 
> > Oh, thanks.
> > 
> > What does "d" do, btw?  My gcc info page only covers "x86" and says only "`d' register"
> 
> Hmm, normally edx (aka Extended D register eXtended :) or rdx 
> 
> But you're right it doesn't make sense here because 'd' is already included in 'r'.
> Probably should be dropped.
> 
> > 
> > (And, more importantly, where is the best description of gcc asm constraints?)
> 
> Either info pages or gcc source. There was also a web page somewhere with a tutorial,
> but i don't think it was a full reference.

e.g. (may be ix86 instead of x86_64):

http://gcc.gnu.org/onlinedocs/gcc-4.1.1/gcc/Constraints.html#Constraints

http://www-128.ibm.com/developerworks/linux/library/l-ia.html

http://www.uwsg.indiana.edu/hypermail/linux/kernel/9804.2/0953.html

---
~Randy
