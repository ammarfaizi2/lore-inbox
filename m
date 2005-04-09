Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVDIVxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVDIVxg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 17:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVDIVxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 17:53:36 -0400
Received: from pat.uio.no ([129.240.130.16]:49905 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261391AbVDIVxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 17:53:34 -0400
Subject: Re: bdflush/rpciod high CPU utilization, profile does not make
	sense
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: Greg Banks <gnb@sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050409213549.GW347@unthought.net>
References: <20050406160123.GH347@unthought.net>
	 <20050406231906.GA4473@sgi.com> <20050407153848.GN347@unthought.net>
	 <1112890671.10366.44.camel@lade.trondhjem.org>
	 <20050409213549.GW347@unthought.net>
Content-Type: text/plain
Date: Sat, 09 Apr 2005 17:52:32 -0400
Message-Id: <1113083552.11982.17.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.537, required 12,
	autolearn=disabled, AWL 1.41, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lau den 09.04.2005 Klokka 23:35 (+0200) skreiv Jakob Oestergaard:

> 2.6.11.6: (dual PIII 1GHz, 2G RAM, Intel e1000)
> 
>          File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
>   Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
> ------- ------ ------- --- ----------- ----------- ----------- -----------
>    .     2000   4096    1  38.34 18.8% 19.61 6.77% 22.53 23.4% 6.947 15.6%
>    .     2000   4096    2  52.82 29.0% 24.42 9.37% 24.20 27.0% 7.755 16.7%
>    .     2000   4096    4  62.48 34.8% 33.65 17.0% 24.73 27.6% 8.027 15.4%
> 
> 
> 44MiB/sec for 2.4 versus 22MiB/sec for 2.6 - any suggestions as to how
> this could be improved?

What happened to the retransmission rates when you changed to TCP?

Note that on TCP (besides bumping the value for timeo) I would also
recommend using a full 32k r/wsize instead of 4k (if the network is of
decent quality, I'd recommend 32k for UDP too).

The other tweak you can apply for TCP is to bump the value
for /proc/sys/sunrpc/tcp_slot_table_entries. That will allow you to have
several more RPC requests in flight (although that will also tie up more
threads on the server).

Don't forget that you need to unmount then mount again after making
these changes (-oremount won't suffice).

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

