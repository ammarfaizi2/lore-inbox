Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbUDSWuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbUDSWuT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 18:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUDSWuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 18:50:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9411 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262112AbUDSWuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 18:50:12 -0400
Date: Mon, 19 Apr 2004 18:49:40 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: akpm@osdl.org, drepper@redhat.com, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-user signal pending and message queue limits
Message-ID: <20040419224940.GY31589@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20040419212810.GB10956@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040419212810.GB10956@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 06:28:10PM -0300, Marcelo Tosatti wrote:
> Andrew, 
> 
> Here goes the signal pending & POSIX mqueue's per-uid limit patch. 
> 
> Initialization has been moved to include/asm-i386/resource.h, as you suggested.
> 
> The global mqueue limit has been increased to 256 (64 per user), and the global 
> signal pending limit to 4096 (1024 per user).
> 
> This has been well tested.
> 
> If you are OK with it for inclusion (-mm) I'll generate the arch-dependant
> changes for the other architectures.
> 
> Comments are welcome.

I wonder if it is a good idea to base mqueue limitation on the number of
message queues and not take into account how big they are.
64 message queues with 1 byte msgsize and 1 maxmsg is certainly quite
harmless and the system could have even more queues for such a user,
while 64 message queues with 16K msgsize (current default) and 40 maxmsg
(also default) eats ~ 40M of kernel memory.

	Jakub
