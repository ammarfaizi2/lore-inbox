Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269082AbRHFWoe>; Mon, 6 Aug 2001 18:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269099AbRHFWoY>; Mon, 6 Aug 2001 18:44:24 -0400
Received: from karnov.quicksilver.com ([207.38.32.18]:27397 "EHLO
	karnov.quicksilver.com") by vger.kernel.org with ESMTP
	id <S269082AbRHFWoN>; Mon, 6 Aug 2001 18:44:13 -0400
Message-Id: <v03010d03b794cd1af75a@[192.168.1.18]>
In-Reply-To: <20010806030520.153282B54A@marcus.pants.nu>
In-Reply-To: <29464.997040507@ocs3.ocs-net> from "Keith Owens" at Aug 06,
 2001 05:41:47 AM
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 6 Aug 2001 15:43:47 -0700
To: flar@pants.nu (Brad Boyer), kaos@ocs.com.au (Keith Owens)
From: Rob Barris <rbarris@quicksilver.com>
Subject: Re: PPC? (Was: Re: [RFC] /proc/ksyms change for IA64)
Cc: kaih@khms.westfalen.de (Kai Henningsen), linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 8:05 PM -0700 8/5/01, Brad Boyer wrote:
>Keith Owens wrote:
>> On 05 Aug 2001 11:29:00 +0200,
>> kaih@khms.westfalen.de (Kai Henningsen) wrote:
>> >kaos@ocs.com.au (Keith Owens)  wrote on 02.08.01 in
>><22165.996722560@kao2.melbourne.sgi.com>:
>> >
>> >> The IA64 use of descriptors for function pointers has bitten ksymoops.
>> >> For those not familiar with IA64, &func points to a descriptor
>> >> containing { &code, &data_context }.
>> >
>> >That sounds suspiciously like what I remember from PPC. How is this solved
>> >on the PPC side?
>>
>> Best guess, without access to a PPC box, is that it is not solved.  Any
>> arch where function pointers go via a descriptor will have this
>> problem.
>>
>> PPC users, does /proc/ksyms contain the address of the function code or
>> the address of a descriptor which points to the code?  It is easy to
>> tell, if function entries in /proc/ksyms are close together (8-128
>> bytes apart) and do not match the addresses in System.map then PPC has
>> the same problem as IA64.  If this is true, what is the layout of a PPC
>> function descriptor so I can handle that case as well?
>
>This is what the MacOS does on ppc, but it's specific to the MacOS, and
>is part of the way the MacOS seamlessly integrates 68k code and ppc code
>so that they didn't have to have both 68k and ppc versions of all the
>system calls. This was basically a trick to pack in extra information
>along with a function pointer to tell the Mixed Mode Manager if it needed
>to run the 68k emulator and also how to setup the right context. I'm
>pretty sure that Linux just does the normal address for function pointers
>just like most other architectures.

   The idea of a 'transition vector' to refer to a piece of code (and the
proper data-globals area to go with it) came part and parcel from the IBM
AIX runtime model, and had nothing to do with a MixedMode routine
descriptor as you describe above.  The two are separate beasts.

   A MixedMode descriptor helps classic MacOS handle all of the arguments,
stack layout, and return value issues when hopping from one processor
architecture to another at runtime.  Transition vectors are used far more
often, for any old inter-library call (for example, every app call to the
OS, even when both caller and callee are PPC native).


--
Rob Barris       Quicksilver Software Inc.      rbarris@quicksilver.com


