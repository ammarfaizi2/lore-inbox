Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbWJ1P6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWJ1P6N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 11:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWJ1P6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 11:58:13 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:34444 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1750946AbWJ1P6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 11:58:13 -0400
X-Originating-Ip: 72.57.81.197
Date: Sat, 28 Oct 2006 11:56:24 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: why "probe_kernel_address()", not "probe_user_address()"?
Message-ID: <Pine.LNX.4.64.0610281153180.2091@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  it seems odd that the purpose of the "probe_kernel_address()" macro
is, in fact, to probe a *user* address (from linux/uaccess.h):

#define probe_kernel_address(addr, retval)              \
        ({                                              \
                long ret;                               \
                                                        \
                inc_preempt_count();                    \
                ret = __get_user(retval, addr);         \
                dec_preempt_count();                    \
                ret;                                    \
        })

  given that that routine is referenced only 5 places in the entire
source tree, wouldn't it be more meaningful to use a more appropriate
name?

pedantically yours,
rday
