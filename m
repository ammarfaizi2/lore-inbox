Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270737AbTGUVwC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 17:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270738AbTGUVwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 17:52:02 -0400
Received: from hendrix.ece.utexas.edu ([128.83.59.42]:53888 "EHLO
	hendrix.ece.utexas.edu") by vger.kernel.org with ESMTP
	id S270737AbTGUVv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 17:51:59 -0400
Message-ID: <3F1C6406.5040009@ece.utexas.edu>
Date: Mon, 21 Jul 2003 17:07:02 -0500
From: yi <yi@ece.utexas.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: yi@ece.utexas.edu
Subject: TCP congestion window
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.2, required 9, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,
First, I apologize you for posing this message although I'm not on the list.

I have some questions. I made the following system call for getting tcp 
cwnd size of ongoing connection. However, I am always getting the value 
of "2", which is the initial tcp cwnd size, I think. What I really want 
to do is to trace tcp cwnd size when I download some big file using 
"wget"'s http file downloader. For it, I added a new system call shown 
below and modified the wget source code.

Please cc to me personally in reply. Thanks in advance.

Best Regards,
Yung Yi.

---------------------------------------------------------------------------
asmlinkage int sys_get_winsize(int sockfd)
{
    struct socket *sock;
    struct sock *sk;
    int err;
    sock = sockfd_lookup(sockfd, &err);

    if (!sock)
        return -1;

    sk = sock->sk;
    return sk->tp_pinfo.af_tcp.snd_cwnd;
}


