Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUCKMxa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 07:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUCKMxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 07:53:30 -0500
Received: from mailgate.uni-paderborn.de ([131.234.22.32]:59073 "EHLO
	mailgate.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S261236AbUCKMx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 07:53:27 -0500
Message-ID: <40506F54.7070001@uni-paderborn.de>
Date: Thu, 11 Mar 2004 14:53:24 +0100
From: Bjoern Schmidt <lucky21@uni-paderborn.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: [BUG] Re: fsb of older cpu
References: <A6974D8E5F98D511BB910002A50A6647615F47CB@hdsmsx402.hd.intel.com>	 <1078815523.2342.535.camel@dhcppc4>  <404DA7A8.4090109@uni-paderborn.de> <1078892273.2347.551.camel@dhcppc4>
In-Reply-To: <1078892273.2347.551.camel@dhcppc4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-UNI-PB_FAK-EIM-MailScanner-Information: Please see http://imap.uni-paderborn.de for details
X-UNI-PB_FAK-EIM-MailScanner: Found to be clean
X-UNI-PB_FAK-EIM-MailScanner-SpamCheck: not spam, SpamAssassin (score=1.594,
	required 4, FROM_ENDS_IN_NUMS 0.87, RCVD_IN_NJABL 0.10,
	RCVD_IN_NJABL_DIALUP 0.53, RCVD_IN_SORBS 0.10)
X-UNI-PB_FAK-EIM-MailScanner-SpamScore: s
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Len,

i think that the fadt of my laptop is buggy, but i am not
sure. The fadt tells a C2 latency of 100 and a C3 latency
of 300. C3 is disabled in drivers/acpi/processor.c because
type-f DMA is set.

C2 is enabled and seems to be used, but has no effects on pm.
Thottling seems to have no effects too. The temperature of
the cpu rises fast until one of the active or S-state
trip-points is reached, in the worst case the systems
goes to S5.

Now i have set the C2 valid flag statically to "0" in the
sources (driver/acpi/processor.c).
cat /proc/acpi/processor/.../info tells that pm is not supported
anymore, and throttling seems to work now. The temperature
of the cpu settled down to the aimed trip-point of 58 dC.

Can you comfirm that this behaviour is a result of a buggy
fadt, or could it be that there is a bug in the kernels acpi?

Do you know if a PII Deschutes is C2 capable? In the acpi
specification i can see that the programming model for c2
state is "Fixed Hardware Control Logic" which is integrated
into the external chipset. Is the chipset the only
dependency for c2-state, or is the processor a dependency too?
I think so, of course, but its not clearly enough for me...


Greetings
Bjoern Schmidt


