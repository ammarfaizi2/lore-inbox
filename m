Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268079AbUHVT20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268079AbUHVT20 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 15:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268078AbUHVT2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 15:28:25 -0400
Received: from qfep05.superonline.com ([212.252.122.162]:24982 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S268076AbUHVT2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 15:28:13 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: "'Brad Campbell'" <brad@wasp.net.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
Date: Sun, 22 Aug 2004 22:28:10 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
In-Reply-To: <41289C0B.7010805@wasp.net.au>
Thread-Index: AcSIScfXEOY9i3vERdyWNWPRKXO4cAAPCXWg
Message-Id: <S268076AbUHVT2N/20040822192813Z+185@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have found the exact reason why NAT does not work;

- The patched linux box ignores IP checksum errors
- Since now the source address is mofidified without checksumming, NAT also
carries that wrong checksum
- Other boxes does not ignore the checksum and drop packets

I think the solution is here, I have done many different modifications to
get the system redirect packets with wrong checksum. Now all to be done, is
to correct this checksum by changing some code in ip_input.c so that it
recalculates the checksum when the packets seem to arrive from 192.168.1.1. 

Where in the code then?

-----Original Message-----
From: Brad Campbell [mailto:brad@wasp.net.au] 
Sent: Sunday, August 22, 2004 3:14 PM
To: Josan Kadett
Cc: linux-kernel@vger.kernel.org
Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level

Are you trying to ping 192.168.77.1 from 192.168.0.30?

Can you give me an iptables -L -n -t nat, ifconfig and route -n from the
patched box and also route 
-n and ifconfig from the dummy client at 192.168.0.30 so I can try and get a
handle on what you are 
doing and how it all is supposed to work?




