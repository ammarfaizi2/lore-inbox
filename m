Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbVLLROe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbVLLROe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 12:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbVLLROe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 12:14:34 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:20295 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751275AbVLLROd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 12:14:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tG2cs2lM/kpKQd3+a7N+/Eicu+AtZl/UwoF+SpmaSUj3ArkHAWMBu0tjtem2qbqXiVwqcE+EOykDz42cz6TJgx9exoEgsqpaJgeRNHns5s6xzc8SBQRQWnbhhGWrndho2pVUOW5bbYQPcTlMYfNvye0GrALkQt5I+bDObfE5+3I=
Message-ID: <9a8748490512120914v494b9fdcy459e90b1704f1757@mail.gmail.com>
Date: Mon, 12 Dec 2005 18:14:31 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Mouse stalls with 2.6.5-rc5-mm2
Cc: LKML List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <200512112250.44848.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490512110548h22889559ld81374f2626c3ed2@mail.gmail.com>
	 <200512111327.40578.dtor_core@ameritech.net>
	 <9a8748490512111149l358f18abuc7f0685413f75c06@mail.gmail.com>
	 <200512112250.44848.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> On Sunday 11 December 2005 14:49, Jesper Juhl wrote:
> > well, unplugging the mouse from the KVM and plugging it into the PC's
> > PS/2 port directly resulted in this in dmesg :
> >
> > [ 567.297724] psmouse.c: Explorer Mouse at isa0060/serio1/input0 lost
> > synchronization, throwing 1 bytes away.
> > [ 567.807251] psmouse.c: resync failed, issuing reconnect request
> > [ 568.015721] logips2pp: Detected unknown logitech mouse model 87
> >
> > and after that I see no more resync failed messages and the mouse doesn't stall.
> >
>
> Ok, so your KVM fakes the response to POLL command. But normally
> (with resync disabled) your mouse works just fine with your KVM,
> you can still use wheel after switching between the boxes, right?

The wheel works fine after switching away and back.


> If so I will try adjusting my patch.
>
> In the mean time could you please try the tiny patch below - it
> shoudl get rid of "unknown logitech mouse" message. Could you send
> me your dmesg after applying the patch?
>

Patch seems to do its job :

$ dmesg | grep -i mouse
[   24.039229] mice: PS/2 mouse device common for all mice
[   24.790995] input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
[  192.060997] psmouse.c: Explorer Mouse at isa0060/serio1/input0 lost
synchronization, throwing 1 bytes away.
[  192.569915] psmouse.c: resync failed, issuing reconnect request


Thanks.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
