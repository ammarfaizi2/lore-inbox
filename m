Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269418AbRGaSvV>; Tue, 31 Jul 2001 14:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269414AbRGaSvL>; Tue, 31 Jul 2001 14:51:11 -0400
Received: from [62.116.8.197] ([62.116.8.197]:53124 "HELO
	ghanima.endorphin.org") by vger.kernel.org with SMTP
	id <S269424AbRGaSu6>; Tue, 31 Jul 2001 14:50:58 -0400
Date: Tue, 31 Jul 2001 20:51:01 +0200
From: clemens <therapy@endorphin.org>
To: kuznet@ms2.inr.ac.ru
Cc: Pekka Savola <pekkas@netcore.fi>, therapy@endorphin.org,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: missing icmp errors for udp packets
Message-ID: <20010731205101.B8211@ghanima.endorphin.org>
In-Reply-To: <200107311833.WAA09598@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107311833.WAA09598@ms2.inr.ac.ru>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 31, 2001 at 10:33:56PM +0400, kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > If you reboot the computer, the _first_ ping/scan attempt will not return
> > icmp dest unreachable.
> Hmm... how fast after reboot?

your patch will not prevent the first ping to empty the token bucket,
because burst is still 0, which is larger than dst->rate_token, and since
XRLIM_BURST_FACTOR times the timeout (which is 6*0=0 in that case) is the
token maximum, it will be truncated to 0, causing the following packets (if
in time) to be dropped.

clemens


