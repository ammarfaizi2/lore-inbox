Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWG3PUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWG3PUm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 11:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWG3PUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 11:20:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:8615 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932332AbWG3PUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 11:20:41 -0400
Subject: Re: FP in kernelspace
From: Arjan van de Ven <arjan@infradead.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Avi Kivity <avi@argo.co.il>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <44CCCB74.9010605@gmail.com>
References: <44CC97A4.8050207@gmail.com>  <44CCC4CA.6000208@argo.co.il>
	 <1154271283.2941.27.camel@laptopd505.fenrus.org>
	 <44CCCB74.9010605@gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 30 Jul 2006 17:20:38 +0200
Message-Id: <1154272838.2941.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-30 at 17:08 +0159, Jiri Slaby wrote:
> Arjan van de Ven wrote:
> >>> So 2 questions are:
> >>> 1) howto FP in kernel
> >>>
> >> kernel_fpu_begin();
> >> c = d * 3.14;
> >> kernel_fpu_end();
> 
> Yup, I know about this possibility, but this is only x86 specific?!
> 
> > unfortunately this only works for MMX not for real fpu (due to exception
> > handling uglies)
> 
> concludes it's not multiplatform at all... For that reasen I (maybe) want some 
> "protocol" for communication with US, where I can easily compute it.]

easiest might be a shared mmap ring buffer (well 2 of these actually),
kernel puts data in buffer, updates ring pointer (and wakes userspace if
needed). Userspace notices data in ring, does math, puts data back in
the 2nd ringbuffer and updates that ring pointer. Then maybe does a
syscall to 'wake' the kernel. Kernel then sees data in the 2nd
ringbuffer and gets it. In addition to the wakeups I mentioned you can
also poll for the buffers; the wakeups are just there for extra safety.


