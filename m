Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263269AbTCUF4c>; Fri, 21 Mar 2003 00:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263273AbTCUF4c>; Fri, 21 Mar 2003 00:56:32 -0500
Received: from www3.mail.lycos.com ([209.202.220.160]:59203 "HELO mailcity.com")
	by vger.kernel.org with SMTP id <S263269AbTCUF43>;
	Fri, 21 Mar 2003 00:56:29 -0500
To: "Joshua Stewart" <joshua.stewart@comcast.net>
Date: Fri, 21 Mar 2003 01:07:13 -0500
From: "Nalin gupta" <nalin_gupta@lycos.com>
Message-ID: <LLPAANEDLJJHAEAA@mailcity.com>
Mime-Version: 1.0
Cc: gary@cotecorner.com, linux-kernel@vger.kernel.org
X-Sent-Mail: on
Reply-To: nalin_gupta@lycos.com
X-Mailer: MailCity Service
X-Priority: 3
Subject: Re: Creating and sending a packet from a kernel module
X-Sender-Ip: 202.9.179.70
Organization: Lycos Mail  (http://www.mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Stewart,

I saw that you are trying something similar, to me. I also found
Mr. Gary too is trying something similar. Though I do not have
proper solution for your problem, but it may be worth if you go
through few of these recent postings:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0303.2/0437.html
http://www.uwsg.iu.edu/hypermail/linux/kernel/0303.2/0971.html
http://www.uwsg.iu.edu/hypermail/linux/kernel/0303.2/0974.html
http://www.uwsg.iu.edu/hypermail/linux/kernel/0303.2/0984.html

http://www.uwsg.iu.edu/hypermail/linux/net/0303.2/0043.html
http://www.uwsg.iu.edu/hypermail/linux/net/0303.1/0061.html

The above posting will tell you few problem which one faces,
while invoking sock_sendmsg from kernel module, in particular
when it is either in interrupt context or BH (net_bh) context.

I still wonder why ?

Only possibility I see to send / recv TCP/IP packet from kernel
module is using kernel thread.

Important API / structures are:

a.  sock_create - to create socket (like socket syscall)
b.  struct socket * sock
c.  sock->ops->bind     to bind to local address
d.  sock->ops->listen   like listen syscall
e.  sock_sendmsg       (never succeed in interrupt or BH context,
                        always fail in alloc_skb, I wonder why ?)
f.  sock_recvmsg  - Ordinary kernel module logically can not use
                    it. As you need some running thread context to
                    wait/block to receive on socket.

I've tried answering as per my limited know-how. 
Some one may like to add.

you may like to refer some example like khttpd under
/usr/src/linux/net

regards,
- nalin

--

On Thu, 20 Mar 2003 20:46:00  
 Joshua Stewart wrote:
>I'd like to create and send a brand new TCP SYN packet from a module. 
>Does anybody have an example of how to do this.
>
>I've tried doing alloc_skb, filling in all the information I could
>imagine needing in skb->data, but what is the minimal amount of stuff
>needed by the other parts of the skb to get this packet moving?
>
>Is there an easy way to create and own a TCP socket from a module that I
>could send and receive on?
>
>Thanks,
>	Josh
>
>-- 
>Joshua Stewart <joshua.stewart@comcast.net>
>


_____________________________________________________________
Get 25MB, POP3, Spam Filtering with LYCOS MAIL PLUS for $19.95/year.
http://login.mail.lycos.com/brandPage.shtml?pageId=plus&ref=lmtplus
