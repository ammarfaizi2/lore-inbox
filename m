Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266003AbUFIV44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266003AbUFIV44 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 17:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266004AbUFIV44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 17:56:56 -0400
Received: from mout0.freenet.de ([194.97.50.131]:14828 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S266003AbUFIV4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 17:56:46 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: [PATCH] Add FUTEX_CMP_REQUEUE futex op
Date: Thu, 10 Jun 2004 00:08:20 +0200
User-Agent: KMail/1.6.2
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org
References: <mailman.1086629984.12568.linux-kernel2news@redhat.com> <20040609130406.7942507c@lembas.zaitcev.lan>
In-Reply-To: <20040609130406.7942507c@lembas.zaitcev.lan>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406100008.20692.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 June 2004 22:04, Pete Zaitcev wrote:

> Is it just me, or this could he above stand a use of STACK_FRAME_OVERHEAD
> instead of 160? I envision a time when Ulrich Weigand comes out with
> a gcc -fkernel, and at that time we'll need all such references
> configurable.

It wouldn't hurt, but even if we get -mkernel support in gcc, that doesn't 
mean that the stack frame size has to change: You can easily have %r15
point to 160 bytes above the register save area without actually using all 
that space for saving registers. The only thing that would need to change is 
the location of the backchain pointer.

> Why not to place the necessary word outside of the struct?
> It just logically doesn't belong. Might be just as easy to
> do that mvc to other place.

That actually was what Martin tried in his first implementation (well, the 
last one before the one he submitted). It didn't work out because some code 
relied on the stack starting right after pt_regs. Martin can probably clarify 
that on Friday.

	Arnd <><
