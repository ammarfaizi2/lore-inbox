Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265423AbTBJWXQ>; Mon, 10 Feb 2003 17:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265446AbTBJWXQ>; Mon, 10 Feb 2003 17:23:16 -0500
Received: from lucidpixels.com ([66.45.37.187]:36879 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id <S265423AbTBJWXO>;
	Mon, 10 Feb 2003 17:23:14 -0500
Message-ID: <3E482899.9070906@lucidpixels.com>
Date: Mon, 10 Feb 2003 17:32:57 -0500
From: jpiszcz <jpiszcz@lucidpixels.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Evil bug in netfilter/kernel 2.4.x?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://iptables-tutorial.frozentux.net/iptables-tutorial.html
"As a secondary note, if you use connection tracking you will not see 
any fragmented packets, since they are dealt with before hitting any 
chain or table in iptables."

PROBLEM:

root@p300:/etc/rc.d# iptables -t filter -I INPUT -f -j LOG --log-level 3 
--log-prefix "FRAG: "
root@p300:/etc/rc.d# iptables -I INPUT -f -j LOG --log-level 3 
--log-prefix "FRAG: "
root@p300:/etc/rc.d# iptables -I INPUT -f -j LOG --log-level 3 
--log-prefix "FRAG: "
root@p300:/etc/rc.d# iptables -I INPUT -f -j DROP

I've tried all of these, each one by itself.

However, when I run tcpdump, I can clearly see these are not getting 
dropped or logged by the kernel.

I like conn_track for DCC/FTP connections, however, to get logging & 
dropping of fragmented packets working properly, I must recompile 
without the conn_tracker's?

Wouldn't this be considered as a bug?  Someone could be 
pounding/scanning you with fragmented packets, and you would never see 
it, as many people run the DCC and/or FTP connection trackers!

box1# nmap -sS -P0 -f -p 1-65535 box2.com

17:11:52.659286 box1.com > box2.com: (frag 2729:4@16)
17:11:52.661416 box1.com > box2.com: (frag 986:4@16)
17:11:52.663400 box1.com > box2.com: (frag 61814:4@16)
17:11:52.665398 box1.com > box2.com: (frag 30216:4@16)
17:11:52.667401 box1.com > box2.com: (frag 4100:4@16)
17:11:52.669392 box1.com > box2.com: (frag 61387:4@16)

947 packets received by filter
0 packets dropped by kernel

Is it possible in anyway to log/drop/match fragmented packets with 
connection tracking turned on?

Please CC me as I am not on the list.

