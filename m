Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265249AbRHWOBY>; Thu, 23 Aug 2001 10:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266488AbRHWOBO>; Thu, 23 Aug 2001 10:01:14 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:16581 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S265249AbRHWOA6>; Thu, 23 Aug 2001 10:00:58 -0400
Message-ID: <3B850C9A.7080002@redhat.com>
Date: Thu, 23 Aug 2001 10:00:58 -0400
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andris Pavenis <pavenis@latnet.lv>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: i810 audio doesn't work with 2.4.9
In-Reply-To: <E15ZGQv-0008Qb-00@the-village.bc.nu> <200108220848.f7M8mVh00441@hal.astr.lu.lv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andris Pavenis wrote:

> Got incremental diffs between ac versions since 2.4.5.
> Applied all diffs to 2.4.5 version of i810_audio.c except one between 2.4.6-ac1 and 2.4.6-ac2
> As result i810 audio seems to work

Can you send me that incremental patch you left out.  I would like to 
look at it to see what's going on.

> So it seems that update of i810_audio.c between 2.4.6-ac1 and ac2 breaks it (at least for me).
> But I think it still eating too much time (about 2-3% on PIII 700) when I'm not doing anything 
> with sound but no more up to 90% as with unmodified version from 2.4.9 (maybe it's a problem
> of artsd , I don't know)


Yes, it's a problem of artsd.  Someone decided (presumably to avoid the 
occasional pop/click from the startup or shutdown of the sound device) 
to make artsd transmit silence over the sound card when no sounds 
currently need played.  From my perspective, I will *NEVER* use artsd as 
long as it does this.  I find it so extremely stupid and insane to a 
level that can't be measured that I refuse to run that software.  I 
absolutely will not have my systems PCI bus loaded down with a constant 
data transfer when there is no sound to be played.  Right now, that's 
possibly something as small as a 48KHz/16bit data stream.  But what if 
the system is upgraded to an ac3 5.1 digital system.  Then you would 
have something like 384KByte/s of data to transfer over the PCI bus just 
for frickin silence.  Won't ever happen on any machine I use.  Anyone 
trying to do things like disk benchmarks on a system that runs artsd may 
be suprised to find their performance is actually negatively impacted 
just by having that horrible sound daemon running.  Furthermore, I find 
their use of the sound API to be suboptimal, especially when they are 
going to transmit silence all the time.  I am *FAR* happier with the way 
esd actually handles its interaction with the sound card (other issues 
are a different matter, I don't rightly know which one does better sound 
sample upconversion for instance).


-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

