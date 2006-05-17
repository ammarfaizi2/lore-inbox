Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWEQRKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWEQRKX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 13:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWEQRKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 13:10:23 -0400
Received: from mail.aknet.ru ([82.179.72.26]:8457 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1750730AbWEQRKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 13:10:22 -0400
Message-ID: <446B58F5.4020501@aknet.ru>
Date: Wed, 17 May 2006 21:10:13 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] add input_enable_device()
References: <20060517124450.84547.qmail@web81111.mail.mud.yahoo.com>
In-Reply-To: <20060517124450.84547.qmail@web81111.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Dmitry Torokhov wrote:
> I really believe that instead of shoving this into input core you need to
> split pcspkr driver to allow concurrent access to the hardware.
I split pcspkr and someone else will say that there is
already enough of the midlayers to handle the like things,
to not introduce another one just for the particular driver.
Besides, I don't beleive people will be happy with having
2 modules for just handling the terminal beeps.
The input midlayer looks like the best solution. It allows
to deal with the modules as soon as they are loaded. It has
enough of the information needed to precisely identify the
module (I now use INPUT_DEVICE_ID_MATCH_BUS). The pcspkr *is*
an "input driver" after all, so why not to deal with it via
an input API? If the input should not be used for anything
related to the port IO, then why it carries the information
about the ports and the bus that are used by the device?
Why does it have the INPUT_DEVICE_ID_MATCH_BUS after all?
The input API only lacks a very small piece of the functionality -
disabling the device, which can easily be used by anything else
in the future. Is there a reason not to include that functionality
only because the snd-pcsp is going to use it, or is there any *other*
reason?

