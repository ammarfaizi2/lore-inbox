Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbULNNad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbULNNad (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 08:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbULNNac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 08:30:32 -0500
Received: from souterrain.chygwyn.com ([194.39.143.233]:33937 "EHLO
	souterrain.chygwyn.com") by vger.kernel.org with ESMTP
	id S261505AbULNNaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 08:30:13 -0500
Date: Tue, 14 Dec 2004 13:32:35 +0000
From: Steven Whitehouse <steve@chygwyn.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: patrick@tykepenguin.com, Steve Whitehouse <SteveW@ACM.org>,
       linux-decnet-user@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/decnet/: misc possible cleanups
Message-ID: <20041214133235.GB10131@souterrain.chygwyn.com>
References: <20041214125838.GC23151@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041214125838.GC23151@stusta.de>
User-Agent: Mutt/1.4.1i
Organization: ChyGwyn Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In general this looks fine to me. Patrick has the last word though. I
would suggest hanging on to the fast timer code though for now... its
there so that delayed acks can be used and the rest of the code is
very close to actually allowing that to work. The DECnet code has a
habit of sending lots of (rather small) ack packets and it would be nice if
that could be fixed at some stage.

The issues at stake are that it would interact with the code thats working
out what the correct send window is to a certain extent. I know there is
also the argument that it can always be added back should someone have time
to add delayed acks, so I've no strong opinion either way.

Also, when I was writing the routing code - a lot of the design was "borrowed"
from the ipv4 routing code. It might be worth doing a comparison to see where
the two have diverged (something I used to do now and again) to pick up any
bugs I'd inadvertently copied over, if you are working on clean ups in this
area,

Steve.

On Tue, Dec 14, 2004 at 01:58:38PM +0100, Adrian Bunk wrote:
> The patch below contains the following possible cleanups:
> - make needlessly global code static
> - dn_fib.c: remove the write-only global variable dn_fib_info_cnt
> - dn_fib.c: remove the unused global function dn_fib_rt_message
> - dn_neigh.c: remove the unused global function dn_neigh_pointopoint_notify
> - dn_timer.c: remove the fast timer code that isn't used
> 
> Please review and comment on this patch.
