Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266574AbUF3HTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266574AbUF3HTx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 03:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266578AbUF3HTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 03:19:52 -0400
Received: from mx1.elte.hu ([157.181.1.137]:26842 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266574AbUF3HTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 03:19:51 -0400
Date: Wed, 30 Jun 2004 09:19:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Norbert Preining <preining@logic.at>
Cc: Arjan van de Ven <arjanv@redhat.com>, EdHamrick@aol.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm2, mmaps rework, buggy apps, setarch
Message-ID: <20040630071953.GA21159@elte.hu>
References: <20040625082243.GA11515@gamma.logic.tuwien.ac.at> <20040625013508.70e6d689.akpm@osdl.org> <20040625103326.GA21814@gamma.logic.tuwien.ac.at> <20040625104449.GC20954@devserv.devel.redhat.com> <20040625082243.GA11515@gamma.logic.tuwien.ac.at> <20040625013508.70e6d689.akpm@osdl.org> <20040625103326.GA21814@gamma.logic.tuwien.ac.at> <20040625104317.GB20954@devserv.devel.redhat.com> <20040625204702.GA22859@gamma.logic.tuwien.ac.at> <20040630071035.GC28214@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040630071035.GC28214@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Norbert Preining <preining@logic.at> wrote:

> Hi All!
> 
> Just wanted to say that with 2.6.7-mm4 the problem is gone. I don't
> know which changes have been made to mm3/mm4 but now vuescan works
> again without any problem.

there was a bug in the first iteration of the flexible-mmap patch,
introduced during a cleanup of the patch. The bug resulted in the VM
throwing -ENOMEM's after the first ~3GB worth of mmap()s are done. So if
an app did lots of repeat mmap()/munmap()s [like vuescan most likely],
it would 'run out of memory' while there's still plenty of free VM left. 

This bug is fixed in the current flexible-mmap patch included in -mm4.

> Thanks a lot for your patience!

you are welcome!

	Ingo
