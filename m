Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWFLHs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWFLHs2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 03:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWFLHs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 03:48:28 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:57319 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750718AbWFLHs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 03:48:28 -0400
Message-ID: <448D1C9E.7050606@t-online.de>
Date: Mon, 12 Jun 2006 09:49:50 +0200
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 0/7] Detaching fbcon
References: <44856223.9010606@gmail.com> <448C19D7.5010706@t-online.de> <448C83AD.9060200@gmail.com>
In-Reply-To: <448C83AD.9060200@gmail.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-ID: b7EpDmZD8e5s0to7iwZTfgvMKBv8FwtPJjvmLQgijeoDpmtV6N0o8D@t-dialin.net
X-TOI-MSGID: 93fed4c6-5f5a-408d-ba69-f506eb229d45
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

>We'll use fb_restore_state and fb_save_state if available, yes, but I don't
>think we need to implement unbind and bind.  For one, as Jon and Andrew
>has pointed out, drivers should have no concept of binding. (That's why the
>patch has escalated to VT binding).
>
>  
>
Well, it does not matter if it´s the fbcon or vt layer that does the
binding. I agree with Jon and Andrew that vt binding is the better
way.

>And why force drivers to have an fb_restore_state/fb_save_state just to
>unbind/bind?  This is going to penalize 10's of drivers that don't need
>it.  Just make this feature an experimental kconfig option, or make this
>available as a boot option.
>  
>
An experimental feature could be "Allow all framebuffer drivers to unbind".
Non-experimental behaviour really should be to allow unbinding
only if the framebuffer driver allows it. The fbcon and vt layer simply
does not know if it is safe, and thus they have to interrogate the
hardware layer that knows the answer.

Your current proposal is to allow unbinding and removal of the framebuffer
driver and the fbcon layer, no matter what the result will be. I don´t think
that this is ok.  There is  John User that tries to switch to text mode, and
he will complain if it does leave his hardware in an unusable state.

I suggest to add the fb_unbinding / fb_binding fbops and to only allow
unbinding if we know that it will not leave the video hardware in a state
that is unusable for proper operation.

If there is nothing to be done inside those two fbops, they simply return
0.

Other framebuffer drivers set the hardware to a state that is completely
unusable by a textmode console and that is incompatible with X. These
might need to know if X is active to decide if unbinding makes any sense at
that specific moment. They can know that by adding the save/restore_state
fbops. No, I don´t think that the save/restore_state fbops should be 
required
for unbinding operations, I think you misunderstood me in that place.

cu,
 knut
