Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264058AbUFBU26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbUFBU26 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 16:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264026AbUFBU26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 16:28:58 -0400
Received: from ip67-93-141-190.z141-93-67.customer.algx.net ([67.93.141.190]:32565
	"EHLO datapower.ducksong.com") by vger.kernel.org with ESMTP
	id S264085AbUFBUZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 16:25:16 -0400
Subject: Re: TCP retransmission : how to detect from an application ?
From: patrick mcmanus <mcmanus@ducksong.com>
To: rol@as2917.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200406021257.i52CvEX31840@tag.witbe.net>
References: <200406021257.i52CvEX31840@tag.witbe.net>
Content-Type: text/plain
Message-Id: <1086207911.11413.18.camel@mcmanus.datapower.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 02 Jun 2004 16:25:12 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-02 at 08:57, Paul Rolland wrote:
> corrected by the kernel (hell, TCP is reliable, isn't it :-), but I'd like
> to know if an application can detect this (well, I don't want to be notified
> of a packet loss once detected, but I'd like to get some stats before
> closing
> the connection).

#include <linux/tcp.h>

struct tcp_info info;

getsockopt (... TCP_INFO ... &info ...);

and you get all of this (you'll have to see net/ipv4/tcp.c to see how it
all gets filled in.. I'm not aware of better documentation than that):

struct tcp_info
{
    __u8    tcpi_state;
    __u8    tcpi_ca_state;
    __u8    tcpi_retransmits;
    __u8    tcpi_probes;
    __u8    tcpi_backoff;
    __u8    tcpi_options;
    __u8    tcpi_snd_wscale : 4, tcpi_rcv_wscale : 4;

    __u32   tcpi_rto;
    __u32   tcpi_ato;
    __u32   tcpi_snd_mss;
    __u32   tcpi_rcv_mss;

    __u32   tcpi_unacked;
    __u32   tcpi_sacked;
    __u32   tcpi_lost;
    __u32   tcpi_retrans;
    __u32   tcpi_fackets;

    /* Times. */
    __u32   tcpi_last_data_sent;
    __u32   tcpi_last_ack_sent;     /* Not remembered, sorry. */
    __u32   tcpi_last_data_recv;
    __u32   tcpi_last_ack_recv;

    /* Metrics. */
    __u32   tcpi_pmtu;
    __u32   tcpi_rcv_ssthresh;
    __u32   tcpi_rtt;
    __u32   tcpi_rttvar;
    __u32   tcpi_snd_ssthresh;
    __u32   tcpi_snd_cwnd;
    __u32   tcpi_advmss;
    __u32   tcpi_reordering;
};


