Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbUK2U2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbUK2U2e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 15:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbUK2U2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 15:28:34 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:664 "EHLO hibernia.jakma.org")
	by vger.kernel.org with ESMTP id S261784AbUK2U2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 15:28:14 -0500
Date: Mon, 29 Nov 2004 20:27:57 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@hibernia.jakma.org
To: Thomas Spatzier <thomas.spatzier@de.ibm.com>
cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [patch 4/10] s390: network driver.
In-Reply-To: <OF7E76C3BE.B1D182D3-ONC1256F5B.005B3E84-C1256F5B.005BB584@de.ibm.com>
Message-ID: <Pine.LNX.4.61.0411292007080.18143@hibernia.jakma.org>
References: <OF7E76C3BE.B1D182D3-ONC1256F5B.005B3E84-C1256F5B.005BB584@de.ibm.com>
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2004, Thomas Spatzier wrote:

> Yes, for the examples you mentioned the app should better be 
> notified. However, AFAICS, there are no such notification 
> mechanisms on a per-packet basis implemented in the kernel. And I 
> doubt that they are going to be implemented.

We do get notified. We get a netlink interface update with 
unset IFF_RUNNING from the interface flags.

However, it can take time before zebra gets to read it, and further 
time before zebra sends its own interface update to protocol daemons, 
and further time before they might get to read and update their own 
interface state. By which time those daemons may have sent packets 
down those interfaces (which packets may become invalid before link 
becomes back, but which still will be sent and hence which 
potentially could disrupt routing).

Ideally, we should be notified synchronously (EBUFS?) or if thats not 
possible, packet should be dropped (see my below presumption though).

The other solution is some means for a daemon to be able flush queues 
for a specific interface. (but thats a bit ugly).

> Good suggestion, if anyone has an interesting and feasible solution 
> I will be happy to integrate it. So far, however, it don't see one 
> and I would point people being worried about lost packets to TCP.

Surely TCP already was able to take care of retransmits? I'm not 
familiar with Linux internals, but how did TCP cope with the previous 
driver behaviour? (I get the vague impression that we're talking 
about a driver specific buffer here, rather than the applications 
socket buffer - is that correct?).

Jeff, David, enlighten us please! :)

> Regards,
> Thomas.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
I can't understand why people are frightened of new ideas.  I'm frightened
of the old ones.
 		-- John Cage
