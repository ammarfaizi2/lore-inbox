Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278285AbRJMNO0>; Sat, 13 Oct 2001 09:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278287AbRJMNOP>; Sat, 13 Oct 2001 09:14:15 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:52644 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S278285AbRJMNOJ>; Sat, 13 Oct 2001 09:14:09 -0400
Message-ID: <3BC83E3F.6010203@Informatik.FH-Hamburg.de>
Date: Sat, 13 Oct 2001 15:14:39 +0200
From: Nico Dummer <Nico.Dummer@Informatik.FH-Hamburg.de>
Reply-To: Nico.Dummer@T-Online.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:0.9.5+) Gecko/20011011
X-Accept-Language: de,en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: write/read cache raid5
In-Reply-To: <Pine.LNX.4.40.0110082309400.28345-100000@ddx.a2000.nu> <E15qhyE-0001ws-00@the-village.bc.nu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>>protected, battery backed, ECC'd etc. That is one place where things like
>>>the DPT (now Adaptec) millenium hardware raid can do a lot better than
>>>software solutions

>>So there is no way i can Speedup write to the raid5 array ?
>>(memory will be ecc and the server will be on ups)

> And you have no ECC on the PCI bus, nor will a UPS protect against a crash.

You have this Problem anyway with or without Writecaching, the only 
difference is that it will exist longer with Writecaching turned on than 
without it.

Something to think about:

A possible Solution for this Problem is to get 2 Raid5 Arrays, a Primary 
Array for fast writing and a Secondary for fast reading.
All incoming Data will be written to a Rambuffer and the Primary Array 
while Reads are handled by the Secondary (or by the Rambuffer for Data 
not written to the Secondary). In times with fewer load on the Secondary 
Array the Data can be written from Rambuffer to it.
The Data is save at the Point where it´s on the Primary Array while you 
have unblocked Performance for Reads, in case of a crash the Secondary 
Array need to be synced with the Primary.
A list with unsynced blocks can replace the Writebuffer to take more 
Cachebuffers for Reads and so reduce load on the Secondary Array that 
can be used for syncing.
You will get the Security of 1 Raid5 Array if the Data is unsynced and 
the Security of a mirrored Raid5 Array during low load times so the 
Money wont be completely wasted only for Performance.
Would be nice if you guys consider Writecaching as an Option for this 
configuration too if most possible Security isnt needed or can be low 
for a few Seconds between buffering and writing. Let the People choose, 
they will do the right decision for themselves.

