Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264851AbUFHIB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264851AbUFHIB7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 04:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264888AbUFHIB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 04:01:59 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:12205 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S264851AbUFHIBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 04:01:55 -0400
Message-ID: <40C572C8.20B13640@nospam.org>
Date: Tue, 08 Jun 2004 10:03:20 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@bull.net
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Who owns those locks ?
References: <40A1F4BE.4A298352@nospam.org> <200406031139.58964.bjorn.helgaas@hp.com> <40C42E4B.15F1E605@nospam.org> <200406070906.54132.bjorn.helgaas@hp.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas wrote:
> 
> There are a couple issues I was thinking of when
> I wrote "clean it up, pull the bits together...":
> 
>         1) Tony Luck's question about what happens when
>            "shr.u r30 = r13, 12" yields zero in the 32-bit
>            lock value.  I'm not the 2.6 maintainer, but I'd
>            sure like to see some solution for this.  It would
>            be a nightmare to debug a system where one random
>            task didn't release locks correctly.  Since other
>            arches use a trick like this, I'm hoping they've
>            figured out something we can copy (I haven't looked).

Sure, I did not want to make an error like saying:
"640 K ought to be enough for everyone".

I'm afraid, there is no perfect solution.

- We do not want to change the lock size to 64 bits, do we ?
  -- Couple of new alignment problems.

- You keep my code, it is correct for a memory size up to 16 Tbytes.

- You shift by PAGE_SHIFT, rather than by 12 (using page size of
  16 Kbytes) => up to  64 Tbytes.
  -- Not that much human readable lock values.

- You move to PAGE_SIZE = 64 K, you get human readable lock values
  up to 256 Tbytes.

- You could store the "PID | miraculous bit" (to avoid PID = 0
  problem).
  -- Somewhat longer code.

I expect the main stream IA64 kernel to move to PAGE_SIZE = 64 K by
the time there will be machines with more than 16 Tbytes of memory
(as the processors have got just a very limited number of
translation look aside buffer entries, and the ever growing
application / memory sizes result in higher TLB miss rate unless the
page size increases).


Regards,

Zoltán
