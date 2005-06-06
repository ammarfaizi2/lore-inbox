Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVFFOK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVFFOK0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 10:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVFFOK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 10:10:26 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:44400 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261436AbVFFOKU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 10:10:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IDqoUQKTeBCwTkxrK8nUvKh+HrdJqSALRtq1N/OBcrv6d8kGkD0K7WF1z+jWMf5Xp9BJ14WAxL7hCUf2yfpMwOeBgVyJWlpy/ybUsL8+9hS5rHgzG+6GNtqywXNdjUYMhKX+q2mi5GXtEmr8HWf5fXHSYDFvbnpP+SO2B7BGVdo=
Message-ID: <75052be705060607106a6c0882@mail.gmail.com>
Date: Mon, 6 Jun 2005 22:10:17 +0800
From: Skywind <gnuwind@gmail.com>
Reply-To: Skywind <gnuwind@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Is kernel 2.6.11 adjust tcp_max_syn_backlog incorrectly?
In-Reply-To: <75052be7050606070691c302d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <75052be7050606070691c302d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is kernel 2.6.11 adjust tcp_max_syn_backlog incorrectly?

Test Backgroud:
CPU: Intel P4
Mem: 512Mb
The /etc/sysctl.conf and other haven't touch anything.

I found a strange question: when I use kernel 2.6.11, the value of
/proc/sys/net/ipv4/tcp_max_syn_backlog is 256,
while kernel 2.6.10 on same computer the value is 1024.

So I check the net/ipv4/[tcp.c, tcp_ipv4.c] and know when Mem >= 256Mb
the tcp_max_syn_backlog will be set to 1024,
but it is 256 in my test above.

Some other variables that should be adjust all together with
tcp_max_syn_backlog are:
ip_local_port_range
tcp_max_tw_buckets
tcp_max_orphans
But they don't be adjust to correctly value(refer to net/ipv4/tcp.c) all.

It seems that kernel don't adjust these value automatic, is this a bug?

I guess the mechanism of tcp.c in 2.6.11 have some changes(between
2.6.10), and it conduce to this result,
Is this guess correctly?



Xu Gang (Skywind)
2005/06/06
