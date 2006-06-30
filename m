Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWF3Qpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWF3Qpq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 12:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWF3Qpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 12:45:46 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11954 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751167AbWF3Qpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 12:45:45 -0400
Subject: re: problem with new kernel
From: Arjan van de Ven <arjan@infradead.org>
To: eclark <eclark@alabanza.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200606301046.17526.eclark@alabanza.com>
References: <200606301046.17526.eclark@alabanza.com>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 18:45:38 +0200
Message-Id: <1151685938.11434.51.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-30 at 10:46 -0400, eclark wrote:
> Previous, I was using a RH stock kernel. This was rebuilt to be monolithic 
> with allthe required modules. However, now any binary which uses 
> set_thread_area segfaults. I know this is a kernel issue, as other kernels I 
> have used do not have this same issue. I am running 2.4.33-pre. Below is an 
> example strace of nslookup, one of the relevant binaries now segfaulting.
> Above the big strace (total strace of nslookup) is where I believe the problem 
> is coming from. Any help would be appreciated, as I have no clue what went 
> wrong with this kernel build.

Hi,

you're running a kernel without NPTL support on a distribution that
apparently expects NPTL support to be in the kernel... the failure mode
isn't nice but failure at all isn't totally unexpected...... NPTL is
needed for certain functionality and if a distribution expects that to
be there.. things may well go very wonky if absent. (yes glibc tries to
emulate this but the emulation is quite limited and not really possible)

One example of such thing is cross-process mutexes and other locks; NPTL
allows that (via futexes on shared pages), and things like rpm use this
extensively. Another example is thread local storage; emulation is
fragile via LDT's and such.

Greetings,
   Arjan van de Ven


