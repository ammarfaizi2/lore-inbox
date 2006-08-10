Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422677AbWHJSOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422677AbWHJSOh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 14:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422686AbWHJSOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 14:14:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7821 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422684AbWHJSOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 14:14:37 -0400
Date: Thu, 10 Aug 2006 11:14:33 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Network compatibility and performance
Message-ID: <20060810111433.476a74d6@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.61.0608101339310.4577@chaos.analogic.com>
References: <Pine.LNX.4.61.0608101131530.4239@chaos.analogic.com>
	<20060810102841.55efa78a@localhost.localdomain>
	<Pine.LNX.4.61.0608101339310.4577@chaos.analogic.com>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 14:09:34 -0400
"linux-os \(Dick Johnson\)" <linux-os@analogic.com> wrote:

> 
> On Thu, 10 Aug 2006, Stephen Hemminger wrote:
> 
> > On Thu, 10 Aug 2006 11:34:23 -0400
> > "linux-os \(Dick Johnson\)" <linux-os@analogic.com> wrote:
> >
> >>
> >> Hello,
> >>
> >> Network throughput is seriously defective with linux-2.6.16.24
> >> if the length given to 'write()' is a large number.
> >>
> >> Given this code on a connected socket........
> >
> > What protocol (TCP?) and what Ethernet hardware (does it support TSO)?
> > Did you set non-blocking?
> 
> A connected TCP socket. The Ethernet hardware was also
> described (Intel using e1000 as shown) It's on PCI-X 133MHz, two
> devices on the motherboard, not really relevent because it worked
> previously as described. TSO? 

TSO = TCP segmentation Offload, if you are using e1000 it gets enabled.
Only slightly relevant to this, because it would change the timing.

> They went away in 1972. The socket was set to non-blocking because the
> same socket is used for reading (not at the same time), using poll()
> to find when data are supposed to be available. BTW, read() code
> used to use poll() to find out when data were available, but if
> poll returned POLLIN, sometimes data would NOT be available and
> the code would hang <forever>. Therefore a work-around was to set
> the socket non-blocking. Under the conditions where poll() would
> return POLLIN and a read of a non-blocking socket returned no data,

Basic unix programming, errno only has meaning if system call returns -1.

Basic network programming. If read returns 0 it means other side
has disconnected.
