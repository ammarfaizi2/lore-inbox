Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWA3Q4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWA3Q4M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 11:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWA3Q4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 11:56:11 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:45070 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S964778AbWA3Q4K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 11:56:10 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, thockin@hockin.org
Subject: Re: 2.6.15.1: persistent nasty hang in sync_page killing NFS
 (ne2k-pci / DP83815-related?), i686/PIII
References: <87fyn8artm.fsf@amaterasu.srvr.nix>
	<1138499957.8770.91.camel@lade.trondhjem.org>
	<87slr79knc.fsf@amaterasu.srvr.nix>
	<8764o23j0s.fsf@amaterasu.srvr.nix>
	<1138566075.8711.39.camel@lade.trondhjem.org>
	<871wyq3dl3.fsf@amaterasu.srvr.nix>
	<1138572140.8711.82.camel@lade.trondhjem.org>
From: Nix <nix@esperi.org.uk>
X-Emacs: a compelling argument for pencil and paper.
Date: Mon, 30 Jan 2006 16:55:47 +0000
In-Reply-To: <1138572140.8711.82.camel@lade.trondhjem.org> (Trond
 Myklebust's message of "Sun, 29 Jan 2006 17:02:20 -0500")
Message-ID: <874q3lwt7w.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jan 2006, Trond Myklebust stipulated:
> As a general rule of thumb: if tcpdump/ethereal can see the reply on the
> client, then the engine socket should see it too. If tcpdump is indeed
> seeing those replies, you should check the RPC code by
> setting /proc/sys/sunrpc/rpc_debug to 1.

tcpdump is seeing them.

... have a pile of messages in the midst of a locked-up transfer:

Jan 30 16:50:57 loki warning: kernel: -pid- proc flgs status -client- -prog- --rqstp- -timeout -rpcwait -action- --exit--
Jan 30 16:50:57 loki warning: kernel: 15046 0006 0021 -00011 c1a11600 100003 c801f000 00000000 xprt_resend c02c3798 c01c0e4d
Jan 30 16:50:57 loki warning: kernel: 15047 0006 0021 000000 c1a11600 100003 c801f0b8 00000070 xprt_pending c02c3869 c01c0e4d
Jan 30 16:50:57 loki warning: kernel: 15048 0006 0021 -00011 c1a11600 100003 c801f170 00000000 xprt_resend c02c3798 c01c0e4d
Jan 30 16:50:57 loki warning: kernel: 15049 0006 0001 -00011 c1a11600 100003 c801f228 00000000 xprt_sending c02c3798 c01c0e4d
Jan 30 16:50:57 loki warning: kernel: RPC: 15047 xprt_timer
Jan 30 16:50:57 loki warning: kernel: RPC:      cong 256, cwnd was 256, now 256
Jan 30 16:50:57 loki warning: kernel: RPC: 15048 xprt_cwnd_limited cong = 0 cwnd = 256
Jan 30 16:50:57 loki warning: kernel: RPC: 15048 xprt_prepare_transmit
Jan 30 16:50:57 loki warning: kernel: RPC: 15048 xprt_transmit(116)
Jan 30 16:50:57 loki warning: kernel: RPC: 15048 xmit complete
Jan 30 16:50:57 loki warning: kernel: RPC: 15047 xprt_prepare_transmit
Jan 30 16:50:57 loki warning: kernel: RPC: 15047 xprt_cwnd_limited cong = 256 cwnd = 256
Jan 30 16:50:57 loki warning: kernel: RPC: 15047 failed to lock transport c1a11800
Jan 30 16:50:58 loki warning: kernel: RPC: 15048 xprt_timer
Jan 30 16:50:58 loki warning: kernel: RPC:      cong 256, cwnd was 256, now 256
Jan 30 16:50:58 loki warning: kernel: RPC: 15046 xprt_cwnd_limited cong = 0 cwnd = 256
Jan 30 16:50:58 loki warning: kernel: RPC: 15046 xprt_prepare_transmit
Jan 30 16:50:58 loki warning: kernel: RPC: 15046 xprt_transmit(116)
Jan 30 16:50:58 loki warning: kernel: RPC: 15046 xmit complete
Jan 30 16:50:58 loki warning: kernel: RPC: 15048 xprt_prepare_transmit
Jan 30 16:50:58 loki warning: kernel: RPC: 15048 xprt_cwnd_limited cong = 256 cwnd = 256
Jan 30 16:50:58 loki warning: kernel: RPC: 15048 failed to lock transport c1a11800
Jan 30 16:50:59 loki warning: kernel: RPC: 15046 xprt_timer
Jan 30 16:50:59 loki warning: kernel: RPC:      cong 256, cwnd was 256, now 256
Jan 30 16:50:59 loki warning: kernel: RPC: 15047 xprt_cwnd_limited cong = 0 cwnd = 256
Jan 30 16:50:59 loki warning: kernel: RPC: 15047 xprt_prepare_transmit
Jan 30 16:50:59 loki warning: kernel: RPC: 15047 xprt_transmit(116)
Jan 30 16:50:59 loki warning: kernel: RPC: 15047 xmit complete
Jan 30 16:50:59 loki warning: kernel: RPC: 15046 xprt_prepare_transmit
Jan 30 16:50:59 loki warning: kernel: RPC: 15046 xprt_cwnd_limited cong = 256 cwnd = 256
Jan 30 16:50:59 loki warning: kernel: RPC: 15046 failed to lock transport c1a11800
Jan 30 16:51:00 loki warning: kernel: RPC: 15047 xprt_timer
[repeats indefinitely]
Jan 30 16:51:38 loki warning: kernel: -pid- proc flgs status -client- -prog- --rqstp- -timeout -rpcwait -action- --exit--
Jan 30 16:51:38 loki warning: kernel: 15046 0006 0021 -00011 c1a11600 100003 c801f000 00000000 xprt_resend c02c3798 c01c0e4d
Jan 30 16:51:38 loki warning: kernel: 15047 0006 0021 000000 c1a11600 100003 c801f0b8 00000140 xprt_pending c02c3869 c01c0e4d
Jan 30 16:51:38 loki warning: kernel: 15048 0006 0021 -00011 c1a11600 100003 c801f170 00000000 xprt_resend c02c3798 c01c0e4d

The RPC messages are emitted at pretty much exactly the same frequency
as the ACKs.

I *guess* that the `failed to lock transport' is the underlying error...
time to add some debugging and find out what task is locking the
transport. Back soon, must rebuild the kernel and reboot to clear this
lock ;)

-- 
`I won't make a secret of the fact that your statement/question
 sent a wave of shock and horror through us.' --- David Anderson
