Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266347AbUGPOCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266347AbUGPOCF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 10:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266349AbUGPOCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 10:02:05 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:42371 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S266347AbUGPOCC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 10:02:02 -0400
X-Qmail-Scanner-Mail-From: solt@dns.toxicfilms.tv via dns
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner: 1.22 (Clear:RC:0(150.254.37.14):SA:0(0.2/5.0):. Processed in 4.381219 secs)
Date: Fri, 16 Jul 2004 16:01:57 +0200
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Mailer: SecureBat! Lite (v2.10.02) UNREG / CD5BF9353B3B7091
Reply-To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <1408328554.20040716160157@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: Re[3]: tcp_window_scaling degrades performance
In-Reply-To: <505216170.20040716122132@dns.toxicfilms.tv>
References: <2igbK-82L-13@gated-at.bofh.it>
 <m3zn615exj.fsf@averell.firstfloor.org>
 <505216170.20040716122132@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AK>> It's pretty easy for you to find out. Do a tcpdump -v or ethereal -v
AK>> from both the side of a host you download from and from the linux side.
AK>> Then compare all packets. If they don't match the firewall is 
AK>> doing something bad. Especially check window values and TCP options
AK>> in the SYN packets
MS> I will do that for sure, but preliminary investigation shows that
MS> this behaviour does not show with 2.6.7 and earlier, but appears for sure in
MS> 2.6.7-bk13 (Haven't tried earlier bk snapshots)
I seem to have isolated the changeset that causes my machines to have
very slow throughput, even as low as 2kB/s when tcp_window_scaling is
enabled.

http://linux.bkbits.net:8080/linux-2.6/cset@1.1757.1.25?nav=index.html|ChangeSet@-3w
[TCP]: TCP acts like it is always out of memory.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: David S. Miller <davem@redhat.com>

Stephen, David, could you review this changeset, figure out possible
causes or suggest more methods for me to analyse this problem ?

Note that I am not saying that window_scaling is badly implemented,
but it just seems related.

Regards,
Maciej


