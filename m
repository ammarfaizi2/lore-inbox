Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbUK2SMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUK2SMF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 13:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbUK2SMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 13:12:05 -0500
Received: from zaphod.axian.com ([64.122.196.146]:64951 "EHLO zaphod.axian.com")
	by vger.kernel.org with ESMTP id S261443AbUK2SLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 13:11:50 -0500
Subject: odd behavior with r8169 and pcap
From: Terry Griffin <terryg@axian.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1101751909.2291.21.camel@tux.hq.axian.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 29 Nov 2004 10:11:49 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm seeing some very strange behavior with the r8169 driver
in 2.6.9. (Also observed in FC2's 2.6.5-1).

Throughput is generally dog slow, less than 100Mb/s. But if
I fire up any libpcap-based monitoring utility (ethereal,
iftop, etc) the throughput suddenly jumps an order of magnitude
to near 1Gb/s. As soon as I quit from the monitoring utility
the throughput drops back back to where it was before. This can
be repeated over an over.

I created a dummy libpcap monitoring program (below). This
is enough to trigger the behavior.

So the obvious questions are: Is this a known problem? Why the
heck does it do this? Is there a fix or workaround to get the
high rate all the time other than running a pcap utility 24x7?

Thanks,
Terry Griffin

-- dummy-monitor.c -----------------

#include <pcap.h>
#define CAPTURE_LENGTH 68

void null_handler(u_char *user, const struct pcap_pkthdr *pkt_header,
                  const u_char *pkt_data)
{
}

int main( int argc, char *argv[] )
{
    char *iface;
    pcap_t* pd;
    char errbuf[PCAP_ERRBUF_SIZE];

    if( argc == 1 )
        iface = "eth0";
    else
        iface = argv[1];

    pd = pcap_open_live(iface,CAPTURE_LENGTH,0,1000,errbuf);
    pcap_loop(pd,-1,(pcap_handler)null_handler,NULL);

    return 0;
}


