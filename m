Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262588AbVBBPse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262588AbVBBPse (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 10:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbVBBPpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 10:45:41 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:47912 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262488AbVBBPo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 10:44:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=gm3ZdFP1xLILZHXJzNiJmzRQ9pvK2vJ2GtDjp3v+tzJ+aAE//RR+k4lqNZImmhrJibfJpLaMXWyWLWZhwopEv3TZlArj384YUrcJkGy8rhjh4oG5uJD4gakYsQDzq2DahZy4yUK1COuR9qGn8JjGhPsTF2K6Pbt7MQHTl//mfac=
Message-ID: <d120d50005020207443ceb8704@mail.gmail.com>
Date: Wed, 2 Feb 2005 10:44:55 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Victor Hahn <victorhahn@web.de>
Subject: Re: Really annoying bug in the mouse driver
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4200A9F3.80908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41E91795.9060609@web.de>
	 <200502011819.12304.dtor_core@ameritech.net> <42006E79.7070503@web.de>
	 <200502020126.37621.dtor_core@ameritech.net> <4200A9F3.80908@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Feb 2005 11:22:43 +0100, Victor Hahn <victorhahn@web.de> wrote:
> Dmitry Torokhov wrote:
> 
> >It still complains in dmesg about throwing away bytes, right? Please try
> >loading the box some more to make sure mouse survives some abuse.
> >
> >
> 
> No, it doesn't. The only message I still get is the one below. I've
> tried it with aprox. 90% CPU usage already and I didn't have any
> additional problems.
>

Processor load we usually handle well, loaded disks are usually the
ones that cause >= 0.5 sec delays between bytes received by psmouse.
Please let me know if it still works with busy disks.

> >>kernel: psmouse.c: bad data from KBC - bad parity
> >>
> >>
> >Your keyboard controller reported that the byte transmitted from the mouse
> >was mangled somehow and we should not trust it. I am not sure why it would
> >make mouse jump.. was there any mention of "reconnect" in the logs? Did it
> >happen just once?
> >
> 
> It happened once when I was at the computer and several times while I
> wasn't.

Well, we won't be able to do anythng about parity errors themselves
but hopefully the patch will make them almost invisible for you. I
wonder if the jump could be explained by having a byte with 2 bits
flipped. KBC then would not detect parity error and psmouse would
process the byte as if it was good. This should not be happening too
often.

> There's no "reconnect" in the logs:
> 
> victor@vic:~$ cat /var/log/messages | grep reconnect
> victor@vic:~$

Ok, I was wondering if you hit parity error twice in a row and it
decided to reconnect.

-- 
Dmitry
