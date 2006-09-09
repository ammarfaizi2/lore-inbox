Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbWIIXOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWIIXOg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 19:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbWIIXOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 19:14:36 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:33306 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964996AbWIIXOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 19:14:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fKf228NwhDMlnXor/PmCaUT+m/BZEr9KCPs9K+KYLB2cEoiwBR9iEx3TAzWfYeLTWADNlhQX+kF/yPPEGZNK3Kg8pFcyUepKkbI8KIaBjXopUt5NYvyYGg3d4VrKdVQn2yPdxdHCoLftUlSaMM8j9qmYnCWbbB/lHnraiac/xIo=
Message-ID: <653402b90609091614p371dc60ub7c52d0910cf106@mail.gmail.com>
Date: Sun, 10 Sep 2006 01:14:34 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Driver - cfag12864b Crystalfontz 128x64 2-color Graphic LCD
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1157818217.6877.56.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <653402b90609081010k19598ce7ta1f64f3060ad4700@mail.gmail.com>
	 <1157818217.6877.56.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> The parport interface exists precisely to generalise these uses of the
> parport.

I have read the parport documentation (The Linux 2.4 Parallel Port
Subsystem), and they state that parport shares the port with other
devices using a standard (IEEE 1284). Here is where the problem comes:

Because the wiring of the LCD is completely practical (the parport was
used because it has many output lines that are enough for taking with
the LCD), it doesn't follow any kind of standard (like answering ACKs
and so on), so I am not sure the LCD is going to work well with the
parport driver and its "special signals" it sends to the data port. I
will check it.

Anyway, I have also thought this: If you load the cfag12864b driver
before parport, both will be fine: The LCD driver will use the port it
needs, and the parport will take care of all the others left. I have
already tried it and it works fine. cfag12864b requests 0x378 for
example, and then parport requests all the others, forgetting 0x378.

Still, I have found there is a flag in parport that is used to prevent
port just for one device:

parport_register_device() "The PARPORT_DEV_EXCL flag is for preventing
port sharing, and so should only be used when sharing the port with
other device drivers is impossible and would lead to incorrect
behaviour. Use it sparingly!"

I don't know what would be better, if use the parport interface and
such flag, or load my driver before parport requesting the port
directly with request_region. What do you think?


> You usually want format conversion done in user space as it is more
> flexible that way. X has all the right framework for this so you could
> even have fun with X11 on it ;)

Ok, easier that way. In fact, the conversion function takes just 20
lines... I can provide it as an example with the driver. Is the
Documentation/* the right place?


> A good place to start is kernelnewbies.org, and when you are happy with
> it post it somewhere for more general review.


I have checked it out and I have talked a little bit at
#kernelnewbies, and they told me also to check the
Documentation/Sending*.

I will send it to review to somewhere (still I don't know exactly to
whom, I thought this was the right place) and then to akpm, as
Doc/Sending* states.


Thank you for your time.

       Miguel Ojeda
