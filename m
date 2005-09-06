Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbVIFUX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbVIFUX6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 16:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbVIFUX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 16:23:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:30419 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750865AbVIFUX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 16:23:57 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org, Terrence.Miller@sun.com
Subject: Re: [discuss] [2.6 patch] include/asm-x86_64 "extern inline" -> "static inline"
Date: Tue, 6 Sep 2005 22:23:50 +0200
User-Agent: KMail/1.8
Cc: Jakub Jelinek <jakub@redhat.com>, Adrian Bunk <bunk@stusta.de>,
       Michael Matz <matz@suse.de>, linux-kernel@vger.kernel.org
References: <20050902203123.GT3657@stusta.de> <20050905184740.GF7403@devserv.devel.redhat.com> <431DD7BE.7060504@Sun.COM>
In-Reply-To: <431DD7BE.7060504@Sun.COM>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509062223.50747.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I don't think the functionality of having single copies in case 
an out of line version was needed was ever required by the Linux kernel.

extern inline was used in the kernel a long time ago as a "poor man's 
-Winline". Basically the intention was to get an linker error 
if the inlining didn't work for some reason because if we say
inline we mean inline.

But that's long obsolete because the requirements of the C++ "template is 
turing complete" people has broken inlining so badly (they want a lot of 
inlining, but not too much inlining because otherwise their compile times 
explode and the heuristics needed for making some of these pathologic cases 
work seems to break a lot of other sane code)  that the kernel was forced to 
define inline to __attribute__((always_inline)). And with that you get an 
error if inlining
fails. 

So the original purpose if extern inline is fulfilled by static inline now.
However extern inline also doesn't hurt, it really makes no difference now.

-Andi
 
