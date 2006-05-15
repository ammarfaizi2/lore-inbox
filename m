Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWEOSuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWEOSuf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWEOSuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:50:35 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:1012 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932106AbWEOSud convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:50:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PZgpsBz6hFCaByw54C4HXeJ+W8GjsOfCs2f0XCCNZHxhJCapdI2nI8B55spXwW0BqObjbTMciS4GNo3NawBNoWBHOolkZCKo1YUulBUKaATzr7mwerlwHwu5l+dwG6ULVsR1/FaiUmFgNRxPfRlrs2ACUJUnPdJKAkhM+Fx/MhI=
Message-ID: <6bffcb0e0605151150y11002c0co7e8f1ea54a3ceb2b@mail.gmail.com>
Date: Mon, 15 May 2006 20:50:32 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Takashi Iwai" <tiwai@suse.de>
Subject: Re: 2.6.17-rc4-mm1
Cc: "Andrew Morton" <akpm@osdl.org>, perex@suse.cz,
       alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <s5hy7x341f8.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060515005637.00b54560.akpm@osdl.org>
	 <6bffcb0e0605150940l647273f0jf4e1b9d5737bbd2@mail.gmail.com>
	 <20060515100429.5069f6ca.akpm@osdl.org> <s5h3bfb5h73.wl%tiwai@suse.de>
	 <s5hy7x341f8.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/05/06, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 15 May 2006 19:30:24 +0200,
> I wrote:
> >
> > At Mon, 15 May 2006 10:04:29 -0700,
> > Andrew Morton wrote:
> > >
> > > "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On 15/05/06, Andrew Morton <akpm@osdl.org> wrote:
> > > > >
> > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm1/
> > > > >
> > > > > - This tree contains a large number of new bugs^H^H^H^Hpatches.
> > > > [snip]
> > > > >  git-alsa.patch
> > > >
> > > > BUG: sleeping function called from invalid context at
> > > > /usr/src/linux-mm/sound/core/info.c:117
> > > > in_atomic():1, irqs_disabled():0
> > > >  <c1003ef9> show_trace+0xd/0xf   <c100440c> dump_stack+0x17/0x19
> > > >   <c10178ce> __might_sleep+0x93/0x9d   <f988eeb5> snd_iprintf+0x1b/0x84 [snd]
> > > >   <f988d808> snd_card_module_info_read+0x34/0x4e [snd]   <f988f197>
> > > > snd_info_entry_open+0x20f/0x2cc [snd]
> > > >  <c1067a17> __dentry_open+0x133/0x260   <c1067bb7> nameidata_to_filp+0x1c/0x2e
> > > >  <c1067bf7> do_filp_open+0x2e/0x35   <c1068bf2> do_sys_open+0x54/0xd7
> > > >  <c1068ca1> sys_open+0x16/0x18   <c11dab67> sysenter_past_esp+0x54/0x75
> > > > Non-volatile memory driver v1.2
> > > >
> > > > Here is dmesg http://www.stardust.webpages.pl/files/mm/2.6.17-rc4-mm1/mm-dmesg
> > > > Here is config http://www.stardust.webpages.pl/files/mm/2.6.17-rc4-mm1/mm-config
> > >
> > > heh, yes, Takashi baited his hook and pulled in a big one.
> > >
> > > snd_card_module_info_read() calls snd_iprintf() under read_lock()..
> >
> > Ouch, I checked only spinlocks but forgot rwlocks.  Will fix them.
>
> The patch below should fix them (already merged in ALSA HG repo).
>
>

Problem fixed. Thanks!

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
