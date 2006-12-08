Return-Path: <linux-kernel-owner+w=401wt.eu-S1761212AbWLHVGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761212AbWLHVGe (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 16:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761213AbWLHVGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 16:06:34 -0500
Received: from ns2.suse.de ([195.135.220.15]:33491 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761211AbWLHVGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 16:06:33 -0500
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: proxy_pda was Re: What was in the x86 merge for .20
Date: Fri, 8 Dec 2006 22:06:20 +0100
User-Agent: KMail/1.9.5
Cc: Arkadiusz Miskiewicz <arekm@maven.pl>, linux-kernel@vger.kernel.org
References: <200612080401.25746.ak@suse.de> <200612081304.23230.arekm@maven.pl> <4579CC7F.1040203@goop.org>
In-Reply-To: <4579CC7F.1040203@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612082206.20409.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 December 2006 21:35, Jeremy Fitzhardinge wrote:
> Arkadiusz Miskiewicz wrote:
> >   LD      .tmp_vmlinux1
> > arch/i386/kernel/built-in.o: In function `math_emulate':
> > (.text+0x3809): undefined reference to `_proxy_pda'
> >   
> 
> Hm, in theory nothing should ever generate a reference to _proxy_pda. 
> What compiler are you using?

Looking at Arkadiusz' output file it looks like gcc 4.2 decided to CSE the
address :/

	movl	$_proxy_pda+8, %edx	#, tmp65

Very sad, but legitimate.

The only workaround I can think of would be to define it as a symbol
(or away in vmlinux.lds.S). Or do away with the idea of proxy_pda
again.

-Andi
