Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbUGIAUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUGIAUS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 20:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUGIAUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 20:20:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:46279 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261867AbUGIAUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 20:20:08 -0400
Date: Thu, 8 Jul 2004 17:19:58 -0700 (PDT)
From: Bryce Harrington <bryce@osdl.org>
To: "David S. Miller" <davem@redhat.com>
cc: <akpm@osdl.org>, <wli@holomorphy.com>, <ltp-list@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>, <testdev@osdl.org>
Subject: Re: [LTP] Re: Recent changes in LTP test results
In-Reply-To: <20040707141406.2a46cf82.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0407081643420.32246-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Thanks, I tried this patch out, and it does fix the accept01 error.  :-)

    http://khack.osdl.org/stp/294783/

Do you have ideas on the other failures encountered?

Bryce

On Wed, 7 Jul 2004, David S. Miller wrote:
> On Wed, 7 Jul 2004 13:48:52 -0700 (PDT)
> Bryce Harrington <bryce@osdl.org> wrote:
>
> > I have retested with ltp-full-20040603.  This version of LTP hangs on
> > our system but fortunately completes most of the tests before doing so.
> > It indicates that it still encounters the same errors, e.g.:
>
> It hangs (actually, it OOPS's) on accept01, which is fixed in the current
> BK sources via this patch:
>
> # This is a BitKeeper generated diff -Nru style patch.
> #
> # ChangeSet
> #   2004/07/06 22:02:06-07:00 davem@nuts.davemloft.net
> #   [IPV4]: Set UDP accept back to sock_no_accept.
> #
> #   Setting it to inet_accept causes UDP accept attempts
> #   to OOPS.  In particular, accept01 from LTP tries this.
> #
> #   Signed-off-by: David S. Miller <davem@redhat.com>
> #
> # net/ipv4/af_inet.c
> #   2004/07/06 22:01:31-07:00 davem@nuts.davemloft.net +1 -1
> #   [IPV4]: Set UDP accept back to sock_no_accept.
> #
> #   Setting it to inet_accept causes UDP accept attempts
> #   to OOPS.  In particular, accept01 from LTP tries this.
> #
> #   Signed-off-by: David S. Miller <davem@redhat.com>
> #
> diff -Nru a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> --- a/net/ipv4/af_inet.c	2004-07-07 14:09:13 -07:00
> +++ b/net/ipv4/af_inet.c	2004-07-07 14:09:13 -07:00
> @@ -823,7 +823,7 @@
>  	.bind =		inet_bind,
>  	.connect =	inet_dgram_connect,
>  	.socketpair =	sock_no_socketpair,
> -	.accept =	inet_accept,
> +	.accept =	sock_no_accept,
>  	.getname =	inet_getname,
>  	.poll =		datagram_poll,
>  	.ioctl =	inet_ioctl,
>

