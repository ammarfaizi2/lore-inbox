Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264890AbSKTXgQ>; Wed, 20 Nov 2002 18:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264665AbSKTXgQ>; Wed, 20 Nov 2002 18:36:16 -0500
Received: from chaos.analogic.com ([204.178.40.224]:13952 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264628AbSKTXgM>; Wed, 20 Nov 2002 18:36:12 -0500
Date: Wed, 20 Nov 2002 18:43:28 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Patrick Mansfield <patmans@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: getting text strings into __initdata for char *foo = "data"
In-Reply-To: <20021120144343.A23601@eng2.beaverton.ibm.com>
Message-ID: <Pine.LNX.3.95.1021120183530.3694A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2002, Patrick Mansfield wrote:

> Hi -
> 
> Is there a way to get char * initialized data to go into the init
> data section?
> 
> For example, in the following I want init_foobar and its associated
> text strings to go into the init data section, not just the pointers
> in init_foobar:
> 

[SNIPPED...]




I use assembler when I need to do things 'C' doesn't want
to do.. like:

.section .init.data
.global foo
.type foo,@object
.size foo,11
foo: .string	"1234567890"

This will work for ".sections" like .data, etc,. but the
object file in empty when I use .init.data. This is probably
because gas treats .string specially. I know you can do this
with ".byte". You don't have to make the assembly by hand.

I do something like:

#ifdef THIS_WILL_NEVER_BE_DEFINED
char foo[]="This is the string..."
#else
extern char foo[];
#endif

I write a 'C' program that looks for "THIS_WILL_NEVER_BE_DEFINED"
and writes gas assembly for the strings up to the "#else".

I do this in an embedded system to put many/most/all strings
in NVRAM PROM.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


