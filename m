Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262786AbUJ1FSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262786AbUJ1FSH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 01:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbUJ1FSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 01:18:06 -0400
Received: from smtp3.akamai.com ([63.116.109.25]:44182 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S262786AbUJ1FOr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 01:14:47 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: rcv_wnd = init_cwnd*mss
Date: Wed, 27 Oct 2004 22:14:33 -0700
Message-ID: <DB2C167D8FFDEA45B8FC0B1B75E3EE154A3B07@usca1ex-priv1.sanmateo.corp.akamai.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: rcv_wnd = init_cwnd*mss
Thread-Index: AcS8rM7hUF59s+QmQiiGoDvV2MwyDw==
From: "Meda, Prasanna" <pmeda@akamai.com>
To: <linux-kernel@vger.kernel.org>
Cc: <netdev@oss.sgi.com>, <davem@redhat.com>
X-OriginalArrivalTime: 28 Oct 2004 05:14:33.0611 (UTC) FILETIME=[02D53DB0:01C4BCAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What is the reason for checking mss with 1<<rcv_wscale?
include/net/tcp.h:
static inline void tcp_select_initial_window(int __space, __u32 mss,
        __u32 *rcv_wnd,
        __u32 *window_clamp,
        int wscale_ok,
        __u8 *rcv_wscale)
{
.....
        /* Set initial window to value enough for senders,
         * following RFC1414. Senders, not following this RFC,
         * will be satisfied with 2.
         */
        if (mss > (1<<*rcv_wscale)) {
                int init_cwnd = 4;
                if (mss > 1460*3)
                        init_cwnd = 2;
                else if (mss > 1460)
                        init_cwnd = 3;
                if (*rcv_wnd > init_cwnd*mss)
                        *rcv_wnd = init_cwnd*mss;
        }
 ......
}
---------
Perhaps the motivation was checking for
     if (mss >  rcv_wnd * (1<<*rcv_wscale)) {



Thanks,
Prasanna.
