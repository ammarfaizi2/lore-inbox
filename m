Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262571AbVF2NJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbVF2NJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 09:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbVF2NJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 09:09:28 -0400
Received: from mx1.elte.hu ([157.181.1.137]:28349 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262571AbVF2NJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 09:09:24 -0400
Date: Wed, 29 Jun 2005 15:09:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: eliad lubovsky <eliadl@013.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Handle kernel page faults using task gate
Message-ID: <20050629130901.GA29776@elte.hu>
References: <1119997135.4074.106.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119997135.4074.106.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* eliad lubovsky <eliadl@013.net> wrote:

> I am trying to handle page faults exceptions in the kernel using the 
> task gate mechanism. I succeeded to transfer the execution to my page 
> fault handler using a new TSS and updates to the GDT and IDT tables 
> (similar to the double fault mechanism in 2.6). After handling the 
> fault and allocating the physical page I use the iret instruction to 
> switch back to the previous task. The problem is that I got a double 
> fault with the same address that cause the fault (although the 
> physical page is allocated and mapped). Any clues?

are you clearing the 'nested task' (NT) flag of the new TSS once you 
have switched to it?

	Ingo
