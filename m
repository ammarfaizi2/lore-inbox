Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269466AbTGVE24 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 00:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269439AbTGVE24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 00:28:56 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:35254 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S269409AbTGVE2w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 00:28:52 -0400
Date: Tue, 22 Jul 2003 10:48:00 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: nagendra_tomar@adaptec.com
To: yi <yi@ece.utexas.edu>
cc: linux-kernel@vger.kernel.org, <linux-net@vger.kernel.org>
Subject: Re: TCP congestion window
In-Reply-To: <3F1C6406.5040009@ece.utexas.edu>
Message-ID: <Pine.LNX.4.44.0307221044080.7134-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yi,
   First of all networking related questions should go to 
linux-net@vger.kernel.org. Now for ur question.
cwnd has got significance in the sending side of a TCP connection. Its the 
sender that keeps changing the cwnd based on the ACKs recvd. If you are 
using wget for downloading a file and you are expecting cwnd to change on 
the wget side, then the answer is that since wget is *only* receiving 
data, cwnd will not change on wget side. It will change on the other side.
If you are checking for cwnd on the other side then please ignore my 
answer.

Thanx
tomar


On Tue, 22 Jul 2003, yi wrote:

> Dear all,
> First, I apologize you for posing this message although I'm not on the
> list.
> 
> I have some questions. I made the following system call for getting tcp 
> cwnd size of ongoing connection. However, I am always getting the value 
> of "2", which is the initial tcp cwnd size, I think. What I really want 
> to do is to trace tcp cwnd size when I download some big file using 
> "wget"'s http file downloader. For it, I added a new system call shown 
> below and modified the wget source code.
> 
> Please cc to me personally in reply. Thanks in advance.
> 
> Best Regards,
> Yung Yi.
> 
> ------------------------------------------------------------------------
> ---
> asmlinkage int sys_get_winsize(int sockfd)
> {
>     struct socket *sock;
>     struct sock *sk;
>     int err;
>     sock = sockfd_lookup(sockfd, &err);
> 
>     if (!sock)
>         return -1;
> 
>     sk = sock->sk;
>     return sk->tp_pinfo.af_tcp.snd_cwnd;
> }
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

