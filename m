Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbTE2QT5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 12:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbTE2QT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 12:19:57 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:39079 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262361AbTE2QTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 12:19:55 -0400
Message-Id: <200305291632.h4TGWwsG022510@ginger.cmf.nrl.navy.mil>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] assorted he driver cleanup 
In-reply-to: Your message of "Thu, 29 May 2003 13:21:26 -0300."
             <20030529162125.GU24054@conectiva.com.br> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Thu, 29 May 2003 12:31:17 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-1.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030529162125.GU24054@conectiva.com.br>,Arnaldo Carvalho de Melo w
rites:
>> @@ -189,7 +187,7 @@
>>  #define HE_SPIN_LOCK(dev, flags)	spin_lock_irqsave(&(dev)->global_lock, 
>flags)
>>  #define HE_SPIN_UNLOCK(dev, flags)	spin_unlock_irqrestore(&(dev)->global_l
>ock, flags)
>
>Is the above really needed?

well, according to the programmer's guide:

8.1.7   PCI Transaction Ordering Error

PROBLEM: The PCI Bus Controller, in addition to bus master and general
target functionality, acts as a bridge to a local bus. If a read is
issued to the local bus and the read COMPLETES on the local bus but is
not yet completed on the PCI bus, a subsequent write to the local bus
that completes on the PCI bus will cause the write data to be written
to the last local bus read address.

RESOLUTION: In an environment where PCI bus bridge settings cannot be
controlled, card drivers must lock read and write access to the ATM
Network Controller and the SONET Framer device. In an environment where
PCI bus bridge settings can be controlled, features that allow reordering
of reads and writes from separate processors (i.e., Posted memory write
features) should be disabled.
