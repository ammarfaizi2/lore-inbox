Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVHAVtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVHAVtx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVHAVMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:12:50 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:56612 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261276AbVHAVLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:11:51 -0400
Message-ID: <42EE9014.7080205@lanl.gov>
Date: Mon, 01 Aug 2005 15:11:48 -0600
From: Josip Loncaric <josip@lanl.gov>
Organization: LANL
User-Agent: Mozilla Thunderbird 1.0.6 (Macintosh/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Time conversion error in linux-2.6.11.10/net/sunrpoc/svcsock.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Line 589 of linux-2.6.11.10/net/sunrpc/svcsock.c is obviously wrong:

                 skb->stamp.tv_usec = xtime.tv_nsec * 1000;

To convert nsec to usec, one should divide instead of multiplying:

                 skb->stamp.tv_usec = xtime.tv_nsec / 1000;

The same bug could be present in the latest kernels, although I haven't 
checked.  This bug makes svc_udp_recvfrom() timestamps incorrect.

Sincerely,
Josip


