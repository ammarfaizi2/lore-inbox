Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278170AbRJRVcM>; Thu, 18 Oct 2001 17:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278172AbRJRVbx>; Thu, 18 Oct 2001 17:31:53 -0400
Received: from otter.mbay.net ([206.40.79.2]:16910 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S278170AbRJRVbp> convert rfc822-to-8bit;
	Thu, 18 Oct 2001 17:31:45 -0400
From: John Alvord <jalvo@mbay.net>
To: Patrick Mochel <mochelp@infinity.powertie.org>
Cc: Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] New Driver Model for 2.5
Date: Thu, 18 Oct 2001 14:32:14 -0700
Message-ID: <pbiust45nr5rtsl7d8qlf6gu8p8er91gtj@4ax.com>
In-Reply-To: <p05100309b7f4cd5976f7@[10.128.7.49]> <Pine.LNX.4.21.0110181237360.17191-100000@marty.infinity.powertie.org>
In-Reply-To: <Pine.LNX.4.21.0110181237360.17191-100000@marty.infinity.powertie.org>
X-Mailer: Forte Agent 1.8/32.553
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2001 12:49:01 -0700 (PDT), Patrick Mochel
<mochelp@infinity.powertie.org> wrote:

>
>> The "state of all the devices in the system". Presumably, while you 
>> walk the tree the first time (to save state) interrupts are enabled, 
>> and devices are active. Operations (including interrupts) on the 
>> device can, presumably, change the state of the device after its 
>> state has been saved.
>
>Ya, I'm an idiot sometimes. I relized this just as I was leaving for
>lunch. I almost turned around to come back and answer..
>
>This is what I had in mind; If someone could give me a thumbs-up or
>thumbs-down on whether or not this would work:
>
>When the driver gets a save_state request, that is its notification that
>it is going to sleep. It should then stop/finish all I/O requests. It
>should then prevent itself from taking any more - by setting a flag or
>whatever. Then, device save state. 
>
>>From that point in, it should know not to take any requests, theoretically
>preserving state. 
>
>When it gets the restore_state() call, it should first restore device
>state. Once it does that, it knows that it can take I/O requests again. 
>
>That should work, right?
>
>The only thing that that won't work for is the device to which we're
>saving state, like the disk. At some point, though we have to accept that
>the state that we saved was some checkpoint in the past, and it won't
>reflect the state that changed in the process of writing the system state.

Maybe each driver could pass back a value indicating

1) all done
2) N milliseconds more, please

and you could keep calling until every driver says all done. The
all-done drivers would ignore any new interrupts. The Not-Yet drivers
could get the last few interrupts the need to complete. Of course
there would need to be an overall timeout. That would leave most of
the responsibility with the drivers... who know most of the true
requirements.

john alvord
