Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265235AbTLMSER (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 13:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265243AbTLMSER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 13:04:17 -0500
Received: from xavier.comcen.com.au ([203.23.236.73]:40200 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S265235AbTLMSEN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 13:04:13 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Jesse Allen <the3dfxdude@hotmail.com>, Ian Kumlien <pomac@vapor.com>
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Date: Sun, 14 Dec 2003 04:07:28 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, AMartin@nvidia.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gV12/wXo1dhOKoP"
Message-Id: <200312140407.28580.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_gV12/wXo1dhOKoP
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,
I have updated the apic timer ack delay patch and the io-apic edge patch
although I do not think anyone had any problems with the first release.

These patches may not be required if your bios is sorted out - mine are
not yet.

The apic ack delay no longer adds a small delay to every timer int so I 
believe its performance hit is barely detectable. 

In fact the busier the system gets with irqs- the more likelyhood 
of the delay time expiring naturally and the less the impact of the patch.

It now only delays the ones that would be too quick and most likely
cause a hard lockup. It also reports its existence on boot if used. e.g.

..APIC TIMER ack delay, reload:16701, safe:16691

And if  

#define APIC_DEBUG 0

is set to 1 in 

/usr/src/linux-2.4.23-rd2/include/asm-i386/apic.h

Then you can report at boot ten pre delay apic timer times as well to get a 
feel as to whether the delay had to kick in or not. Note that ten is a very
small sample size but it gives an idea of the timing numbers.

The apic timer counts down from the reload value and interrupts at zero.
The reload value corresponds to the time between HZ at the rate the 
counter counts. Nothing new so far.
e.g. My system is running 1000Hz so the time is 1ms.
The reload value is 16701 so that represents 1ms.

The safe count it calculates for my system is 16691 so any number smaller
than that is expected to be when it is safe to ack the local apic after an apic
timer interrupt. If you want to experiment with the delay time in nano seconds
just change the 600UL. If I set mine to 400UL then my hard lockups return.
Interestingly I can read the local apic timer safely right after the interrupt - 
I just can't safely ack it then. It is as if the C1 disconnect logic within the
processor only screws with the ACK irq cancellation logic and then only for
a short time after an irq.



The io-apic edge patch has been cleaned up a little. If the above debug is on
then it will display the 8259a xtpic interrupt mask. I get hex fb and hex ff 
indicating that the only int enabled on the 8259A xtpic which handles irq 0-7
is the cascade irq 2 which is OK because on the other 8259A irq 8-15 are masked.
This masked xtpic should always be the case. We want the 8259A off during
our test to see if the 8254 timer is connected directly to pin 0 of the ioapic.
The other messages are as per previous version.


Lastly I need sleep (4 am) so they are not yet done as patch files. I have
put them into two text files and bzipped them as an attachment. Anyhow they
are small and insert in the same places as their previous versions.

Thanks Jesse for rediffing the original patches for 2.6 would you like to repeat
the favour with these please?

Again they are still experimental.... so I am hoping Ian, Jesse and others will
put them to the test.

Thanks
Ross Dickson.


--Boundary-00=_gV12/wXo1dhOKoP
Content-Type: application/x-tbz;
  name="rossfixes-ver2.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="rossfixes-ver2.tar.bz2"

QlpoOTFBWSZTWUCF9IIABLP/hOowAEB7////v+//3v/v/+oAAQAIUAW2WJHnc3Ik7sVTIbCUIhBo
BkmBG0p6nphRskHkmno1GQAAMj1HqAlBCah6TKQfojBQ0HqNBoADQaGjRiaAA2oJNSlT01P0Uz1T
I/VD0myhoyAAGQ00AZAAZAAcDQaZDTRoYQMhoYI0NMmjQDIMQABoJIUaZE9JiE01PSnqNA0D1B6R
5TI2oDQHqAB6gH2JfcxmqAoCQiAgZi+KJmz6FvBGSCgtgzJCanAlgEtAP8ySlYIMQZFFARIlUUIi
qCJIiSLFVzjLm5ObW/qK6pqWMG5xtDX+KpxZMd1Zq6jKysqqqhbetxV0xxi1+Kn18scY9hgqlVom
HrALZJB0O4iyZW2bRTt28nV9TRR47AUuDiZc+ETaolBT6VFZLEWs8jTLitXTdYxASlCnzrU+3Odj
ItngZJf1Xp28q8yrnhSiMR1YkcpkMcLGb9uxlqdjpdLHXWsuaShiffJ3o3FeiMFqOxqIbBgt/eW0
l5VYw5HMq10e6oKHptX8tI1vw0i9EZ9CpT4TqyYZrnyV2BsRG5S4VS/BWqT5P7Bc3IsNjuUsUpvp
dO+hI4rEFlJZuG47DPa0+jK+4OsOriO9+Qv3hlDUrOFFUXWJPHPZJhyQEmdw10lBjfZpzJGbyWjR
toLRQUjVDV+Vgc2C1FezF1SGGRXnxYs0LSUPx6iyHvf4QmAwmSWB/X2q7bcijGdmQP/0VtHuPDZh
PKVV2HYZnpHocObo0sFQsa8CEiZZ1CG0FDrp4bC+S2tWq+0ylDgqki1JpsmqRk3q12/rE4TdmOXq
OVu1CD9E6e8btkkqJnGtFocHkq205jMOX9Nvx4wSUsBC/wPg8eFtccIo7ilbEZyeAI2dZFCwkynY
V4W3n56EiheL/DqT9uSDrPLo2T83g36UDQqq/Qwjrx4RyFZmOX1lbpUCcT53omgsni7q6BmHPwoM
kSEAx09iBD2mVgVxmVVQHwkE2nZihQ40LiP4Su7rwfs+BBRMg7gwReqjMu4cHNsro3Z4WSR14l+B
s1odZY7yoWrE8CGM1AnyDCCVHC09bIqIJ42mCN4iaYi8ZpIZyqxRXj+8TljFujXxOoLtnYM2x+c/
G6uDSSYbiGB+PmIokNbOQzhwkDoVVycnudpSE6kNSKj5RonmzMaH30u4EVFLaFZXofNOuMuG7XU+
lw1QunYYFz9puFM8pU2NLHHWrEZk0fejz3CiSZY95GBGjYq2YtowydptoQEqsL+4A0Gfpme3DMcP
TUqqNItpwJVSrmUl5hZopa101cMC4aNX+qqniQjZEgIpO+QCsSM5NZOKKmeLSJcJc6hkYvLTQ/Qp
STSZKBknuOUwiViMmdauXgBkZuimNkHIjjYiaPG7rFgaxElJfMpG8yAY4M6NPxLbFBv51JkjshbA
5ZjpzkXHGgBJUPVZBVAYcwLdxRiYNdAbZcbLSy6AbKKKCwIBmfaHBlrQP0EDsqm1wZwcz51XnuZH
JfzVKDuW4ZNamZVtLIlIYKqPViKIiOikFIKjE1t5ESCOzIEDE2Gv3OrqC51ejl8lEamvZ3y85oFm
KZ4ZKu4oOzwziK7AmyZ0QG8DcFqjZdgp3PApb0nmEwm1jOwWTOw1NPFoGPzZCr75kJLJQlj9WnSm
vRrcFSYr7roTj545EiJmRsKkshWKroaNpqYJ1akCLhUqbsjvrUsEKRXibDM9R7R5WwdMFh3zW3Np
athsYhiNDBiJ61nRZFusW18aj7VIWCizN+ovoyv33lbIbLa95qeoxCoEFGaYOZ6nqhMwGJV2ZmwW
CDmpYlLvPGp+u7LXaysOhbv2zqaLfXSNMy1XadyjS5DNqKTCMlNbaHaFByioNv6Rayq9fy6XrLVJ
WKGNQM0hP+LuSKcKEggQvpBA

--Boundary-00=_gV12/wXo1dhOKoP--

