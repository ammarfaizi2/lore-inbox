Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbWGSRUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWGSRUr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 13:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbWGSRUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 13:20:47 -0400
Received: from kurby.webscope.com ([204.141.84.54]:22714 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S1030208AbWGSRUq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 13:20:46 -0400
Message-ID: <44BE699A.5000106@linuxtv.org>
Date: Wed, 19 Jul 2006 13:19:22 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Nish Aravamudan <nish.aravamudan@gmail.com>
CC: Alex Riesen <raa.lkml@gmail.com>, video4linux-list@redhat.com,
       Martin.vGagern@gmx.net, linux-kernel <linux-kernel@vger.kernel.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       v4l-dvb-maintainer@linuxtv.org,
       Alex Riesen <fork0@users.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [v4l-dvb-maintainer] Re: oops in bttv
References: <20060711204940.GA11497@steel.home>	<1152962993.26522.18.camel@praia>	<81b0412b0607170634p298ab59p3c52b8c9c0cc7661@mail.gmail.com> <29495f1d0607191009r736ed327y797e69ac4915e1e7@mail.gmail.com>
In-Reply-To: <29495f1d0607191009r736ed327y797e69ac4915e1e7@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nish Aravamudan wrote:
> On 7/17/06, Alex Riesen <raa.lkml@gmail.com> wrote:
>> On 7/15/06, Mauro Carvalho Chehab <mchehab@infradead.org> wrote:
>> > > What I did was to call settings of the flashplayer and press on the
>> > > webcam symbol there. The system didn't crash, just this oops:
>> > >
>> > > BUG: unable to handle kernel NULL pointer dereference at virtual
>> address 0000006
>> > > 5
>> > Hmm... Are you using it on what machine? It might be related to an
>> > improper handling at compat32 module.
>>
>> 32bit. PIV, 2Gb, highmem on.
> 
> Is this the same bug as http://bugzilla.kernel.org/show_bug.cgi?id=6869?

It LOOKS the same to me...  I have tried to reproduce this OOPS
unsuccessfully, but it seems to be happening for many other users.

I can't imagine why I am unable to reproduce it.

Hopefully Andrew will pull from Mauro's v4l-dvb.git for the new
changesets before he releases the next -mm...

The sanity checking cleanups have already been pushed up there:

http://www.kernel.org/git/?p=linux/kernel/git/mchehab/v4l-dvb.git;a=commitdiff;h=9c2f8a385c0bc40bf1f96edac32cc648d3a052fc;hp=0c445baf0daee379295adea8478278c0719e9c35

You might notice a tragic flaw in the previous code...
bttv_register_video was checking the return value on a void ...  Maybe
we'll get some better debug output after this patch gets out.

Cheers,

Michael Krufky

