Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315374AbSGQQlv>; Wed, 17 Jul 2002 12:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315416AbSGQQlv>; Wed, 17 Jul 2002 12:41:51 -0400
Received: from cs180154.pp.htv.fi ([213.243.180.154]:54427 "EHLO
	devil.pp.htv.fi") by vger.kernel.org with ESMTP id <S315374AbSGQQlu>;
	Wed, 17 Jul 2002 12:41:50 -0400
Subject: Re: Is TCP CA_LOSS to CA_RECOVERY possible
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
To: spy9599 <spy9599@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020717161834.12994.qmail@web14806.mail.yahoo.com>
References: <20020717161834.12994.qmail@web14806.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 17 Jul 2002 19:44:47 +0300
Message-Id: <1026924287.4779.21.camel@devil>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-17 at 19:18, spy9599 wrote:
> In the present TCP (2.5.x) implementation, the TCP
> sender never exits TCP_CA_Loss state until all packets
> upto high_seq are acknowledged. But lets say while
> doing retransmissions, some packet less than high_seq
> are lost again. Ideally the TCP sender should just
> enter fast retransmit and fast recovery, but from the
> present implementation it seems the only way to come
> out of it is after a timeout. 
> 
> Could somebody explain this to me please.

The only reliable way to detect that a retransmitted segment has been
lost is timeout. You can't use dupacks, because at this point they are
not necessarily caused by lost retransmissions. They might be caused by
duplicates, delayed packets, or the acks themselves might be delayed.
You could end up with shrinking the congestion window unnecessarily or
just plain bad retransmission behaviour. Note that if SACK is enabled,
the transmitter will not retransmit too many unnecessary segments
anyway.

	MikaL

