Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130350AbRCBIRk>; Fri, 2 Mar 2001 03:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130351AbRCBIRb>; Fri, 2 Mar 2001 03:17:31 -0500
Received: from smtpde03.sap-ag.de ([194.39.131.54]:21425 "EHLO
	smtpde03.sap-ag.de") by vger.kernel.org with ESMTP
	id <S130350AbRCBIRU>; Fri, 2 Mar 2001 03:17:20 -0500
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel is unstable
In-Reply-To: <20010301153935.G32484@athlon.random>
	<E14YXh5-0008GQ-00@the-village.bc.nu>
	<20010301193017.E15051@athlon.random>
	<97m6ue$7uu$1@penguin.transmeta.com>
From: Christoph Rohland <cr@sap.com>
Date: 02 Mar 2001 09:23:21 +0100
In-Reply-To: <97m6ue$7uu$1@penguin.transmeta.com>
Message-ID: <m31ysgy3ye.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 1 Mar 2001, Linus Torvalds wrote:
> Note how do_brk() does the merging itself (see the comment "Can we
> just expand an old anonymous mapping?"), and that it's basically
> free when done that way, with no worries about locking etc. The same
> could be done fairly trivially in mmap too, but I never saw any real
> usage patterns that made it look all that worthwhile (*). Handling
> the mmap case the same way do_brk() does it would fix the behaviour
> of this pathological example too..

Oh there is at least one application, which does trigger the merging
quite often: SAP R/3. We have a big memory area which is handled in 1M
blocks which get mmaped/munmapped/mprotected all the time. This now
leads to a really big avl tree which before has been much smaller.

I am not sure that the merging is a gain since it in itself is a
overhead and we work on fixed blocks. I simply wanted to point out
that there are applications out there which trigger it.

Greetings
		Christoph

