Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317024AbSF1C7N>; Thu, 27 Jun 2002 22:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317037AbSF1C7M>; Thu, 27 Jun 2002 22:59:12 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:43727 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S317024AbSF1C7K>; Thu, 27 Jun 2002 22:59:10 -0400
Date: Thu, 27 Jun 2002 21:01:29 -0600 (MDT)
From: "Hurwitz Justin W." <hurwitz@lanl.gov>
To: linux-kernel@vger.kernel.org
Subject: Re: zero-copy networking & a performance drop
Message-ID: <Pine.LNX.4.44.0206271943340.24818-100000@alvie-mail.lanl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In a mail that wasn't CC'd to me Bernd said:
>
> In article <Pine.LNX.4.44.0206271146280.9500-100000@alvie-mail.lanl.gov> you wrote: 
>> Previous tests have show that we can transmit IP packets easily at around 
>> 1.4 Gbit, but we can only receive at about 0.9 Gbit. We suspect there is a 
>> memory copy somewhere either in the quadrics IP driver (covered by an NDA, 
>> sorry), or in the IP stack after netif_rx() is called. I've looked at the 
>> driver, and, upon a (good) cursory inspection, it looks good. 
>
> You have to sign a NDA for a hardware which bahaves slower than expected and 
> then u seek help in the open community? I would ask you to bother the 
> manufacturer, so they know about this problem and solve it. After all, if 
> you have to pay for it you should actually USE their service. 
>
> AFAIK only a few methods like sendfile support zero copy ip. 
>
> But on the other hand, if the card works by memory sharing perhaps TCP/IP is 
> simply the wrong api to speak to that device? 
>

Your mail begs a reply, to defend both my work, and the hardware that I'm
working on (and company behind it)- no offense is intended, and none was
taken. I feel that, in a community, such as this, where the immediate
response (which I do share) to letters like NDA is disgust, a bit of
defense where it is appropriate is an always on-topic reminder of their
occasional legitimacy.

There are three points in your mail to which I need reply- the NDA, the
performance of the hardware (esp. wrt TCP/IP), and my requesting the help
of the open source community.

I agree that NDAs are dangerous, often ill-conceived, and usually counter-
productive devices of intellectual monopoly (e.g., Broadcom's refusal to
share Tigon3 information). That said they can serve a legitimate purpose,
especially when you are not talking about commodity products. Quadrics
products are not commodity- I'd be surprised if anyone reading this has
quadrics hardware in any general use (commodity) machine. The material
covered under the NDA (of which the IP driver is a trivial part)
represents an important part of Quadrics' unique product line. They do
have legitimate reason to keep this code out of their competitors' hands;
we are not their competitors, and they have given us access to their code, 
provided that we do not share it with their competitors. 

You are very right in saying that TCP/IP is the wrong api for this 
hardware. We achieve significantly better performance with MPI. But we 
have applications that could significantly benefit from having TCP/IP 
available; being able to run TCP/IP on quadrics based clusters will open 
up new possibilities for us- hence this is of research interest for us. 

Another consequence of your point is that Quadrics does not have a direct
interest in developing TCP/IP for their hardware; it is not part of their
design for the hardware, and they cannot be expected to provide a top
notch driver to do what we want, just because we want it- their hardware
does what it is supposed to do; we're trying to get it to do the
unexpected. Initial research shows that we should be able to get twice the
performance out of TCP/IP on this hardware than we currently do. Quadrics
has helped us get this far, despite the fact that they did not design
their hardware for this purpose- that's much more than I expect from most
companies.

Which brings me to my work. I am not trying to get the open source
community's help to make a propreitary driver work. As I said before,
Quadrics' driver does look to be of good quality- I do not believe that
the problem necessarily lies there. I am trying to determine why there is
so large a disparity between send and receive performance when using this
driver in the linux kernel. As indicated in a previous reply to my
question, this asymmetry might be inherent to the kernel. If it is, my job
is become to try to eliminate or reduce this asymmetry. That work, if
sucessful, will be returned to the kernel. As you certainly know, TCP only
performs as well as the slowest side of the connection- reducing asymmetry
could offer significant performance gains.

Hope this clarifies my intent, repudiates any indication that the Quadrics
hardware is underperforming, and justifies the NDA :) It's a lot to do.  
I _am_ an open source developer (I learned how to program while hacking
SCSI drivers in the kernel's pre-1.0 days); and I do believe that
Quadrics' NDA is legitimate, and that they are not the bad-guys. 

Cheers,
--Gus

PS- You are right about sendfile() and zero-copy IP. 

