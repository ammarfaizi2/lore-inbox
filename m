Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWI3WBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWI3WBS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 18:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWI3WBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 18:01:18 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:3779 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1751395AbWI3WBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 18:01:17 -0400
Message-ID: <451EE973.10907@candelatech.com>
Date: Sat, 30 Sep 2006 15:02:27 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Question on HDLC and raw access to T1/E1 serial streams.
References: <451DC75E.4070403@candelatech.com> <m3mz8hntqu.fsf@defiant.localdomain>
In-Reply-To: <m3mz8hntqu.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> Ben Greear <greearb@candelatech.com> writes:
>
>   
>> I am looking for a way to bridge a T1/E1 network by reading a raw
>> bitstream from one T1 interface and writing it out to the other.  The
>> application is adding delay and/or bit corruptions for impairment
>> testing.
>>
>> I have been using Sangoma's drivers and NICs, but I'm having no luck
>> getting their latest stuff to work so I was hoping to use in-kernel
>> drivers (even if that means writing or hiring someone to write new ones.)
>>
>> Is there currently a way to read/write the raw bitstream for a full T1
>> or E1 or a subset of channels?
>>     
>
> Well, my generic HDLC works with HDLC framing only, T1/E1 is
> a layer lower than that... I think Cyclades have (had?) a version
> of PC300 card with T1/E1 interface. It at least doesn't require
> any "binary blobs", though I think the driver would need some work.
>
> Which line interface do you need? G.703?
> Do you need to bridge multiple streams (not slots) over one
> interface (internal (de)multiplexer - I mean "more than one
> subset of channels")?
>   
For protocols running HDLC as transport, I can just bridge HDLC frames.  
I would want
to be able to select the channel(s) for the HDLC frames.

For bridging something like voice, I think if I could break out an 
individual channel into
a bit-stream interface, I could just read bits off on one T1 channel and 
write to the other.
Preferably, I could also bond multiple channels (including an entire T1 
or E1) and bridge
it as raw bits too.

I think if I could support these scenarios below, I would have 
everything I need:

*  Configure T1 as unchannelized bitstream, bridge entire thing to 
second T1.

*  Configure channels 1-5 as a bitstream and bridge that to channels 1-5 
of a second T1.  (random proprietary bit-streaming protocol,
                     would probably bridge HDLC just fine, but handling 
HDLC as frames would be more efficient I think.)
    channels 6-10 configured as an HDLC interface, bridged as HDLC 
frames to channels 6-10 of a second T1. (PPP & other protocols over HDLC)
    channels 10-24 each configured as a separate bit-stream, bridged to 
channels 10-24 on the second T1. (Voice)

*  Configure entire T1 as HDLC transport, bridge HDLC frames from one T1 
to the other.

Does that make sense?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com> 
Candela Technologies Inc  http://www.candelatech.com


