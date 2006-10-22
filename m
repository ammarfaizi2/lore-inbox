Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWJVXJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWJVXJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 19:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWJVXJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 19:09:59 -0400
Received: from web55615.mail.re4.yahoo.com ([206.190.58.239]:38544 "HELO
	web55615.mail.re4.yahoo.com") by vger.kernel.org with SMTP
	id S1750716AbWJVXJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 19:09:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=LPskGQiB7b4ev59yT2s5COSnXY7v7BGjuOKuOLDG39cj8wDvE8SvOH98IxzdKG40QzXF37HqTt7eDYyJ/OQDGMnG/q9x7OVfSlc+kBKTNYoJ8R2CAsLRL+Z//OpbYsBIW52YrhywCwB68MNIhJNe+oWQO4m6uAJEik4tXZXTvXw=  ;
Message-ID: <20061022230957.78480.qmail@web55615.mail.re4.yahoo.com>
Date: Sun, 22 Oct 2006 16:09:56 -0700 (PDT)
From: Amit Choudhary <amit2030@yahoo.com>
Subject: Re: Hopefully, kmalloc() will always succeed, but if it doesn't then....
To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0610222306240.22903@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> 
> $ make -C /erk/kernel/linux-2.6.19-rc2 M=$PWD
>   CC [M]  /dev/shm/test.o
> /dev/shm/test.c: In function ‘func’:
> /dev/shm/test.c:4: warning: ‘b’ may be used uninitialized in this 
> function
> 

It would be nice if this warning can be seen in all the cases without doing anything extra. But
sometimes I do not see it.

I compiled sound/pci/mixart/mixart_hwdep.c - did "make modules".

It has the following code but I did not get any warnings.

static int mixart_enum_connectors(struct mixart_mgr *mgr)
{
        u32 k;
        int err;
        struct mixart_msg request;
        struct mixart_enum_connector_resp *connector;
        struct mixart_audio_info_req  *audio_info_req;
        struct mixart_audio_info_resp *audio_info;

        connector = kmalloc(sizeof(*connector), GFP_KERNEL);
        audio_info_req = kmalloc(sizeof(*audio_info_req), GFP_KERNEL);
        audio_info = kmalloc(sizeof(*audio_info), GFP_KERNEL);
        if (! connector || ! audio_info_req || ! audio_info) {
                err = -ENOMEM;
                goto __error;
        }

root@zephyr-7 linux-2.6.19-rc1]# make modules
scripts/kconfig/conf -s arch/i386/Kconfig
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  ...
  CC [M]  sound/pci/mixart/mixart.o
  CC [M]  sound/pci/mixart/mixart_core.o
  CC [M]  sound/pci/mixart/mixart_hwdep.o
  CC [M]  sound/pci/mixart/mixart_mixer.o
  LD [M]  sound/pci/mixart/snd-mixart.o
  Building modules, stage 2.
  MODPOST 44 modules
  CC      sound/core/snd-hwdep.mod.o
  LD [M]  sound/core/snd-hwdep.ko
  ...
[root@zephyr-7 linux-2.6.19-rc1]#

Regards,
Amit



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
