Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbUDAFRz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 00:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUDAFRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 00:17:54 -0500
Received: from adelaide.maptek.com.au ([202.174.40.42]:61316 "EHLO
	mail.adelaide.maptek.com.au") by vger.kernel.org with ESMTP
	id S262143AbUDAFRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 00:17:53 -0500
Message-ID: <406BA62A.2090503@maptek.com.au>
Date: Thu, 01 Apr 2004 14:48:34 +0930
From: Malcolm Blaney <malcolm.blaney@maptek.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: mark_offset_tsc() hangs usb
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-5.3, required 5,
	BAYES_01 -5.40, TW_UH 0.08, USER_AGENT_MOZILLA_UA 0.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have been trying to fix a problem related to usb, with the help of the 
usb-dev list. Plugging in a usb device hangs my computer when bandwidth 
reclamation (fsbr) is turned on in the uhci-hcd driver.

I have found though, that when an interrupt is triggered by plugging in 
a usb device, the timer_interrupt() function in arch/i386/kernel/time.c 
is reached, and the computer hangs in mark_offset_tsc() in 
timers/timer_tsc.c. I removed the call to this function in 
timer_interrupt() and then usb worked as normal. I'm hoping there's a 
better way to get usb working than this though! This doesn't happen when 
fsbr is switched off.

The computer has a Crusoe TM5400 cpu and a VIA VT82C686A controller.

Thanks,
Malcolm.


