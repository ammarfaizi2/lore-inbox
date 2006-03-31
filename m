Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWCaSro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWCaSro (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 13:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWCaSro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 13:47:44 -0500
Received: from smop.co.uk ([81.5.177.201]:64678 "EHLO hades.smop.co.uk")
	by vger.kernel.org with ESMTP id S1750959AbWCaSro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 13:47:44 -0500
Date: Fri, 31 Mar 2006 19:47:33 +0100
To: "David S. Miller" <davem@davemloft.net>
Cc: ak@muc.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm1 leaks in dvb playback (found)
Message-ID: <20060331184733.GA21384@smop.co.uk>
Reply-To: adrian@smop.co.uk
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>, ak@muc.de,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20060331072859.GA5389@smop.co.uk> <20060330.234823.109651253.davem@davemloft.net> <20060331095443.GA8616@smop.co.uk> <20060331.020727.122135042.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331.020727.122135042.davem@davemloft.net>
User-Agent: Mutt/1.5.11+cvs20060126
From: Adrian Bridgett <adrian@smop.co.uk>
X-smop.co.uk-MailScanner: Found to be clean
X-smop.co.uk-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.658,
	required 5, autolearn=not spam, AWL -0.06, BAYES_00 -2.60,
	NO_RELAYS -0.00)
X-smop.co.uk-MailScanner-From: adrian@smop.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2006 at 02:07:27 -0800 (-0800), David S. Miller wrote:
> Strange, can you strace the process and follow the socket
> operations your application performs?  Something unique
> is occuring in that app since there have not been other
> reports of this problem that I am aware of.

The strace output is the same when run under both kernels (a leaking
one and a non-leaking one):

7384  socket(PF_FILE, SOCK_STREAM, 0)   = 7
7384  connect(7, {sa_family=AF_FILE, path="/var/run/nscd/socket"}, 110) = 0
7384  recvmsg(7, {msg_name(0)=NULL, msg_iov(1)=[{"hosts\0", 6}],
      msg_controllen=16, {cmsg_len=16, cmsg_level=SOL_SOCKET,
      cmsg_type=SCM_RIGHTS, {8}}, msg_flags=0}, MSG_NOSIGNAL) = 6
7384  socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 7
7384  setsockopt(7, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
7384  bind(7, {sa_family=AF_INET, sin_port=htons(12345), sin_addr=inet_addr("0.0.0.0")}, 16) = 0
7384  listen(7, 1)                      = 0
7384  accept(7, 0x81546e4, [0])         = -1 EAGAIN (Resource temporarily unavailable)
7384  accept(7, 0x81546e4, [0])         = -1 EAGAIN (Resource temporarily unavai
[repeated lots and lots ....]

So I guess I was _completely_ wrong and that it's the failure case
that is leaking.

It also looks like dvbstream is being a tad silly so I'll go and have
a look at that (userspace stuff I stand a chance with).

Thanks,

Adrian
