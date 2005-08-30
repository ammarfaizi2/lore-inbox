Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbVH3WmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVH3WmE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 18:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVH3WmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 18:42:04 -0400
Received: from [62.206.217.67] ([62.206.217.67]:25239 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S932273AbVH3WmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 18:42:01 -0400
Message-ID: <4314E0BE.1050206@trash.net>
Date: Wed, 31 Aug 2005 00:42:06 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050803 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: mrash@enterasys.com
CC: linux-kernel@vger.kernel.org, Harald Welte <laforge@netfilter.org>
Subject: Re: ip_queue.c and TCP resets
References: <1125435703.7024.24.camel@isengard.cipherdyne.org>
In-Reply-To: <1125435703.7024.24.camel@isengard.cipherdyne.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Rash wrote:
> Attached is a patch against
> linux-2.6.11.12/net/ipv4/netfilter/ip_queue.c to put Ethernet MAC
> addresses directly into the indev_name and outdev_name portions of the
> ipq_packet_msg struct.  This is a total kludge and I doubt anyone else
> will find this useful, but for libipq IPS applications it allows TCP
> resets and other response traffic to be sent out of the appropriate
> physical ports when running as an Ethernet bridge.  I'm sure there are
> better ways to do this, but it seems to work.

ip_queue messages already include the source mac address in the hw_addr
field. The destination isn't included because except with bridge
netfilter it is always the local mac address. If you also need the
destination MAC we could consider including it in nfnetlink_queue
since its new and we don't have to worry about userspace compatibility
at this time.
