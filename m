Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVDWQKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVDWQKP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 12:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVDWQKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 12:10:15 -0400
Received: from one.firstfloor.org ([213.235.205.2]:45020 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261525AbVDWQKL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 12:10:11 -0400
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
Subject: Re: [PATCH] i386 & x86_64: Live Patching Funcion on 2.6.11.7
References: <4261DC62.1070300@lab.ntt.co.jp>
	<20050416234439.5464e188.davem@davemloft.net>
From: Andi Kleen <ak@muc.de>
Date: Sat, 23 Apr 2005 18:10:09 +0200
In-Reply-To: <20050416234439.5464e188.davem@davemloft.net> (David S.
 Miller's message of "Sat, 16 Apr 2005 23:44:39 -0700")
Message-ID: <m13bthzd7i.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> writes:

> Takashi-san, have you ever investigated using kprobes to
> implement this feature?  It seems a perfect fit, and would
> allow support on several architectures other than just x86
> and x86_64.
>
> If kprobes does not meet your needs completely, it could
> be trivially extended to do so.

kprobes would require an exception for each patchpoint because
it uses an trap instruction. 

Probably a bit too costly for commonly used functions. Especially
on a P4 exceptions are quite costly. 

But you could add lightweight kprobes that just use jmp 
for it in the kprobes  framework, that might be useful for other stuff too

-Andi
