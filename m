Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267751AbUIBHZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267751AbUIBHZQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 03:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267754AbUIBHZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 03:25:16 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:27147 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S267751AbUIBHZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 03:25:05 -0400
Message-ID: <4136CBD0.1070701@hist.no>
Date: Thu, 02 Sep 2004 09:29:20 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
CC: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
References: <courier.41359B53.00007549@softhome.net>            <20040901095229.GA11908@devserv.devel.redhat.com> <courier.4135A19B.00007EA5@softhome.net> <4135B9FC.7050602@hist.no> <4135CEB4.5020102@softhome.net>
In-Reply-To: <4135CEB4.5020102@softhome.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ihar 'Philips' Filipau wrote:

>
>
>   Well. I given an example of device which doesn't fit into 
> read()/write() interface.
>
>   Your imagination is truely appreciated - and you are encouraged to 
> try to implement it. With full error handling (every write must be 
> checked)

Checking every write is up to the program using the device.  Not 
forgetting this is easy.
Never write directly to the device, use an interface function in your 
program that
both writes, reads status back, and returns that status.

>   and multithreading support (e.g. one user for movement, multiple for 
> monitoring and diagnosis).
>
In that case I'd use two device nodes.  One for the command/error stuff, 
and another for
monitoring.  The monitoring device could be read-only and support 
several simultaneous
openings.

>   I have tryed to some extent impelementing something like this - 
> amount of code doubled for no real gain. (It was in those times when 
> "ioctl()s are bad. period." topic poped up on lkml first time. long 
> time ago)

Of course you _can_ use ioctls.  Just do it if that's the only useable 
way.  Wether you can get code
like that merged depends on wether you can convince the right people.  
But your driver will work
fine even if you have to distribute it yourself, so it isn't that big a 
problem.

>
>   No one will ever design interface for sake of interface. what you 
> are proposing - probably will look nice in academical papers, but no 
> one will do it, and no one will do it in kernel space.
>
>   And all this stuff - all this funcy xml-like comlications? - for 
> what? just call one function of driver with single parameter - void*.
>   _*Not more*_. Ridiculous indeed.
>
I haven't suggested any xml, perhaps someone else did.  A write 
interface let you pass
almost anything into the driver.  My example used ascii messages, you 
might want to
pass structs instead.  I believe even pointers should work too.

> P.S. As I have said before, it seems to me that using read()/write() 
> instead of ioctl() could be the only choice. I once hacked read(): 
> user must pass two structures: first is input, second is output. It 
> worked - but no one (including me) liked it. ioctl() even by its name 
> fit better.

I have to agree it seems to fit.

Helge Hafting
