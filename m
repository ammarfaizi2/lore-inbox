Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbULNWsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbULNWsr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 17:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbULNWqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:46:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:43146 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261709AbULNWo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:44:56 -0500
Date: Tue, 14 Dec 2004 14:44:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ulrich Drepper <drepper@redhat.com>
cc: Roland McGrath <roland@redhat.com>, Christoph Lameter <clameter@sgi.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] cpu-timers: high-resolution CPU clocks for POSIX
 clock_* syscalls
In-Reply-To: <41BF6879.3090900@redhat.com>
Message-ID: <Pine.LNX.4.58.0412141441080.3279@ppc970.osdl.org>
References: <200412142150.iBELoJc0011582@magilla.sf.frob.com>
 <Pine.LNX.4.58.0412141410150.3279@ppc970.osdl.org> <41BF6879.3090900@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Dec 2004, Ulrich Drepper wrote:
> 
> Indeed.  It's so much easier to grant additional rights at a later time 
> than to take something away for whatever reasons.

Yes.

> Globally accessible clocks would need to have the semantic carefully 
> defined, SELinux hooks would have to be added etc.

More interestingly (where "interesting" is defined as "could be really 
nasty") it's likely to interact very badly in cases where we have some 
_physically_ local clocks. Ie we might have some situation where we do 
some node-local thing for intra-node scheduling, with some other clock for 
inter-node scheduling. Exposing such a clock to a process that isn't 
actually using it could result in the node-local clock source suddenly 
needing to be exposed outside the node.

Think single-image clusters etc.

So in general, it's better to try to keep things as local as possible, 
even if it's not a visibility issue today. Some day you might be happy you 
did..

		Linus
