Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbVFWJdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbVFWJdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 05:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbVFWI2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:28:21 -0400
Received: from mx2.elte.hu ([157.181.151.9]:53932 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262657AbVFWH45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 03:56:57 -0400
Date: Thu, 23 Jun 2005 09:56:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050623075601.GA23320@elte.hu>
References: <20050608112801.GA31084@elte.hu> <42B0F72D.5040405@cybsft.com> <20050616072935.GB19772@elte.hu> <42B160F5.9060208@cybsft.com> <20050616173247.GA32552@elte.hu> <Pine.LNX.4.58.0506171139570.32721@echo.lysdexia.org> <Pine.LNX.4.58.0506171419050.786@echo.lysdexia.org> <20050618122805.GA32041@elte.hu> <Pine.LNX.4.58.0506221848480.23287@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506221848480.23287@echo.lysdexia.org>
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


* William Weston <weston@sysex.net> wrote:

> Hi Ingo,
> 
> I just found this oops from last night on my home audio/midi system 
> (AthlonXP running -48-37).  I was burning a CD at the time, and the 
> scsi error precedes the oops trace by 46 seconds.  The system is still 
> up and fully functional, BTW.

Found the bug and it should be fixed in -50-16 and later kernels. I had 
debugging code that called into print_IO_APIC() (when you had an scsi 
interrupt timeout), but that function was an __init call - so the kernel 
called into an already freed code area.

	Ingo
