Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWFNFL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWFNFL1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 01:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWFNFL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 01:11:27 -0400
Received: from 066-241-084-054.bus.ashlandfiber.net ([66.241.84.54]:50315 "EHLO
	bigred.russwhit.org") by vger.kernel.org with ESMTP id S964873AbWFNFL0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 01:11:26 -0400
Date: Tue, 13 Jun 2006 22:09:19 -0700 (PDT)
From: Russell Whitaker <russ@ashlandhome.net>
X-X-Sender: russ@bigred.russwhit.org
To: Willy Tarreau <w@1wt.eu>
cc: Brice Goglin <Brice.Goglin@ens-lyon.org>, Avuton Olrich <avuton@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16.19 + gcc-4.1.1
In-Reply-To: <20060614042007.GD13255@w.ods.org>
Message-ID: <Pine.LNX.4.63.0606132153100.2373@bigred.russwhit.org>
References: <Pine.LNX.4.63.0606131906230.2368@bigred.russwhit.org>
 <3aa654a40606132049u43f81ee1m263ee15666246152@mail.gmail.com>
 <448F8C53.5010406@ens-lyon.org> <20060614042007.GD13255@w.ods.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 Jun 2006, Willy Tarreau wrote:

> On Wed, Jun 14, 2006 at 12:10:59AM -0400, Brice Goglin wrote:
>> Avuton Olrich wrote:
>>> On 6/13/06, Russell Whitaker <russ@ashlandhome.net> wrote:
>>>> Then, after mrproper, rebuilt with gcc-4.1.1, no other changes.
>>>>    compiles ok, installs ok. But, when attempting to load a module, get
>>>>    the following message:  version magic '2.6.16.19via K6 gcc-4.1',
>>>>    should be '2.6.16.19via 486 gcc-3.3'
>>>
>>> You may have forgotten to "make modules modules_install"
>>
>> Actually, "make modules" does not exist anymore with 2.6. Both built-in
>> and modular stuff are built at the same time.
>> Only "make modules_install" is still required.
>
> What's this bullshit ?
>
> $ grep ^modules: Makefile
> modules: $(vmlinux-dirs) $(if $(KBUILD_BUILTIN),vmlinux)
> modules: $(module-dirs)
>
> Avuton is right, you *have* forgotten to make modules.
>
>> Brice
>
> Willy
>
After found the above problem, did it all again to be sure:

   make mrproper
   rm -r /lib/modules/*
   cp ../config-2.6.16.19 .config
   make menuconfig    ( made sure it's same config, then saved without
                        changes )
   make
   make modules
   make modules_install
   make bzlilo

Same result.
   russ
