Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbUKVMEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbUKVMEI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 07:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbUKVMEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 07:04:07 -0500
Received: from marasystems.com ([83.241.133.2]:16574 "EHLO
	filer.marasystems.com") by vger.kernel.org with ESMTP
	id S262043AbUKVMEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 07:04:00 -0500
Date: Mon, 22 Nov 2004 13:03:23 +0100 (CET)
From: Henrik Nordstrom <hno@marasystems.com>
To: cranium2003 <cranium2003@yahoo.com>
cc: kernelnewbies@nl.linux.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: netfilter query
In-Reply-To: <20041121153354.99557.qmail@web41404.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0411221245470.20973@filer.marasystems.com>
References: <20041121153354.99557.qmail@web41404.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2004, cranium2003 wrote:

> Also,which headers are added when packet
> reaches to netfilter hook NF_IP_LOCAL_OUT? I found
> TCP/UDP/ICMP ,IP. Is that correct?

Yes.

netfilter is running at the IP layer and only reliably have access to IP 
headers and up. Lower level headers such as Ethernet MAC header is 
transport dependent and not always available, and certainly not available 
in NF_IP_LOCAL_OUT as it is not yet known the packet will be sent to an 
Ethernet.

In some netfilter hooks it is possible to rewind back to the Ethernet MAC 
header but one must be careful to verify that it really is an Ethernet 
packet one is looking at when doing this. Unfortunately there is no 
perfect solution how to detect this.. For an example of how one may try to 
look at the Ethernet MAC header see ipt_mac.c. But be warned that it is 
possible for non-Ethernet frames to pass the simple checks done there..

Regards
Henrik
