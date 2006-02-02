Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWBBRTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWBBRTA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 12:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWBBRTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 12:19:00 -0500
Received: from mail.bio.unipd.it ([147.162.3.2]:18327 "EHLO mail.bio.unipd.it")
	by vger.kernel.org with ESMTP id S932184AbWBBRS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 12:18:59 -0500
Message-ID: <43E23F30.9070604@bio.unipd.it>
Date: Thu, 02 Feb 2006 18:19:44 +0100
From: "Fabio d'Alessi" <cars@bio.unipd.it>
Organization: Department of Biology, University of Padova - Italy.
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel BUG at lib/kernel_lock.c:199!
References: <43E2217B.9050404@bio.unipd.it> <9a8748490602020904m10d5a1e6h4e343ed7fbc71c87@mail.gmail.com>
In-Reply-To: <9a8748490602020904m10d5a1e6h4e343ed7fbc71c87@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jesper,
okay I will see if I can resolve this issue by removing the
module (and, obviously, making it so that it does not get
loaded at all). One more thing I noticed way up in the message
log (hadn't noticed them at first):

Feb  2 15:32:53 telethon ainit: Memory: Failed to release semaphore
Feb  2 15:32:53 telethon ainit: Error: No such file or directory
Feb  2 15:32:53 telethon ainit: Memory: Failed to release SHM segment
Feb  2 15:32:53 telethon ainit: Error: No such file or directory
Feb  2 15:32:53 telethon ainit: Memory: Failed to release SHM segment
Feb  2 15:32:53 telethon ainit: Error: No such file or directory
Feb  2 15:32:53 telethon ainit: No such file or directory
Feb  2 15:32:53 telethon ainit: Memory: Failed to release semaphore
Feb  2 15:32:53 telethon ainit: Error: No such file or directory
Feb  2 15:32:53 telethon ainit: Memory: Failed to release SHM segment
Feb  2 15:32:53 telethon ainit: Error: No such file or directory
Feb  2 15:32:53 telethon ainit: Memory: Failed to release SHM segment
Feb  2 15:32:53 telethon ainit: Error: No such file or directory
Feb  2 15:32:53 telethon ainit: No such file or directory

looked it up on google and it seems to be related to a bug
that causes the kernel to lock under various circumstances,
see http://lkml.org/lkml/2006/1/12/282

I wonder if it's related to the hardlock I'm having here.

Thanks again for the kind feedback.

fda




Jesper Juhl wrote:
> On 2/2/06, Fabio d'Alessi <cars@bio.unipd.it> wrote:
>> Dear sirs,
>> I have a problem with a dual athlon xp running fedora/4
>> with the 2.6.14-1 kernel. Hard locks. Please if anyone
> [...]
>> [7.1] standard fedora 4 install - nothing new added, just the
>> drivers for the nv graphic board.
>>
> Adding the binary only nvidia module is not a little thing.
> That driver is a closed source binary blob that noone here has a
> chance to debug.
> 
> You can switch to the 'nv' driver and see if you still have the
> problem. The nv driver won't give you accelerated 3D, but for 2D it
> should work just fine.
> 
> [...]
>> nvidia 4095984 12 - Live 0xf8f31000
> [...]
> Please try to reproduce without the nvidia driver ever being loaded -
> just unloading it is *not* good enough, it needs to have never been
> loaded at all.
> As long as that (or any other binary-only module for that matter) has
> been loaded into the kernel for just a second it's impossible to say
> if that module or some other part of the kernel is the cause of the
> problem.
> 
> 
> --
> Jesper Juhl <jesper.juhl@gmail.com>
> Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
> Plain text mails only, please      http://www.expita.com/nomime.html
> 
