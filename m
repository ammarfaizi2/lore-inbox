Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbWIIXnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWIIXnv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 19:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWIIXnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 19:43:50 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:50531 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965019AbWIIXnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 19:43:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o65zV3u2WUD6WVhfznsDpr1kYZEynkqfDtY9iKTIDylCAwsHFTA0IirTtcFbat9fBWDFQ1CDqBTF5k1GGON9tNnmngPG/GUUS5Q5IfzUythOPHXFa3hEuxg6ucXS3BHHvIhXVuV8KxtpW3xgsWcOF0lJvvdjHPi0f1wD5x6nXhY=
Message-ID: <653402b90609091643j780b116bva15e857959353585@mail.gmail.com>
Date: Sun, 10 Sep 2006 01:43:48 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Driver - cfag12864b Crystalfontz 128x64 2-color Graphic LCD
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1157846186.6877.82.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <653402b90609081010k19598ce7ta1f64f3060ad4700@mail.gmail.com>
	 <1157818217.6877.56.camel@localhost.localdomain>
	 <653402b90609091614p371dc60ub7c52d0910cf106@mail.gmail.com>
	 <1157846186.6877.82.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Sul, 2006-09-10 am 01:14 +0200, ysgrifennodd Miguel Ojeda:
> > parport_register_device() "The PARPORT_DEV_EXCL flag is for preventing
> > port sharing, and so should only be used when sharing the port with
> > other device drivers is impossible and would lead to incorrect
> > behaviour. Use it sparingly!"
>
> This is the one you want. It's there for things like parallel port
> quickcams.

>
> > Ok, easier that way. In fact, the conversion function takes just 20
> > lines... I can provide it as an example with the driver. Is the
> > Documentation/* the right place?
>
> If its only 20 lines why not, in fact if its that short it might be fine
> in kernel too.
>

Fast and clear! Thank you so much.

Just a last question: The conversion function, should I code it as a
"exported function" via ioctl (copying the boolean matrix to kernel
space, converting it and sending it back to user space), or as a
second special device (like /dev/cfag..matrix)?

Because of the problems I explained of waiting for all the matrix to
start converting and sending it, I think the first option is better:
The user-space program can ask for the conversion via ioctl and then
send it to the normal device it whenever it wants.
