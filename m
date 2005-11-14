Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbVKNVPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbVKNVPl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbVKNVPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:15:40 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:29062 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932134AbVKNVPj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:15:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=q3MzKRTQkDg9lb+3eMMQdWRxXNay55LzbL0uykAQC+DsA85kXsfhhRjFvlcGhhY+P2zEtaCAASOKGq+Y6qNc4BpeYzLzaINLF1kSqWsqI0OGmhptKhMHjGg89D9NOxyiUF0ZPrgKONbuOJKLHUHf9qHnOgfXsR0jfwbea3tvbLY=
Message-ID: <9929d2390511141315t2fb15b2aucbbebcbe4cec7ef1@mail.gmail.com>
Date: Mon, 14 Nov 2005 13:15:38 -0800
From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, mpm@selenic.com
Subject: [BUG] netpoll is unable to handle skb's using packet split
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When using packet split, netpoll times out when doing a netdump.

Server logs:
--netdump[14973]: Got too many timeouts in handshaking, ignoring
client 172.0.2.250
--netdump[14973]: Got too many timeouts waiting for SHOW_STATUS for
client 172.0.2.250, rebooting it.

When packet split is not used, netpoll dumps correctly.  This was
reproduced using the initial setup:

HP DL380G3 (Server)
RHEL4 U1
7170 NIC
e1000 driver

HP DL380G4 (Client)
RHEL3 U5
7170 NIC
e1000 driver

We also tested using the latest RHEL4 U2 on the client, with the same results.

Netpoll does not appear to be able to handle skb's using packet split,
a possible resolution would be to test for packet split and to use
skb_linearize() in netpoll to resolve the issue.

--
Cheers,
Jeff
