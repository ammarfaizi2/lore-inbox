Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265554AbUALVxt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 16:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265635AbUALVxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 16:53:49 -0500
Received: from chaos.analogic.com ([204.178.40.224]:10112 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265554AbUALVxq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 16:53:46 -0500
Date: Mon, 12 Jan 2004 16:54:05 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Ian Pilcher <i.pilcher@comcast.net>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: initialize data not at file scope - WTF?
In-Reply-To: <4003131E.1090408@comcast.net>
Message-ID: <Pine.LNX.4.53.0401121644190.6412@chaos>
References: <4003131E.1090408@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jan 2004, Ian Pilcher wrote:

> In include/linux/init.h, it says:
>
>    For initialized data:
>    You should insert __initdata between the variable name and equal
>    sign followed by value, e.g.:
>
>    static int init_variable __initdata = 0;
>    static char linux_logo[] __initdata = { 0x32, 0x36, ... };
>
>    Don't forget to initialize data not at file scope, i.e. within a
>    function, as gcc otherwise puts the data into the bss section and not
>    into the init section.
>
> Does this mean that __initdata can't be used for file scope variables,
> that it can only be used for file scope variables, or something else?
>
> Thanks!

Data, not at file-scope, means data like this:

	int foo()
        {
            static int bar = 0;
        }

Bar is private to function foo(). It does not have file-scope.
However, it is static and therefore is expected to persist over
multiple calls to foo. It, therefore, does not exist on the
stack as local data. Instead, it is normally put in ".bss" or
".data" depending upon initialization.

If you want this data to go away after initialization, you
declare it as:

            static int bar __initdata = 0;;

Any data you want to go away after initialization, including
file-scope data, can get the __initdata attribute. FYI, this
puts the data in a special segment that gets freed after
initialization. The idea is to save RAM.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


