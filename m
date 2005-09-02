Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbVIBFpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbVIBFpk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 01:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbVIBFpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 01:45:39 -0400
Received: from r-dd.iij4u.or.jp ([210.130.0.70]:5326 "EHLO r-dd.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S1751105AbVIBFpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 01:45:39 -0400
Date: Fri, 02 Sep 2005 14:45:37 +0900 (JST)
Message-Id: <20050902.144537.35010282.Noritoshi@Demizu.ORG>
From: Noritoshi Demizu <demizu@dd.iij4u.or.jp>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Ion Badulescu <lists@limebrokerage.com>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: Possible BUG in IPv4 TCP window handling, all recent
 2.4.x/2.6.x kernels
In-Reply-To: <20050901222032.5cc649c0@localhost.localdomain>
References: <Pine.LNX.4.61.0509011713240.6083@guppy.limebrokerage.com>
	<20050902.135138.38716488.Noritoshi@Demizu.ORG>
	<20050901222032.5cc649c0@localhost.localdomain>
X-Mailer: Mew version 4.1 on Emacs 21 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Since the TCP Window Scale options are exchanged,
> > the window size field contains shifted value except SYNs.
>
> Be careful, tcpdump may be tracking the window scale and reporting
> scaled values.  Seems unlikely since with a window scale of 2, and odd
> window size would be impossible.

I am sorry if tcpdump tracks the window scale option.  But I think it
is unlikely, because there are odd window sizes, as you pointed out.

By the way, if tcpdump does not track the window scale option, the right
edge (ack + real win) does not change between the following two ACKs.

> 11:34:54.337167 10.2.20.246.33060 > 10.2.224.182.8700: . ack 84402527 win 15340 <nop,nop,timestamp 226080473 99717814> (DF)
  (259 ACKs are omitted here)
> 11:34:54.611769 10.2.20.246.33060 > 10.2.224.182.8700: . ack 84454467 win 2355 <nop,nop,timestamp 226080721 99717841> (DF)

The first line is the 37th ACK and the second line is the 295th ACK.

  ACK#37:  ack=84402527 win=15340 right_edge=84463887 (= ack + win * 4)
  ACK#295: ack=84454467 win=2355  right_edge=84463887 (= ack + win * 4)

And all ACKs later than ACK#295 has win=2355 (2355*4=9420).

This may be a hint.  But, sorry, I do not know the internal of Linux TCP.

Regards,
Noritoshi Demizu
