Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbVLQVoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbVLQVoN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 16:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbVLQVoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 16:44:13 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62732 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964980AbVLQVoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 16:44:12 -0500
Date: Sat, 17 Dec 2005 21:44:02 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       mingo@redhat.com, akpm@osdl.org
Subject: Re: [PATCH 1/12]: MUTEX: Implement mutexes
Message-ID: <20051217214401.GB31551@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	David Howells <dhowells@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@osdl.org
References: <Pine.LNX.4.64.0512162334440.3698@g5.osdl.org> <dhowells1134774786@warthog.cambridge.redhat.com> <200512162313.jBGND7g4019623@warthog.cambridge.redhat.com> <1134791914.13138.167.camel@localhost.localdomain> <14917.1134847311@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0512171201200.3698@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512171201200.3698@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2005 at 12:11:39PM -0800, Linus Torvalds wrote:
> Of the other architectures you list, only ARM is really important. And no, 
> arm doesn't do swap. It does LL/SC (except they call it "ldrex/strex", 
> which I assume stands for "load/store with reservation and X just because 
> X is cool. Yeah, we're cool" (*)).

> (*) Actually, some arm docs I found implies that "ex" stands for 
> "exclusive", but that leaves me wondering what the "r" stands for? 

FYI.  The standard instructions:

ldr = load register
str = store register

The new (ARM architecture v6 and above) atomic instructions:

ldrex = load register exclusive
strex = store register exclusive

Previous architecture versions only have the 32-bit and 8 bit
unconditional swap instructions.  Luckily they're unlikely to be
used for SMP in the field.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
