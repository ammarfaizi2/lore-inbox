Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317799AbSGKJWy>; Thu, 11 Jul 2002 05:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317801AbSGKJWx>; Thu, 11 Jul 2002 05:22:53 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:64212 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S317799AbSGKJWw> convert rfc822-to-8bit; Thu, 11 Jul 2002 05:22:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: O(1) scheduler "complex" macros
Date: Thu, 11 Jul 2002 11:25:26 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@linuxia64.org>
References: <Pine.LNX.4.44.0207111151200.7858-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0207111151200.7858-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207111125.26599.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

the last fix survived one night of testing with included udelay(100), so
I would consider it stable. Thanks again!

The performance with the new "complex" macros is as expected worse than
with the simple ones, we see 10% in some cases, which is hurting a lot.
Would you please consider moving the location of the switch_lock from
the end of the task_struct to the hot area near the scheduler related
variables? The effect may vary depending on the cache line size but
having it behind *array or sleep_timestamp would probably save us a cache
miss here.

Regards,
Erich

