Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbUKQAI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbUKQAI2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 19:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbUKQAGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 19:06:40 -0500
Received: from fire.osdl.org ([65.172.181.4]:42116 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262139AbUKPXtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 18:49:20 -0500
Message-ID: <419A8EFE.8060508@osdl.org>
Date: Tue, 16 Nov 2004 15:36:30 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: akpm <akpm@osdl.org>, ak@suse.de, lkml <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Subject: Re: [PATCH] PCI: fix build errors with CONFIG_PCI=n
References: <419A8088.3010205@osdl.org> <20041116232600.GB2868@pclin040.win.tue.nl>
In-Reply-To: <20041116232600.GB2868@pclin040.win.tue.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> On Tue, Nov 16, 2004 at 02:34:48PM -0800, Randy.Dunlap wrote:
> 
>>Fix (most of) kernel build for CONFIG_PCI=n.  Fixes these 3 errors:
>>
>>1. drivers/parport/parport_pc.c:3162: error: `parport_init_mode'
>>undeclared (first use in this function)
> 
> 
> Life is easier if you do not use attachments.
> (Then I can more easily comment the code.)

I understand.  If the decision were only so simple.

> You write
> 
>   -static int __init parport_init_mode_setup(const char *str) {
>   -
>   +#ifdef CONFIG_PCI
>   +static int __init parport_init_mode_setup(const char *str)
> 
> In my tree I have
> 
>   static int __init parport_init_mode_setup(char *str) {
> 
> in order to avoid the warning for
> 
>   __setup("parport_init_mode=",parport_init_mode_setup);
> 
> since the parameter is a int (*setup_func)(char *); - see
> 
>   struct obs_kernel_param {
>         const char *str;
>         int (*setup_func)(char *);
>         int early;
>   };

Yes, I'm familiar with that, but I made a patch against current
top of tree.

> Apart from this prototype change I only moved the single line
> 
>   static int __initdata parport_init_mode = 0;
> 
> outside the #ifdef's. Is that not good enough, and better
> than introducing more #ifdef's? Keeps the source smaller.

It can be good enough.  It keeps the source smaller, at
the expense of adding some unneeded code (the
parport_init_mode_setup() function e.g.).

-- 
~Randy
