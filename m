Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274185AbRIYV3F>; Tue, 25 Sep 2001 17:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274523AbRIYV24>; Tue, 25 Sep 2001 17:28:56 -0400
Received: from hermes.csd.unb.ca ([131.202.3.20]:23209 "EHLO hermes.csd.unb.ca")
	by vger.kernel.org with ESMTP id <S274185AbRIYV2m>;
	Tue, 25 Sep 2001 17:28:42 -0400
X-WebMail-UserID: newton
Date: Tue, 25 Sep 2001 18:38:31 -0300
From: Chris Newton <newton@unb.ca>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
X-EXP32-SerialNo: 00003025, 00003442
Subject: RE: excessive interrupts on network cards
Message-ID: <3BB11992@webmail1>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: WebMail (Hydra) SMTP v3.61.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yea, it is a single port card... I had meant to mention that in the email I 
sent out...  ie: that it wasn't reporting correctly... but, I didnt really 
think it was related, since the eepro was doing the same thing.

  As for comparing with ifconfig, I ran 'watch 1 ifconfig -a', and sure 
enough, I have about ~7000-7500 packets coming in right now.  And, the 
'procinfo -D', reports ~21000-22000 interrupts per second.

  Other sources I have used to confirm packet rate... include output from 
'sniffer', a flow generator that was monitoring that link, and the hub this 
machine is plugged into.

  the hub has 3 active ports.. port 1 is one side of our internet conenction 
(out to our provider), port 2 was from the hub over to our main router... port 
3 is a mirror of the IN on port 1 and the OUT on port 2 to port 3.  Comparing, 
and verifying, showed port 3 getting 10K packets (this afternoon, which 
obviously drops at night, which it is here now), and down to 7K now.

Chris


>===== Original Message From Andrew Morton <akpm@zip.com.au> =====
>Chris Newton wrote:
>>
>> Hi,
>>
>>   I 'think' the number of interrupts being generated for the network 
traffic I
>> monitor, is excessive.  Having talked quikly with Donald Becker, he 
indicated
>> that I should be seeing a little less than the number of RX/TX packets/s on 
a
>> wire, in terms of interrupts/s.  That, however, is not what I am seeing.  I 
am
>> seeing 3 times as many interrupts/s as I am seeing packets/s.
>>
>>   I have used three network devices to look at the stream I am monitoring, 
and
>> it is usually aorund 5K packet/s IN, and 5K out, fed full duplex into a 
single
>> 3Com 3c982 (2.4.10 kernel reports that anyways).  However, watching:
>
>3c982 is a dual-port server NIC.  Is your card dual-port?  If not, it's 
probably
>a 3c980, and I goofed :)
>
>>  'procinfo -D', reports on the order of 30,000 interrupts per second.
>
>That does sound rather high.  You should compare the interrupt rate
>with the packet rate from `ifconfig' or /proc/net/dev.
>
>Normally, 3c59x will show approx three Tx packets per interrupt
>and one Rx packet per interrupt.  It varies with workload, but
>it tends to vary in the "good" direction - at higher packet
>rates, we do more work in a single interrupt and the interrupt-per-packet
>rate falls.

