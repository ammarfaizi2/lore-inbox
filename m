Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbULQPp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbULQPp2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 10:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbULQPp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 10:45:28 -0500
Received: from host-3.tebibyte16-2.demon.nl ([82.161.9.107]:24080 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S261326AbULQPpX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 10:45:23 -0500
Message-ID: <41C2FF09.5020005@tebibyte.org>
Date: Fri, 17 Dec 2004 16:45:13 +0100
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Eindhoven, The Netherlands)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Linux 2.6.9-ac16
References: <1103222616.21920.12.camel@localhost.localdomain> <41C2DA43.9070900@tebibyte.org> <41C2F273.6010707@nortelnetworks.com>
In-Reply-To: <41C2F273.6010707@nortelnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

Chris Friesen escreveu:
> As it stands, 2.6.10-rc2-mm4 still shows nasty behaviour in OOM
> conditions, killing off more tasks than strictly required, and
> locking up the system for 10-15secs while doing it.
> 
> I'd be much happier doing a quick and dirty scan and knocking off 
> something *now* rather than locking up the system.  Surely it can't
> take 60 billion cycles of cpu time to pick a task to kill.

Thomas Gleixner has been particularly interested the algorithms for 
deciding which task to kill (like me he got fed up with it picking the 
ssh daemon first).

See for example the thread at 
http://marc.theaimsgroup.com/?t=110189482200001&r=1&w=2

Some of the delay is by design: when OOM is reached we kill something 
off, wait a bit for the memory to be freed and become available to the 
system again, check whether now have enough memory, if not rinse and 
repeat. However, as I recall this is compounded by 2.6.9 having some 
nasty rentrancy problems causing the OOM killer to be called something 
like 100 times instead of once.

Perhaps Thomas could enlighten us as to the current state of play here?

Regards,
Chris R.

