Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbVFUIyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVFUIyq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVFUIP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:15:59 -0400
Received: from soufre.accelance.net ([213.162.48.15]:41420 "EHLO
	soufre.accelance.net") by vger.kernel.org with ESMTP
	id S261663AbVFUHWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 03:22:20 -0400
Message-ID: <42B7C02B.4050801@xenomai.org>
Date: Tue, 21 Jun 2005 09:22:19 +0200
From: Philippe Gerum <rpm@xenomai.org>
Organization: Xenomai
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dwalker@mvista.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] I-pipe: x86 port
References: <42B35B0F.1000302@xenomai.org> <1119304726.32310.19.camel@dhcp153.mvista.com>
In-Reply-To: <1119304726.32310.19.camel@dhcp153.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> On Sat, 2005-06-18 at 01:21 +0200, Philippe Gerum wrote:
> 
> 
>>+#define local_save_flags(x)	((x) = __ipipe_test_root())
>>+#define local_irq_save(x)	((x) = __ipipe_test_and_stall_root())
>>+#define local_irq_restore(x)	__ipipe_restore_root(x)
>>+#define local_irq_disable()	__ipipe_stall_root()
>>+#define local_irq_enable()	__ipipe_unstall_root()
>>+
>>+#define irqs_disabled()		__ipipe_test_root()
> 
> 
> 
> If you want to integrate with newer RT patches , (I'm not sure which one
> this is on) ..

This patch only inherits the basic conditionals for integrating with 
PREEMPT_RT from a recent Adeos combo experimenting the issue w/ 
0.7.44-03, but there is indeed more to do for completing the integration 
with recent PREEMPT_RT patches.

  You could modify the above so that it uses the soft irq's
> off flags  . So if linux is in a soft irq disable than it's equal to a
> stall on the ipipe ..
> 

Ack. I will provide a newer combo patch using PREEMPT_RT's virtualized 
local_irq_disable for the root domain. Thanks for the hint.

-- 

Philippe.
