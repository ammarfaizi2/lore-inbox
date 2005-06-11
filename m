Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVFKIxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVFKIxu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 04:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVFKIxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 04:53:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:47065 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261216AbVFKIQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 04:16:57 -0400
Date: Sat, 11 Jun 2005 10:10:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050611081036.GA16392@elte.hu>
References: <20050608112801.GA31084@elte.hu> <42A8B390.2060400@stud.feec.vutbr.cz> <20050611073208.GA8279@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050611073208.GA8279@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > The attached patch fixes seems to fix it for me. It is against 
> > V0.7.48-05.
> 
> thanks, applied - but this does not end all of the reschedule problems 
> that the latest patches have. More on that later.

one problem was that the WORK_MASK definitions in thread_info.h were not 
updated - neither the word-sized tests in entry.S. This meant we missed 
delayed-preemption on return-from-kernel. But we've got one free bit in 
the first by - bit 6, so i moved the DELAYED bit there. Another bug was 
that the idle thread did not check for delayed preemption. I fixed these 
in the -48-07 patch.

	Ingo
