Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274936AbTHFIxH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 04:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274939AbTHFIxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 04:53:07 -0400
Received: from smtp01.web.de ([217.72.192.180]:56594 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S274936AbTHFIxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 04:53:04 -0400
From: Mathias =?utf-8?q?Fr=C3=B6hlich?= <Mathias.Froehlich@web.de>
To: johnstul@us.ibm.com
Subject: Re: [RFC][PATCH] linux-2.6.0-test2_mtrr-race-fix_A0
Date: Wed, 6 Aug 2003 10:52:18 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200308061052.18550.Mathias.Froehlich@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

You should not remove the barrier past mtrr change. If you do that, it is 
possible that cpu's run with inconsistent mtrrs. This can have bad 
sideeffects since at least the cache snooping protocol used by intel uses 
assumptions about the cachability of memory regions. Those information about 
the cachability is also taken from the mtrrs as far as I remember.
This intel cpu developer manual, which documented the early PII and PPro 
chips, recommended this algorithm. Since actual intel cpus use the same old 
cpu to chipset bus protocol, this old documentation most propably still 
applies.

So the conclusion is that as far as you don't know the exact way all those SMP 
protocols between chipsets and CPUs with all the possible sideeffects very 
well, dont't change this behavour.

But I'm shure that fixes to the stack allocated variable problem are welcome 
:)

   Greetings

      Mathias Fröhlich

-- 
Mathias Fröhlich, email: Mathias.Froehlich@web.de
old email was: frohlich@na.uni-tuebingen.de

