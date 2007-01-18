Return-Path: <linux-kernel-owner+w=401wt.eu-S1752026AbXAROLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbXAROLG (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 09:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752029AbXAROLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 09:11:06 -0500
Received: from gateway1.seskion.de ([62.8.128.82]:20649 "EHLO
	gateway1.seskion.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbXAROLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 09:11:05 -0500
X-Greylist: delayed 1606 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jan 2007 09:11:04 EST
Message-ID: <45AF79AE.1060102@seskion.de>
Date: Thu, 18 Jan 2007 14:44:14 +0100
From: Juergen Pfeiffer <j.pfeiffer@seskion.de>
Organization: SesKion Softwareentwicklung und System Konzeption GmbH
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: long disable of Softirqs in br_forward_delay_timer_expired()
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I had problems in my implementation of Profibus-protocol, because my 
FDL-State machine is implemented in tasklets and
sometimes there were situations, where Soft-Irqs were disabled for 
20-40mS (Coldfire 5485 / 96MHz).
After inserting some testpoints in kernels source, doing dump_stack(), 
when the jiffie-time get longer then 20mS,
i detected the place of the long Soft-Irq disable in function

static void br_forward_delay_timer_expired(..)
inside file "net/bridge/br_stp_timer.c"

It does a
spin_lock_bh(..);
... some functionality;
spin_unlock_bh(..);

Does anybody know, why the functionality inbetween lock/unlock takes so long
(2-4 jiffies @ HZ=100)


Thank You

Juergen Pfeiffer,
Seskion GmbH
Karlsruher Str. 11/1
70771 Leinfelden-Echterdingen
Germany

j.pfeiffer@seskion.de

www.seskion.de

