Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131229AbQLMMXF>; Wed, 13 Dec 2000 07:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131253AbQLMMW4>; Wed, 13 Dec 2000 07:22:56 -0500
Received: from 4dyn46.com21.casema.net ([212.64.95.46]:4110 "HELO home.ds9a.nl")
	by vger.kernel.org with SMTP id <S131229AbQLMMWj>;
	Wed, 13 Dec 2000 07:22:39 -0500
Date: Wed, 13 Dec 2000 12:52:10 +0100
From: Jasper Spaans <jasper@spaans.ds9a.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] raid5 crash with 2.4.0-test12 [Was: Linux-2.4.0-test12]
Message-ID: <20001213125209.A851@spaans.ds9a.nl>
In-Reply-To: <14902.49167.834682.925490@notabene.cse.unsw.edu.au> <Pine.LNX.4.10.10012121900380.22326-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012121900380.22326-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Dec 12, 2000 at 07:08:09PM -0800
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2000 C. Jasper Spaans - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2000 at 07:08:09PM -0800, Linus Torvalds wrote:

> > The following patch disabled that code.
> 
> If this fix makes the oops go away, then the proper fix for the problem is
> not the #if 0, but do add something like

Well, this fix did make the oops go away, but it also caused another scary
oops -- not sure whether my stack trace is in any way how it should be, but
it oopses in nfsd, and has a stacktrace as follows:

>>EIP; c01e379e <ip_frag_queue+20a/254>   <=====
Trace; c01e3b80 <ip_defrag+dc/17c>
Trace; d1121502 <[ip_conntrack]ip_ct_gather_frags+2e/ac>
Trace; c01e65ec <output_maybe_reroute+0/14>
Trace; d1120c49 <[ip_conntrack]ip_conntrack_in+39/2cc>
Trace; c01e65ec <output_maybe_reroute+0/14>
Trace; d11223aa <[ip_conntrack]ip_conntrack_local+5a/60>
Trace; c01e65ec <output_maybe_reroute+0/14>
Trace; c01d4e08 <nf_iterate+34/88>
Trace; c01e65ec <output_maybe_reroute+0/14>
Trace; c01e65ec <output_maybe_reroute+0/14>
Trace; c01d5087 <nf_hook_slow+3f/b8>
Trace; c01e65ec <output_maybe_reroute+0/14>
Trace; d11235e8 <[ip_conntrack]ip_conntrack_local_out_ops+0/18>
Trace; c01e5b8b <ip_build_xmit_slow+3cf/4ac>
Trace; c01e65ec <output_maybe_reroute+0/14>
Trace; c01fb748 <udp_getfrag+0/c4>
Trace; c01e5cb6 <ip_build_xmit+4e/334>
Trace; c01fb748 <udp_getfrag+0/c4>
Trace; ea00000a <END_OF_CODE+18edc8c0/????>
Trace; c01e14fb <ip_route_output_key+113/120>
Trace; c01fbbde <udp_sendmsg+38a/414>
Trace; c01fb748 <udp_getfrag+0/c4>
Trace; ea00000a <END_OF_CODE+18edc8c0/????>
Trace; ea00000a <END_OF_CODE+18edc8c0/????>
Trace; e5cfff3e <END_OF_CODE+14bdc7f4/????>
Trace; ea00000a <END_OF_CODE+18edc8c0/????>
Trace; c0201386 <inet_sendmsg+3e/44>
Trace; c01d3355 <sock_sendmsg+69/88>
Trace; d113e8f3 <END_OF_CODE+1b1a9/????>
Trace; d113ee21 <END_OF_CODE+1b6d7/????>
Trace; d113fd26 <END_OF_CODE+1c5dc/????>
Trace; d1166a00 <END_OF_CODE+432b6/????>
Trace; d113e4e9 <END_OF_CODE+1ad9f/????>
Trace; d1166768 <END_OF_CODE+4301e/????>
Trace; d11573ad <END_OF_CODE+33c63/????>
Trace; c0109a88 <kernel_thread+28/38>

Quite scary.. especially the ea00000a part.

I've disabled nfs, and it seems to work ok right now.

Regards,
-- 
Jasper Spaans  <jasper@spaans.ds9a.nl>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
