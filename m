Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbVJAPsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbVJAPsV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 11:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVJAPsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 11:48:21 -0400
Received: from sycorax.lbl.gov ([128.3.5.196]:16308 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S1750753AbVJAPsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 11:48:20 -0400
From: Alex Romosan <romosan@sycorax.lbl.gov>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing ifdef in mod_devicetable.h for 2.6.14-rc3
References: <873bnlb7oh.fsf@sycorax.lbl.gov>
	<1128179737.2916.6.camel@laptopd505.fenrus.org>
Date: Sat, 01 Oct 2005 08:48:14 -0700
In-Reply-To: <1128179737.2916.6.camel@laptopd505.fenrus.org> (message from
	Arjan van de Ven on Sat, 01 Oct 2005 17:15:36 +0200)
Message-ID: <87y85d9r29.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

> On Sat, 2005-10-01 at 08:03 -0700, Alex Romosan wrote:
>> this was introduced in rc1 and is still present in rc3. without the
>> patch below i can't compile alsa cvs.
>
>
> while our patch isn't wrong... makes me wonder if alsa cvs has a bug in
> their makefiles ...
>

well, it could be that their check is wrong:

AC_TRY_COMPILE([
#define __KERNEL__
#include <linux/config.h>
#include <linux/pci.h>
],[
        int (*func)();
        func = pci_set_consistent_dma_mask;
],
    AC_MSG_RESULT("yes");pci_consistent_defined="1",
    AC_MSG_RESULT("no");pci_consistent_defined="0",
    AC_MSG_RESULT("unknown");pci_consistent_defined="0"
)

notice the '#define __KERNEL__'. this gives:

/usr/src/linux/include/linux/mod_devicetable.h:186:15: error: #if with no expression

replacing the above with '#define __KERNEL__ 1' (there and in a
million other places where this happens) solves the problem.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
