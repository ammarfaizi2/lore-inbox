Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423743AbWKHVAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423743AbWKHVAQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 16:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbWKHVAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 16:00:15 -0500
Received: from smtp10.dc2.safesecureweb.com ([65.36.255.234]:11471 "EHLO
	smtp10.dc2.safesecureweb.com") by vger.kernel.org with ESMTP
	id S932748AbWKHVAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 16:00:14 -0500
Message-ID: <00fc01c70378$d1ffa760$0732700a@djlaptop>
From: "Richard B. Johnson" <jmodem@AbominableFirebug.com>
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>,
       "'Jesper Juhl'" <jesper.juhl@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
References: <02fd01c70370$d9af6700$020120ac@Jocke>
Subject: Re: How to compile module params into kernel?
Date: Wed, 8 Nov 2006 15:59:44 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Jesper Juhl'" <jesper.juhl@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, November 08, 2006 3:02 PM
Subject: RE: How to compile module params into kernel?


>> -----Original Message-----
>> From: Jesper Juhl [mailto:jesper.juhl@gmail.com]
>>
>> On 08/11/06, Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
>> > Instead of passing a module param on the cmdline I want to
>> compile that
>> > into
>> > the kernel, but I can't figure out how.
>> >
>> > The module param I want compile into kernel is
>> > rtc-ds1307.force=0,0x68
>> >
>> > This is for an embeddet target that doesn't have loadable module
>> > support.
>> >
>> You could edit the module source and hardcode default values.
>>
>
> Yes, but I don't want to do that since it makes maintance
> harder.
>
> Jocke
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

If you don't have a module, you can not use module parameters. However, it 
might even be simpler...
You just put your parameters (strings to parse) on the kernel command-line 
and you put code in your driver to interpret them.

You want to look at "saved_command_line." It is a string as:
extern char saved_command_line[COMMAND_LINE_SIZE];
You need to parse ASCII text yourself, in your driver, but it's trivial. 
Look at .../arch/i386/kernel/setup.c parse_cmdline_early().
I don't see anywhere in the kernel that it gets overwritten so it should be 
good to use.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 (somewhere). IT removed email  for 
engineers!
New Book: http://www.AbominableFirebug.com




