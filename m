Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131569AbRCVE3C>; Wed, 21 Mar 2001 23:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131655AbRCVE2x>; Wed, 21 Mar 2001 23:28:53 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:41818 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S131569AbRCVE2q>; Wed, 21 Mar 2001 23:28:46 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Manoj Sontakke <manojs@sasken.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: initialisation code 
In-Reply-To: Your message of "Thu, 22 Mar 2001 14:59:31 +0530."
             <Pine.LNX.4.21.0103221453140.1382-100000@pcc65.sasi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 22 Mar 2001 15:27:53 +1100
Message-ID: <17644.985235273@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2001 14:59:31 +0530 (IST), 
Manoj Sontakke <manojs@sasken.com> wrote:
>On Wed, 21 Mar 2001, Keith Owens wrote:
>> Welcome to the wonderful world of magic initialisation.
>> 
>> (1) Declare your initialisation function as int __init foo_init(void).
>> (2) Decide when your function needs to be called, e.g. after initialisers
>>     for A, B, C but before initialisers for X, Y, Z.
>
>where do i find this ABC abs XYZ ?

You coded it, you know what kernel facilities must be initialised
before your program (ABC) and what kernel code cannot be initialised
until after your program (XYZ).

>What if I have to make it as an insertable/removable module?

static int __init foo_init(void) {
  ...
}

module_init(foo_init);

Automatically generates the correct code for a built in object and for
a module.  See include/linux/init.h and almost any drivers/net/*.c,
plip.c is a good example.

>> 
>> (3) Edit the Makefile to insert obj-$(CONFIG_FOO) after the objects
>>     that contain initialisers A, B, C and before the objects for
>>     initialisers X, Y, Z.
>
>Do I need to edit the .config file to add CONFIG_FOO=y ?

Do not edit .config, it is generated.  Edit a [Cc]onfig.in file, read
Documentation/kbuild/config-language.txt and look at the [Cc]onfig.in
file in the directory where you are putting your source.  Do not forget
to update Documentation/Configure.help.

