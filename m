Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265273AbUAOXxf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 18:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265274AbUAOXxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 18:53:35 -0500
Received: from cpc3-hitc2-5-0-cust116.lutn.cable.ntl.com ([81.99.82.116]:59335
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S265273AbUAOXxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 18:53:31 -0500
Message-ID: <40072EDC.2050604@reactivated.net>
Date: Fri, 16 Jan 2004 00:22:52 +0000
From: Daniel Drake <dan@reactivated.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ross@datscreative.com.au
Cc: Jesse Allen <the3dfxdude@hotmail.com>, Ian Kumlien <pomac@vapor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: NForce2, Ross Dickson's timer patch on 2.6.1
References: <200401140256.30727.ross@datscreative.com.au>
In-Reply-To: <200401140256.30727.ross@datscreative.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Dickson wrote:
> Given Daniel has had lockups with disconnect off.
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/4769.html
> And your machine no longer has them with disconnect on, then I now think the
> cause is something different to the AMD C1 disconnect issue, but what I do not
> know? I believe AMD are still looking into it as per my support request.

Hi Ross,

I feel that I should clarify your point here as I've got a bit confused myself 
as to which patch does what, etc!

I compiled 2.6.0-test11-mm1 with IOAPIC and APIC support (never had used these 
options before). Within minutes I met my first lockup ever on this PC. (This 
kernel included the other recent nforce2 patches: 
nforce2-disconnect-quirk.patch and +nforce2-apic.patch)

I then tried your patches with default settings, and I thought that the 
problem was solved, as you can see in the URL you referenced. That was a false 
alarm, I did then meet another lockup a few hours later, and another one a few 
hours after that. I then reverted out the nforce2-disconnect-quirk patch (as 
per your suggestion), and started booting with the apic_tack=2 argument.
See: http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/5259.html

No lockups since then, but I have been experiencing the clock skew.

But, there might be more to it. I had forgotten up until now, but I am using 
this code in my /etc/conf.d/local.start :
setpci -v -H1 -s 0:0.0 6F=$(printf %x $((0x$(setpci -H1 -s 0:0.0 6F) | 0x10)))

and this one in /etc/conf.d/local.stop :
setpci -v -H1 -s 0:0.0 6F=$(printf %x $((0x$(setpci -H1 -s 0:0.0 6F) & 0xef)))

I got these codes from 
http://www.tldp.org/HOWTO/Athlon-Powersaving-HOWTO/approaches.html#commandline 
a while back - they are supposed to enable powersaving and make your CPU run 
cooler. I ran a test when I originally started using this, and I did find that 
my CPU ran cooler when idle after I had ran these commands.

I don't know if this would influence my systems behaviour with/without the 
various patches that have been flying around.. but I hope you can make some 
sense out of it and continue bugging AMD/nvidia!

 > I would really like to hear from Nvidia on this issue, I have tried emailing
 > them, form mailing them and also posting to their linux forum with no 
success or
 > response. Given its been over a month since my first posting I am having
 > serious second thoughts about my choice of chipsets and motherboards!
 > I currently do not feel very warm and fuzzy about their linux support!

I'd certainly investigate a different type of chipset on my next board, if I 
knew of a manufacturer that they *would* approach issues like this one out in 
the open...

Daniel
