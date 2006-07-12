Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWGLWfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWGLWfG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 18:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWGLWfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 18:35:06 -0400
Received: from [195.23.16.24] ([195.23.16.24]:62685 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S932198AbWGLWfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 18:35:04 -0400
Message-ID: <44B57914.5060805@grupopie.com>
Date: Wed, 12 Jul 2006 23:35:00 +0100
From: Paulo Marques <pmarques@grupopie.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: 7eggert@gmx.de
CC: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       pavel@ucw.cz, roubert@df.lth.se, stern@rowland.harvard.edu,
       dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Magic Alt-SysRq change in 2.6.18-rc1
References: <6wOHw-5gl-23@gated-at.bofh.it> <6x0yX-5An-17@gated-at.bofh.it> <6xc78-6gi-15@gated-at.bofh.it> <6xyhf-5Fq-1@gated-at.bofh.it> <6xyU6-6Hn-63@gated-at.bofh.it> <6xzdl-75B-13@gated-at.bofh.it> <6xzZO-8gU-23@gated-at.bofh.it> <6xA9p-8ti-7@gated-at.bofh.it> <6xACo-Op-1@gated-at.bofh.it> <6xAVM-1b9-5@gated-at.bofh.it> <6xBfh-1yd-29@gated-at.bofh.it> <6xBRQ-2v4-3@gated-at.bofh.it> <6xITm-4td-17@gated-at.bofh.it> <6xMX0-2bX-21@gated-at.bofh.it> <E1G0mrB-0001JL-T3@be1.lrz>
In-Reply-To: <E1G0mrB-0001JL-T3@be1.lrz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:
> Paulo Marques <pmarques@grupopie.com> wrote:
>[...]
>>This allows for all the combinations mentioned before in this thread and
>>makes the logic simpler, IMHO.
> 
> Why don't you use a bitmask?
> alt-sysrq down -> val  =  0b11
> sysrq up       -> val &= ~0b01
> alt up         -> val &= ~0b10
> 
> test is_sysrq == !!val

It can be done, but it doesn't seem to buy you much.

The sysrq_alt variable is used wether we use magic sysrq or not, so we 
must keep it anyway. This var doesn't do what your high bit does, 
because in the bit mask this bit only goes on when both are pressed (not 
just alt).

alt up is actually 2 different keys (left and right). To detect it, we 
either copy the same "if" that is outside the #ifdef or we try to follow 
the state of sysrq_alt to detect the change from low to high :P

Anyway, I think the code can be simplified further, though, and it might 
involve a similar trick. And it definitely needs some more comments in 
there ;)

I'll play with it some more and try to produce a better patch.

-- 
Paulo Marques
