Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUG2Tg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUG2Tg1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 15:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbUG2Tg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 15:36:27 -0400
Received: from mail.convergence.de ([212.84.236.4]:24461 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S265027AbUG2Tf7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 15:35:59 -0400
Message-ID: <4109519A.1000201@convergence.de>
Date: Thu, 29 Jul 2004 21:35:54 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Johannes Stezenbach <js@convergence.de>
CC: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm1
References: <20040728020444.4dca7e23.akpm@osdl.org> <20040728222455.GC5878@convergence.de> <20040728224423.GJ12308@parcelfarce.linux.theplanet.co.uk> <20040728232453.GA6377@convergence.de>
In-Reply-To: <20040728232453.GA6377@convergence.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/29/04 01:24, Johannes Stezenbach wrote:
> On Wed, Jul 28, 2004 at 11:44:23PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
>>On Thu, Jul 29, 2004 at 12:24:55AM +0200, Johannes Stezenbach wrote:
>>
>>>Signed-off-by: Johannes Stezenbach <js@convergence.de>
>>>
>>>--- linux-2.6.8-rc2/drivers/media/dvb/dvb-core/dvb_functions.c.orig	2004-07-29 00:19:50.000000000 +0200
>>>+++ linux-2.6.8-rc2/drivers/media/dvb/dvb-core/dvb_functions.c	2004-07-29 00:20:05.000000000 +0200
>>>@@ -36,7 +36,7 @@ int dvb_usercopy(struct inode *inode, st
>>>         /*  Copy arguments into temp kernel buffer  */
>>>         switch (_IOC_DIR(cmd)) {
>>>         case _IOC_NONE:
>>>-                parg = NULL;
>>>+                parg = (void *) arg;
>>
>>Mind explaining why it is the right thing to do?  You are creating a kernel
>>pointer out of value passed to you by userland and feed it to a function
>>that expects a kernel pointer.  Which is an invitation for trouble - if
>>it ends up dereferenced, we are screwed and won't notice that.
> 
> 
> This is a hack introduced by someone years ago. The "pointer" is
> actually an integer argument, e.g. in include/linux/dvb/audio.h:
> 
> #define AUDIO_SET_MUTE             _IO('o', 6)
> 
> actually takes an integer argument (!0 mute, 0 unmute), so one can write
> 
> 	if (ioctl(fd, AUDIO_SET_MUTE, 1) == -1)
> 		perror("mute");
> 
> It is unusual (maybe even wrong?), but we cannot change it without
> losing binary API compatibility. However, I see that sparse might
> flag this as a possible bug :-(

Is this convenient trick considered harmful?
Or is it a creative way of using ioctls?

We're currently using this stuff in the overhauled DVB v4 API, too. So 
before we finally establish the DVB v4 API, I'd like to know if this is 
a no-no.

Comments?

CU
Michael.

