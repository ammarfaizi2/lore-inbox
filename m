Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135171AbRDLPci>; Thu, 12 Apr 2001 11:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135172AbRDLPcT>; Thu, 12 Apr 2001 11:32:19 -0400
Received: from [204.178.40.224] ([204.178.40.224]:17024 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S135171AbRDLPcI>; Thu, 12 Apr 2001 11:32:08 -0400
Date: Thu, 12 Apr 2001 11:28:28 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: johan.adolfsson@axis.com
cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: List of all-zero .data variables in linux-2.4.3 available
In-Reply-To: <070001c0c35f$201f3740$a8b270d5@homeip.net>
Message-ID: <Pine.LNX.3.95.1010412111144.10857A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2001 johan.adolfsson@axis.com wrote:

> Shouldn't a compiler be able to deal with this instead?
> (Just a thought.)
> /Johan

The compiler does deal with it. That's why you have a choice when
you write code.

The defacto standard has been that initialized data, regardless of
whether it's initialized with zero, goes into the ".data" area (segment).
Non initialized data, that gets zeroed at run-time goes into
the ".bss" area.

If you declare a file-scope variable as:

	int foo;

it goes into '.bss'.

If you declare it as:

	int foo = 0;

it goes into '.data'.

Data that is in '.data' occupies space in the executable image. With
the kernel, it makes the kernel larger than necessary.

Data that is in '.bss' is just a single long int in the file header.
It tells the loader how much space to allocate and zero. There is
quite an obvious advantage to using '.bss' when possible, rather
than '.data'.

At one time, data that was declared as:

	int foo;

may, or may not, have been initialized to zero. This was "implementation
defined". Therefore we were taught to always initialize these variables.

The C98 standard now requires that such variables be initialized to
zero so you don't need to do this anymore. This allows such variables
to be put into space that is allocated at run-time, making executable
files shorter.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


