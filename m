Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264795AbUEYH1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbUEYH1N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 03:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264796AbUEYH1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 03:27:13 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:25508 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S264795AbUEYH1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 03:27:00 -0400
To: Roland Dreier <roland@topspin.com>
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm5
References: <20040522013636.61efef73.akpm@osdl.org>
	<m165aorm70.fsf@ebiederm.dsl.xmission.com>
	<20040522180837.3d3cc8a9.akpm@osdl.org> <527jv4ymd4.fsf@topspin.com>
	<20040524161733.GX5414@waste.org>
	<m17jv1n4fk.fsf@ebiederm.dsl.xmission.com>
	<52brkdwwjh.fsf@topspin.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 May 2004 01:25:23 -0600
In-Reply-To: <52brkdwwjh.fsf@topspin.com>
Message-ID: <m13c5pm0ik.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <roland@topspin.com> writes:

>     Eric> If no hardware actually cared or someone could show me that
>     Eric> you can't generate a 64bit memory I/O cycle on the PCI bus
>     Eric> that would be interesting.  I have seen several drivers that
>     Eric> care.  Later today I intend to look at my pci docs and
>     Eric> confirm that 64bit I/O cycles do exist on the bus, even in
>     Eric> 32bit slots.  PCI bus traffic is packet based so I would be
>     Eric> strongly surprised if 64bit cycles did not exist.
> 
> Hang on -- how could you generate a 64-bit cycle on a 32-bit PCI bus?
> By definition a 32-bit PCI bus can only transfer 32 bits per cycle.
> 
> PCI Express traffic is packet based but parallel PCI definitely is not.

But parallel PCI is transaction based, which largely gives the same
effect as being packet based.  And you can have man data cycles for
every address cycle.  What I am not yet clear are the transaction splitting
rules.  My outstanding questions that I really need to track down are:

- Must a 64bit memory write transaction have the same effect as 2
  32bit write transactions?   

- Must a 64bit read transaction have the same effect as 2 32bit
  read transactions?

If true then it is impossible to implement the corresponding 64bit
atomic transaction on the PCI bus, and locks are required for
everyone's code.

The same questions can be asked of PCI-Express.

As soon as I managed to dig a copy of the protocol specifications
I will see if I can answer those questions.  

Eric

