Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbSJEXAy>; Sat, 5 Oct 2002 19:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262793AbSJEXAy>; Sat, 5 Oct 2002 19:00:54 -0400
Received: from 25th.com ([12.109.132.50]:19979 "HELO 25th.com")
	by vger.kernel.org with SMTP id <S261375AbSJEXAx>;
	Sat, 5 Oct 2002 19:00:53 -0400
Message-ID: <3D9F7169.8020008@dodinc.com>
Date: Sat, 05 Oct 2002 19:10:33 -0400
From: "Lawrence A. Wimble" <law@dodinc.com>
Reply-To: law@dodinc.com
Organization: Design On Demand, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bizarre network issue
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings.....

I am working on a driver for generic serial-based radios (e.g, Coyote 
Datacomm
DR-915 and Microhard MHX-910, etc..), that basically allows the radio to 
be used
as a network interface, much in the spirit of STRIP.  Kernel is 2.4.8 
(mandrake 8.1).

Given that the radios pose an "unknown", I have gone to a NULL-modem cable

until this issue is resolved.  Here's what *is* working across my interface:


1. ARP ... tcpdump shows both the request AND reply.
2. PING ... Getting approx 120ms round trip with the MHX-910s (23ms null 
modem)
3. UDP ... Works perfectly with netcat in both directions.

Here's what *is not* working:

4. TCP .... tcpdump shows the SYN packet, but no SYN/ACK ever appears
5. ICMP 3/3 ... If I try a UDP session when there's no-body "listening" 
on that
    remote port, no "Port Unreachable" message is ever sent back to the 
sending host.

The fact that items 1 though 3 work, indicate that 4 and 5 should work 
as well,
but they don't.  I have added a debug statement to my driver's 
"hard_start_xmit"
routine to write to syslog when it's called.  The kernel does not even 
appear to
be calling the routine to respond to TCP SYN's or UDP packets headed for
an unreachable port.

The worst part of this is that TCP was working fine across this 
interface about
a month ago.  When I went to pick up where I left off from is when this 
behavior
started to exhibit itself.  Any ideas?

Please CC me personally on responses as I am not subscribed to the list.

TIA,
Larry

-- 
Lawrence A. Wimble                          414 NE 3rd Street; Suite B
Chief Software Engineer                     Crystal River, FL 34429
Design On Demand, Inc.                      Phone 352-563-1225 x112
law@dodinc.com                              Fax 352-563-2098



