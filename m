Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbTKRN7l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 08:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbTKRN7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 08:59:40 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:54764 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262770AbTKRN6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 08:58:13 -0500
Date: Tue, 18 Nov 2003 14:58:05 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, grof@dragon.cz,
       davem@redhat.com
Subject: Re: possible bug in tcp_input.c
Message-ID: <20031118135805.GA9705@louise.pinerecords.com>
References: <20031024162959.GB11154@louise.pinerecords.com.suse.lists.linux.kernel> <p73ptgma58b.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73ptgma58b.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct-24 2003, Fri, 19:57 +0200
Andi Kleen <ak@suse.de> wrote:

> > /* tcp_input.c, line 1138 */
> > static inline int tcp_head_timedout(struct sock *sk, struct tcp_opt *tp)
> > {
> >   return tp->packets_out && tcp_skb_timedout(tp, skb_peek(&sk->write_queue));
> > }
> 
> tp->packets_out > 0 implies that there is at least one packet in the write 
> queue (it counts the number of unacked packets in flight, which are kept
> in the write queue). When that's not the case something else is wrong.

Yes, that's exactly what davem said.  The corruption is happening somewhere
in netsched/imq code that's not even part of the official kernel tree (and
I'm told there's nobody to maintain the patch at present).

Thanks,
-- 
Tomas Szepe <szepe@pinerecords.com>

P.S.  I can post the patchset we've been using on the crashing machines
in case someone's interested, it's reasonably short:

      9101 Jul  6 11:48 bridge-nf-0.0.7-against-2.4.22pre3.diff.gz
      4123 Jul  6 11:14 imq-2.4.22pre3-1.diff.gz
      1883 Jul  6 12:01 imq-nf-20030625-2.4.22pre3.diff.gz
