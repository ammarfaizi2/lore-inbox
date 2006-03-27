Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWC0UDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWC0UDo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 15:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWC0UDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 15:03:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51928 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751118AbWC0UDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 15:03:43 -0500
Subject: Re: RFC - Approaches to user-space probes
From: Arjan van de Ven <arjan@infradead.org>
To: prasanna@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       davem@davemloft.net, suparna@in.ibm.com, richardj_moore@uk.ibm.com,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       "Theodore Ts'o" <tytso@mit.edu>, Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <20060327100019.GA30427@in.ibm.com>
References: <20060327065447.GA25745@in.ibm.com>
	 <1143445068.2886.20.camel@laptopd505.fenrus.org>
	 <20060327100019.GA30427@in.ibm.com>
Content-Type: text/plain
Date: Mon, 27 Mar 2006 22:03:14 +0200
Message-Id: <1143489794.2886.43.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-27 at 15:30 +0530, Prasanna S Panchamukhi wrote:
> On Mon, Mar 27, 2006 at 09:37:48AM +0200, Arjan van de Ven wrote:
> > On Mon, 2006-03-27 at 12:24 +0530, Prasanna S Panchamukhi wrote:
> > 
> > > - Low overhead and user can have thousands of active probes on the
> > >   system and detect any instance when the probe was hit including
> > >   probes on shared library etc.
> > 
> > I suspect this is the only reason for doing it inside the kernel;
> > anything else still really shouts "do it in userspace via ptrace" to me.
> > 
> 
> Other reasons would be:
> 
> - to view some privilaged data, such as system regs while you are
>   debugging in user-space

root can do that anyway afaics

> - to view many arbitrary process address-space that use a common set
>   of modules - user or kernel space

that's just a matter of userspace tooling.

> Yes, insertion of the breakpoint happens at the physical
> page level and it gets written back to the disc.

at which point you get to deal with tripwire and other intrusion
detection systems.... and you prevent doing this on binaries residing on
read-only mounts (which isn't as uncommon as it sounds, read only
shared /usr is quite common in enterprise)

