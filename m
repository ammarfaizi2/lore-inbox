Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWFTTI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWFTTI7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 15:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWFTTI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 15:08:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:12210 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750738AbWFTTI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 15:08:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oBcIt1jGi1i9I70d2ZeCUSo6SbNWh3mvUT1IXe9ukz9J5oXf1E+NuHcP4zM1bXfn+fVOpNCFn/gwiojkjI/TWBvzjIZ+p/6dNr96f8JlGYVFD9DM4IcSSR7I8lRxrXdA4HKX36tBBDb3FRBe0hqkcOBoKSoIW80Jef4MW+Me3Fs=
Message-ID: <642640090606201208g31a0a57bm268910b026ccd335@mail.gmail.com>
Date: Tue, 20 Jun 2006 13:08:56 -0600
From: "Ryan McAvoy" <ryan.sed@gmail.com>
To: linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: realtime-preempt for MIPS - compile problem with rwsem
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have been trying to get the realtime-preempt patches working on a
MIPs processor with the 2.6.15 (and subsequently the 2.6.16) kernel.

One problem I am having is as follows:

- The mips configuration specifically disables
CONFIG_RWSEM_GENERIC_SPINLOCK when CONFIG_PREEMPT_RT is on
- This causes the include/asm-mips/rwsem.h to be included by
include/linux/rwsem.h.
- include/asm-mips/rwsem.h calls rwsem_down_read_failed which is
implemented in lib/rwsem.c
- rwsem.c is only compiled if CONFIG_RWSEM_XCHGADD_ALGORITHM is on.
This option is also disabled if CONFIG_PREEMPT_RT is on.

To summarise, if CONFIG_PREEMPT_RT is on, then the mips specific
rwsem.h is included, but at the same time, it prevents inclusion of
lib/rwsem.c which is needed by the mips rwsem.h.

Does anyone have a solution to this.
Thanks,
Ryan McAvoy
