Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266609AbUHVJZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266609AbUHVJZL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 05:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266611AbUHVJZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 05:25:11 -0400
Received: from qfep05.superonline.com ([212.252.122.162]:16595 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S266609AbUHVJZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 05:25:04 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: "'Brad Campbell'" <brad@wasp.net.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
Date: Sun, 22 Aug 2004 12:25:06 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <41285DB3.6070605@wasp.net.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcSIJJ7wfQIqxlydS1qy90CZVF8lEQADNXAg
Message-Id: <S266609AbUHVJZE/20040822092504Z+202@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bad news... NAT does not work, but it should have worked. Where might be the
mistake ? I put another machine connected next to the patched linux server,
I sniff the traffic and see that:
(I enabled SNAT);

Packet arrives from 192.168.0.30 (new machine to test nat)
The packet is correctly translated and sent over the line
With the patch, the new packet seems to arrive from correct source 77.1

*But this is where the problem begins, the system does not send the received
packet to the address which is SNATted. I thought, the ip_input.c code would
work in the lowest level so IPTABLES would naively use the changed source
address...

I do not know if ever this problem will end... 


-----Original Message-----
From: Brad Campbell [mailto:brad@wasp.net.au] 
Sent: Sunday, August 22, 2004 10:48 AM
To: Josan Kadett
Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level

Josan Kadett wrote:
> This does actually change the source IP address of the machine and allow
> NAT??
> 
> Client A 192.168.0.20 -- connects to patched linux server
> Linux 192.168.1.1 -- translates the source address 192.168.x.x to
1.1(SNAT)
> 
> And will NAT actually work with this patch, as far as I see, this code
gets
> the saddr and puts another one when the condition matches?

No.. this should work for you.. Try it and see anyway.

Regards,
Brad




