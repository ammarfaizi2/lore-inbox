Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUCWKma (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 05:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUCWKm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 05:42:29 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:21143 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262425AbUCWKmY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 05:42:24 -0500
Date: Tue, 23 Mar 2004 11:42:23 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>, Robert_Hentosh@Dell.com,
       fleury@cs.auc.dk, linux-kernel@vger.kernel.org
Subject: RE: spurious 8259A interrupt
In-Reply-To: <Pine.LNX.4.44.0403222354280.1902-100000@poirot.grange>
Message-ID: <Pine.LNX.4.55.0403231132170.16819@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.44.0403222354280.1902-100000@poirot.grange>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2004, Guennadi Liakhovetski wrote:

> Yes, I saw this your explanation. Thanks again. But, I am not getting
> those errors with local APIC disabled. That's why I thought "local APIC ->

 Is the local APIC normally disabled, i.e. do you see a message like: 
"Local APIC disabled by BIOS -- reenabling." when you boot with your local 
APIC enabled?  That might explain the difference.

> timer -> spurious interrupts." Maybe I am wrong. But I also can't see how
> enabling the lapic can cause, e.g., power supply glitches to become
> visible. I would be happy and grateful to hear an explanation.

 I don't know what setup you are useing, but depending on the
implementation, the local APIC may treat ExtINTA interrupts as
level-triggered or as edge-triggered.  The latter setup is a design error
in my opinion (the 8259A has a level-triggered output) and may lead to
what you observe.  As the local APIC latches edge-triggered interrupts it 
receives (unlike the 8259A) a glitch on an interrupt line does not have to 
last long enough for a CPU to accept it for a spurious interrupt to be 
recorded.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
