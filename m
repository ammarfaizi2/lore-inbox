Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132317AbRAHVZS>; Mon, 8 Jan 2001 16:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131677AbRAHVZJ>; Mon, 8 Jan 2001 16:25:09 -0500
Received: from hoemail1.lucent.com ([192.11.226.161]:32753 "EHLO
	hoemlsrv.firewall.lucent.com") by vger.kernel.org with ESMTP
	id <S131388AbRAHVZD>; Mon, 8 Jan 2001 16:25:03 -0500
Cc: "David S. Miller" <davem@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <3A5A3027.11A56673@linuxia.ih.lucent.com>
Date: Mon, 08 Jan 2001 15:24:55 -0600
From: "M.H.VanLeeuwen" <mhvl@linuxia.ih.lucent.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Meadors <clubneon@hereintown.net>
Original-CC: "David S. Miller" <davem@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Delay in authentication.
In-Reply-To: <Pine.LNX.4.31.0101080918260.17858-100000@rc.priv.hereintown.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris,

I reported the same thing on 11/19/00, whether this is a feature or bug for
2.4.X was not determined.  Was this behavior intentionally changed and why?

Looks like 2.2.X gives ECONNREFUSED, but 2.4.X doesn't and times out.

http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg13983.html text below.

Martin

----------------------------------------


       I had occasion to "telinit 1" today and found that it took a long time
       to login after root passwd was entered.  this doesn't happen with 2.2.X
       kernels.

       Is this to be expected with the 2.4 series kernels? or a bug?

       Martin

       strace for 2.4.0-test11-pre7

       ---snip---
       gettimeofday({974665658, 952483}, NULL) = 0
       socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP) = 3
       getpid()                                = 305
       bind(3, {sin_family=AF_INET, sin_port=htons(905), sin_addr=inet_addr("0.0.0.0")}}, 16) 
       = 0
       ioctl(3, FIONBIO, [1])                  = 0
       sendto(3, "\31\23\233@\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\2\0\0\0\3"..., 56, 0, 
       {sin_family=AF_INET, sin_port=htons(111),
       sin_addr=inet_addr("127.0.0.1")}}, 16) = 56
       poll([{fd=3, events=POLLIN}], 1, 5000)  = 0
       ioctl(3, SIOCGIFCONF, 0xbfffb33c)       = 0
       ioctl(3, SIOCGIFFLAGS, 0xbfffb344)      = 0
       sendto(3, "\31\23\233@\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\2\0\0\0\3"..., 56, 0, 
       {sin_family=AF_INET, sin_port=htons(111),
       sin_addr=inet_addr("127.0.0.1")}}, 16) = 56 
       ---snip---

       strace for 2.2.17

       ---snip---
       gettimeofday({974664928, 735539}, NULL) = 0
       socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP) = 3
       getpid()                                = 368
       bind(3, {sin_family=AF_INET, sin_port=htons(968), sin_addr=inet_addr("0.0.0.0")}}, 16) 
       = 0
       ioctl(3, FIONBIO, [1])                  = 0
       sendto(3, "_c\353\331\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\2\0\0\0\3"..., 56, 0, 
       {sin_family=AF_INET, sin_port=htons(111),
       sin_addr=inet_addr("127.0.0.1")}}, 16) = 56
       poll([{fd=3, events=POLLIN, revents=POLLERR}], 1, 5000) = 1
       recvfrom(3, 0x8056380, 400, 0, 0xbfffd66c, 0xbfffd618) = -1 ECONNREFUSED (Connection 
       refused)
       close(3)                                = 0  
       ---snip---

---------------------------------------------------------------------

Chris Meadors wrote:
> 
> On Mon, 8 Jan 2001, David S. Miller wrote:
> 
> > This definitely seems like the classic "/etc/nsswitch.conf is told to
> > look for YP servers and you are not using YP", so have a look and fix
> > nsswitch.conf if this is in fact the problem.
> 
> What I have never gotten, is why on my machines (no specific distro, just
> everything built from source and installed by me) login takes a long time,
> unless I have portmap running.
> 
> My /etc/nsswitch.conf would seem to be right:
> 
> passwd:         files
> group:          files
> shadow:         files
> 
> hosts:          files dns
> networks:       files dns
> 
> protocols:      files
> services:       files
> ethers:         files
> rpc:            files
> 
> netgroup:       files
> 
> What else could effect that?
> 
> -Chris
> --
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
