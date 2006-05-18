Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWERR6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWERR6E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 13:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWERR6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 13:58:04 -0400
Received: from mail.aknet.ru ([82.179.72.26]:29196 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S932108AbWERR6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 13:58:03 -0400
Message-ID: <446CB5A4.7090603@aknet.ru>
Date: Thu, 18 May 2006 21:57:56 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] add input_enable_device()
References: <20060518122944.66148.qmail@web81114.mail.mud.yahoo.com>
In-Reply-To: <20060518122944.66148.qmail@web81114.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> Yes, you are right. INPUT_DEVICE_ID_MATCH_BUS will not likely
> benefit anyone.
And according to the impression I've got, it should
therefore be removed, sure? :)

> Consider this: pcspkr is broken at the moment as it does not
> handle several simultaneous events well. If you fix it do behave
> properly with SND_TONE and SND_BELL arriving at the same time
> then adding hooks to the speaker code for snd-pcsp should be
> pretty easy. See?
I see the point but not the practicle solution. request_region()
won't work as the ports are already claimed by other drivers.
Resolving this inside pcspkr.c won't help snd-pcsp, as it will
add the dependancy if some internal API is used.
The real problem is that whereever I'll solve that, this will be
a hack, because normally two drivers should not compete for the
IO resourses, disable each other, race etc.
So I give it up. I'll just disable pcspkr in the Kconfig and
whoever wants both snd-pcsp and the beeps, will need to install
the user-space daemon which uses uinput. I have yet to find such
a daemon...

