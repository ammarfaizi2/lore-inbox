Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267668AbUJTNnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267668AbUJTNnu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 09:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270199AbUJTNnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 09:43:11 -0400
Received: from chaos.analogic.com ([204.178.40.224]:10624 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S270070AbUJTM47
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 08:56:59 -0400
Date: Wed, 20 Oct 2004 08:56:28 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Tomas Carnecky <tom@dbservice.com>
cc: Oliver Neukum <oliver@neukum.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: my opinion about VGA devices
In-Reply-To: <41765A8C.2020309@dbservice.com>
Message-ID: <Pine.LNX.4.61.0410200851080.10711@chaos.analogic.com>
References: <417590F3.1070807@dbservice.com> <200410201318.26430.oliver@neukum.org>
 <41765A8C.2020309@dbservice.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004, Tomas Carnecky wrote:

> Oliver Neukum wrote:
>> Am Mittwoch, 20. Oktober 2004 00:10 schrieb Tomas Carnecky:
>> 
>>> I think this would make the suspend/resume/access/switching etc problems 
>>> much easier to solve since the kernel module could tell the library to 
>>> stop drawing/accessing mmap'ed memory etc. (or if the OpenGL rendering is 
>>> done in the kernel module it could just discard the render commands).
>>> Since the user has no direct access to mmap'ed memory and other critical 
>>> sections of the device, the driver can implement proper power managment 
>>> for suspend/resume etc.
>>> 
>>> Well... that's it.. any comments? I'm sure you have.. :)
>> 
>> 
>> You are making damn sure that there will be no useful bug reports
>> about problems with resuming from S3.
>> 
>
> I guess that you are talking about the fact that displaying text messages 
> would be possible only after the first device driver has initialized and 
> registered with the kernel.
>
> You could do the printing in two stages: at the begining the same way as in 
> the current kernel, but as soon as the first driver is registered, the kernel 
> switches to the function provided by the driver.
>
> Something like this:
>
> void print_message(...)
> {
>   if (no_module_registered) {
>      use_print_function_provided_by_the_kernel();
>   } else {
>      if (!printing_disabled) {
>         use_print_function_provided_by_the_driver_module();
>      } else {
>         /* printing disabled by the userspace, we are not
>          * allowed to touch the hardware */
>      }
>   }
> }
>
> tom

On ix86 machines, regardless of whatever code initialized the
hardware, if the screen-card is not put into graphics mode,
anybody can write characters and attributes at 0xb8000 directly
to the screen. Even user-mode code can mmap() that area and write
to it. So, the key seems to be to get out of graphics mode
before suspend, and go back later after resume.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 GrumpyMips).
                  98.36% of all statistics are fiction.
