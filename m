Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312331AbSCUBDD>; Wed, 20 Mar 2002 20:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312332AbSCUBCy>; Wed, 20 Mar 2002 20:02:54 -0500
Received: from users.724.com ([209.226.22.12]:40320 "EHLO inftormail04.724.com")
	by vger.kernel.org with ESMTP id <S312331AbSCUBCs>;
	Wed, 20 Mar 2002 20:02:48 -0500
Message-ID: <3C992FD4.6010705@724.com>
Date: Wed, 20 Mar 2002 16:56:52 -0800
From: Charles-Edouard Ruault <cruault@724.com>
Organization: ezlogin.com a 724 solutions Company
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [UPDATED] Problem on Linux 2.4 with usage of ip_default_ttl
Content-Type: multipart/mixed;
 boundary="------------000602000200010102010600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000602000200010102010600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

attached is an updated patch fixing the following problem ( i missed one 
place where a change was needed in the patch that was posted yesterday ... )

--------------------------------original message -----------------------


Here's a small bug i've discovered yesterday in linux 2.4.18 :

On Linux you can "customize" the default ttl that will be used in all
the IP packets that the box will be sending ( using
/proc/sys/net/ipv4/ip_default_ttl ) .
One of the main reasons to do that , as it has been said in many
articles, is to make your machine a little bit more difficult to
fingerprint.

However, while playing with this feature, i've discovered that the
current kernel ( 2.4.18 ) and probably earlier versions, don't use this
default value when generating the following packets :

- ICMP reply ( of any kind ) and ICMP error messages
- TCP RST .

They instead use hardcoded values ( MAXTTL ).
 From what i've seen all the other IP packets are using the value set by
/proc/sys/net/ipv4/ip_default_ttl ( provided that the socket has been
created after changing the value ).

Therefore, changing the ip_default_ttl on a standard kernel might do the
opposite of what you're trying to achieve : make it much easier for an
attacker to fingerprint your os....
By sending a few packets to the target host, you can see wether the
default ttl has been changed on the machine and therefore enforce other
findings about the host.

I've written a small patch ( against kernel 2.4.18 ) that fixes this
behaviour. I'm attaching it to this email.
comments are welcome.

PS : please CC me in replies to this email, i have not subscribed to the
list.


-- 
Charles-Edouard Ruault



--------------000602000200010102010600
Content-Type: application/x-gzip;
 name="default_ttl.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="default_ttl.patch.gz"

H4sICOkpmTwCA2RlZmF1bHRfdHRsLnBhdGNoAJ2UbW/aMBDHXyef4qRJFW2IeaYUVsQW0VGp
hapQ7aUVHKeJCHZmO11Z1e8+26EPqLSr9oYcl7vj/j//je/7kKWsuK8xqmppfteuKZJjEyCC
ZHjn/KQRXIYCmnVodPqdk369peN60/U87/3Wt22Ndtk2GoHfbVePwbOfo5ELX1JGsiKi8LWc
l+aSEpQMXXCB3isqGKRMgdxIojL9AzjasDCKxMD1XW9/AY3DIlNYqWzgQu0IgoSSFSyCK5D0
V0EZocCK9ZIKqTvhPLi8gjwkK6okgqOaXklPSBm1b/Dl+RRfjKc/FhPo6Z2Mgkb9uFntgmef
pQonFLeI4ZTfwSk0BtsEkcWax7GkSmfLgMcVqURBFGheSSSqQMx2h1CD5kBLdj3HgJTc7OMP
5cof5oKrlMUchTHWaymkhel57wl2dEZSFmFB82xT2Z1WBblaVuFAb6fD9A/lMQiVHA4Mbkcj
wufTAM8X3xZz/H1SWZB8Vqg5vZW6wn9rl5Ss8/1W6fU7zXetUrbttHT79Xa/VX+xSaN1Yhnr
R88iBniA8WQ2X9xMr8ffgknVacCjUzty7DFdXY8DHNwsZmdnjjnDR6PoE/7wSodwpgTPtA1E
uKbKOCPmAsbBZAYGY0q31ng9SYvAlCQcp7eMC4rDzOD/qGIpeBiRUCo5sBpbnbbR2Op0n2xk
W3ihMOEFUxX71S7lD6NQhcgkEqQ2Od0e2X6DcGkMslr6Q5agNE/8oU5psc7/+Cky100XpDlB
21BoMwmFpSCl4QjiufH49ObiwmZi2NndWlGXSFOXUXYIDxZA+6RnAHTqjR0AtguVF+ZUy9Br
WiUi/A0+PCUMkMFHzNAeZGX1x9fL0tsC+0T5v27jMzV7ELL883pN7eDVys+k3mJ8eYekEAbh
Xwfvrp7BBQAA
--------------000602000200010102010600--

