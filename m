Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286395AbSAMRCL>; Sun, 13 Jan 2002 12:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286403AbSAMRCB>; Sun, 13 Jan 2002 12:02:01 -0500
Received: from colorfullife.com ([216.156.138.34]:12807 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S286395AbSAMRBt>;
	Sun, 13 Jan 2002 12:01:49 -0500
Message-ID: <3C41BD74.28F6707A@colorfullife.com>
Date: Sun, 13 Jan 2002 18:01:40 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.2-pre11 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: cross-cpu balancing with the new scheduler
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible that the inter-cpu balancing is broken in 2.5.2-pre11?

eatcpu is a simple cpu hog ("for(;;);"). Dual CPU i386.

$nice -19 ./eatcpu&;
 <wait>
$nice -19 ./eatcpu&;
 <wait>
$./eatcpu&.

IMHO it should be
* both niced process run on one cpu.
* the non-niced process runs with a 100% timeslice.

But it's the other way around:
One niced process runs with 100%. The non-niced process with 50%, and
the second niced process with 50%.

--
	Manfred
