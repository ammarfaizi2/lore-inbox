Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311570AbSCTFtE>; Wed, 20 Mar 2002 00:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311577AbSCTFsy>; Wed, 20 Mar 2002 00:48:54 -0500
Received: from adsl-63-193-243-214.dsl.snfc21.pacbell.net ([63.193.243.214]:29569
	"EHLO dmz.ruault.com") by vger.kernel.org with ESMTP
	id <S311570AbSCTFsl>; Wed, 20 Mar 2002 00:48:41 -0500
Message-ID: <3C982378.3010202@ruault.com>
Date: Tue, 19 Mar 2002 21:51:52 -0800
From: Charles-Edouard Ruault <ce@ruault.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem on Linux 2.4 with usage of ip_default_ttl 
Content-Type: multipart/mixed;
 boundary="------------000503070504080206000008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000503070504080206000008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here's  a small bug i've discovered yesterday in linux 2.4.18 :

On Linux you can "customize" the default ttl that will be used in all 
the IP packets that the box will be sending ( using 
/proc/sys/net/ipv4/ip_default_ttl ) .
One of the main reasons to do that , as it has been said in many 
articles, is to make your machine  a little bit more difficult to 
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
PGP Key ID 4370AF2D


--------------000503070504080206000008
Content-Type: application/x-gzip;
 name="default_ttl.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="default_ttl.patch.gz"

H4sICFCDlzwCA2RlZmF1bHRfdHRsLnBhdGNoAJ2TbU/bMBDHXyef4iSkqZAmadJQSrtFZVFZ
kfqAaHhtBcchVlM7sx1EQXz32WklVg2maW/iy/nudPe/n13XhYqy5tlnRPm0fop8ire1hz2Z
PVkLzmCRCQiGEPRGUX8URhD2eqHtOM7HaUcp4Si8HEXDfcpkAm7Qv+wOwDHHECYTGwBeYTpb
rdP75d30Kpl1rQDeLP/MukkWt+j2bpqg5D5dXV9bZ74Nb2MbbIc8KyIYUKZA7iRWFaI1ykmR
NZVCSlVj27HBP4OEMyV4BXUmsi3RORIKLmCazFYgSF1RIj0wZX+vpIdABJcc0UfGBUFZpev9
NeJB8CzHmVRy3M7YP4/MjP3zQfeindFqU3ijEOYNU532t23KjfNMZZ5xlJ7a1eTUDAiW3Lhx
LbiirOBeViCqRfYUl/AN5ObBjVnp0bp0Y+3Sw34SrioT/rFAYOVZngsdQGvsHUyh3FgoJAU2
AeaC10r7l/fzeesp4Kh3o+FOh0gTVxF2Cq+2+ydOCtfIGJ8h1et/itR76lFaMDqPRsHgHatB
pKV22q8R/IQyXDU5ga/7erSWBHtlbLT9GJ4dMxqMbfdf6GrZKgneQJrcgiQ/G8IwAdZsHwxj
lIGBV2OHN0QdEDvRFfRa2hu0uFmi+XT5I53BUPfUPozeRdi+DHMesMnEo8cQ5U96B8H44MCy
2fKikMRsZm/woiOVaLACrVeZiy5g090p+BCOwbwYywgpuenHjf+HFu2RhOWoXXnnuFrXMNmF
L7o7bdIXwguNUnlAWUuEbpYJWqdX6Rp9n3VSXK8atSaPUkf8AiwDVdB+BAAA
--------------000503070504080206000008--

