Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266065AbUF2VC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266065AbUF2VC5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 17:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266058AbUF2VC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 17:02:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:20897 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266049AbUF2VCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 17:02:53 -0400
Date: Tue, 29 Jun 2004 14:02:42 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "David S. Miller" <davem@redhat.com>
Cc: debi.janos@freemail.hu, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: 2.6.7-mm1 - 2.6.7-mm4 weird http behavior
Message-Id: <20040629140242.1e274ffb@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040629135922.12384153.davem@redhat.com>
References: <freemail.20040529152006.85505@fm4.freemail.hu>
	<20040629112256.58828632@dell_ss3.pdx.osdl.net>
	<20040629124951.56de307d@dell_ss3.pdx.osdl.net>
	<20040629125401.4ca60aa7.davem@redhat.com>
	<20040629133501.3c2cd2a2@dell_ss3.pdx.osdl.net>
	<20040629135922.12384153.davem@redhat.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2004 13:59:22 -0700
"David S. Miller" <davem@redhat.com> wrote:

> On Tue, 29 Jun 2004 13:35:01 -0700
> Stephen Hemminger <shemminger@osdl.org> wrote:
> 
> > FYI - gentoo works for window scale 0..2 and appears to fail for >3.
> > 
> > Also, the socket ends up with:
> > 
> > State      Recv-Q Send-Q      Local Address:Port          Peer Address:Port
> > ESTAB      0      0             172.20.1.73:34452       198.63.211.232:http
> >          ts sack wscale:0,3 rto:332 rtt:66.375/50.5 cwnd:3
> 
> Yes, I've seen this declared in other reports too.
> 
> It probably means just that for window scales of 0..2 the misinterpretation
> does not result in a too-small-to-send-data window.
> 
> But I'm still confused that the scaled window is being given to the
> receiver, and this makes the connection freeze.  I wonder if there is
> a queer box doing NAT or similar in front of the gentoo machine which
> either:
> 
> 1) Applies any window scaling to both directions
> 2) Applies window scaling to the wrong direction
> 
> and uses this to "help" with dropping of out-of-window TCP segments.

Unfortunately, this means the default probably means that window scale must be
disabled. An interesting experiment would be to see if other implementations have
the same problem with window scale enabled.
