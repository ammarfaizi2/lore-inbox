Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265325AbUAFVCh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 16:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265334AbUAFVCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 16:02:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12307 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S265325AbUAFVCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 16:02:36 -0500
Message-ID: <3FFB223A.8000606@zytor.com>
Date: Tue, 06 Jan 2004 13:01:46 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Mike Waychison <Michael.Waychison@Sun.COM>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       autofs mailing list <autofs@linux.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
References: <3FFB12AD.6010000@sun.com>
In-Reply-To: <3FFB12AD.6010000@sun.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Waychison wrote:
> 
> The attached paper was written an attempt to design an automount system
> with complete Solaris-style autofs functionality.  This includes
> browsing, direct maps and lazy mounting of multimounts.  The paper can
> also be found online at:
>                                                                               

Sorry to sound like sour grapes, but this is a requirements document,
not a proposed implementation.  Furthermore, as I have expressed before,
I think your claim that expiry should be done in the VFS to be incorrect.

I think you're on the completely wrong track, because you're starting
with the wrong problem.  The implementation needs to start with the VFS
implementation and derive from that.

Finally, throwing out the daemon is a huge step backwards.  Most of the
problems with autofs v3 (and to a lesser extent v4) are due to the
*lack* of state in userspace (the current daemon is mostly stateless);
putting additional state in userspace would be a benefit in my experience.

Pardon me for sounding harsh, but I'm seriously sick of the oft-repeated
idiocy that effectively boils down to "the daemon can die and would lose
its state, so let's put it all in the kernel."  A dead daemon is a
painful recovery, admitted.  It is also a THIS SHOULD NOT HAPPEN
condition.  By cramming it into the kernel, you're in fact making the
system less stable, not more, because the kernel being tainted with
faulty code is a total system malfunction; a crashed userspace daemon is
"merely" a messy cleanup.  In practice, the autofs daemon does not die
unless a careless system administrator kills it.  It is a non-problem.

	-hpa

