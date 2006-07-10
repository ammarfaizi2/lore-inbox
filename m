Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422639AbWGJOmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422639AbWGJOmh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 10:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161176AbWGJOmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 10:42:36 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:13540 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161165AbWGJOmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 10:42:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=MLCnCmXBeANxw8T6DMg6Hgl9UPHY5zVN0t8Phcd560S6L8x1ZrUyC+EK5pUvKNZQoRWWRUKAB5Tu6ohKBFUrDLBcRI786kM682wSgjkiO6Kfz2Gu3t9SJgpBj//MDPSPMfhEclA+gAAxSYIuHq68eOu8eFWClWnDEMqlNEqWMPc=
Message-ID: <44B26752.9000507@gmail.com>
Date: Mon, 10 Jul 2006 22:42:26 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Clean up old names in tty code to current names
References: <9e4733910607092111i4c41c610u8b9df5b917cca02c@mail.gmail.com>	 <1152524657.27368.108.camel@localhost.localdomain>	 <9e4733910607100541i744dd744n16c35c50dae1e98d@mail.gmail.com>	 <1152537049.27368.119.camel@localhost.localdomain>	 <9e4733910607100603r5ae1a21ex1a2fa0f045424fd1@mail.gmail.com>	 <1152539034.27368.124.camel@localhost.localdomain> <9e4733910607100707g4810a86boa93a5b6b0b1a8d0a@mail.gmail.com>
In-Reply-To: <9e4733910607100707g4810a86boa93a5b6b0b1a8d0a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 7/10/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> Ar Llu, 2006-07-10 am 09:03 -0400, ysgrifennodd Jon Smirl:
>> > I agree with this. I made a mistake with the pts vs pty, why not just
>> > help me fix the mistake instead of rejecting everything? Some the of
>> > the info being reported in /proc/tty/drivers is wrong (vc./0 - from
>> > the devfs attempt?). or missing.
>>
>> What are you trying to achieve and where are you trying to get. If you
>> want better info for the tty layer then get the new info working in
>> sysfs first. Then when people are generally using sysfs you can worry
>> about cleaning up/removing/breaking the old stuff.
>>
> 
> Before the change /proc/tty/drivers shows this:
> 
> [jonsmirl@jonsmirl ~]$ cat /proc/tty/drivers
> /dev/tty             /dev/tty        5       0 system:/dev/tty
> /dev/console         /dev/console    5       1 system:console
> /dev/ptmx            /dev/ptmx       5       2 system
> /dev/vc/0            /dev/vc/0       4       0 system:vtmaster

vtmaster was /dev/tty0 in 2.2.x, changed to /dev/vc/0 probably
because of devfs. I would tend to agree with the change of at least
this part.

A few apps do rely on /proc/tty/drivers for the major-minor
to device name mapping. /dev/vc/0 does not exist (unless
created manually) without devfs.

Tony
