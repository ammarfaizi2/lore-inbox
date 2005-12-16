Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbVLPImx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbVLPImx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 03:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVLPImw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 03:42:52 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:63927 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S932189AbVLPImv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 03:42:51 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
To: "David S. Miller" <davem@davemloft.net>, dlstevens@us.ibm.com,
       shemminger@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org,
       mpm@selenic.com, netdev@vger.kernel.org, netdev-owner@vger.kernel.org,
       sri@us.ibm.com
Reply-To: 7eggert@gmx.de
Date: Fri, 16 Dec 2005 09:35:20 +0100
References: <5jUjW-8nu-7@gated-at.bofh.it> <5jWYp-3K1-19@gated-at.bofh.it> <5jXhZ-4kj-19@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EnB3h-0005DP-CW@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller <davem@davemloft.net> wrote:

> The idea to mark, for example, IPSEC key management daemon's sockets
> as critical is flawed, because the key management daemon could hit a
> swap page over the iSCSI device.  Don't even start with the idea to
> lock the IPSEC key management daemon into ram with mlock().

How are you going to swap in the key manager if you need the key manager
for doing this?


However, I'd prefer a system where you can't dirty mor than (e.g.) 80 % of
RAM unless you need this to maintain vital system activity and not more
than 95 % unless it will help to get more clean RAM. (Like the priority
inheritance suggestion from this thread.) I suppose this to least
significantly reduce thrashing and give a very good chance of recovering
from memory pressure. Off cause the implementation won't be easy,
especially if userspace applications need to inherit priority from
different code paths, but in theory, it can be done.

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
