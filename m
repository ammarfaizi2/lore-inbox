Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWIMOZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWIMOZi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 10:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbWIMOZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 10:25:38 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:27817 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750865AbWIMOZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 10:25:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ij3apQz/diGt2ZUmuLvDuRcQKYAKFWlFQOr17UI6TQxf6kmr/2BLKM9Q9ypIPCKW0fvkjbKYKR19fojBQ4Y2uG313lW3MQVj+2pttiPL5Phwln23LLI8UaKQw0FBycpttIjBHJsEMyg+9BJRs+RZvFIzD7U5KwDjoLhSPAxmwso=
Message-ID: <653402b90609130725i10a47accy854d677188b5d7a8@mail.gmail.com>
Date: Wed, 13 Sep 2006 16:25:37 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Ben Dooks" <ben-linux@fluff.org>
Subject: Re: [PATCH V3] LCD Display Driver lcddisplay, ks0108, cfag12864b
Cc: greg@kroah.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20060913140639.GA26265@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060912193212.1407209b.maxextreme@gmail.com>
	 <20060913140639.GA26265@home.fluff.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please reply in the last patch version, subject:

[PATCH 2/2] drivers: LCD Display support.

On 9/13/06, Ben Dooks <ben-linux@fluff.org> wrote:
> I think there would be a case for splitting the lcd
> drivers into two layers, one to deal with the hardware
> talking to an lcd device (such as an parallel port)
> and the second to deal with the command sequences
> being sent.
>

It is divided already in two layers:

ks0108.c -> It is the driver for a LCD controller. It deals with the
hardware (not directly, it uses parport module). It exports the
functions defined for such controller to other modules.

cfag12864b.c -> It is a LCD driver, depends on ks0108. This is the
driver that tells what and how to write.

> For instance, we have two boards based on ARM which
> use a CPLD to decode CS1 and CS2, etc. This would
> mean re-writing your driver (and anyone elses)
> depending on what sort of LCD we would like to
> connect to these.
>

I don't think so. The ks0108 controller driver was built to control
the LCD using the parallel port and a specific wiring.

If you want to use your boards, write a driver for them. What is the problem.

(Please tell me if I misunderstood you)

> If there was an generic device driver, then you
> could export the writing of bytes to user-space
> and have them use the hardware to do any protocol
> they liked.
>

A generic driver for what? There are many different ports/wirings,
different LCDs displays, different LCD controllers, different
protocols...

I didn't understand what do you mean.
