Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWGLWz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWGLWz5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 18:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWGLWz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 18:55:57 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:35174 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932354AbWGLWz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 18:55:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gFdr/s8LV5pcYQC8QFxz71/rArtx/qM5JrpUARVBstBxKC+DTEbo7seXMAlRdLKl/yQBbaxGcpKIBC6+2zlKbdobHVZrQYhkbmZ3hXPkiOGRD8C2CzrG+z32pmekBNzKLipu2s23dyAVfdzBDvQ9J0aPloZ85lEhDjQQz5lQ27s=
Message-ID: <6bffcb0e0607121555n20a9df53q8589109024629f7a@mail.gmail.com>
Date: Thu, 13 Jul 2006 00:55:55 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b0943d9e0607120917pa0c191aw5814a19b9e6f31fd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <b0943d9e0607110702p60f5bf3fg910304bfe06ec168@mail.gmail.com>
	 <6bffcb0e0607110802w4f423854rb340227331084596@mail.gmail.com>
	 <b0943d9e0607110844m6278da6crdc03bccce420da1d@mail.gmail.com>
	 <6bffcb0e0607110902u4e24a4f2jc6acf2eb4c3bae93@mail.gmail.com>
	 <b0943d9e0607110931n4ce1c569x83aa134e2889926c@mail.gmail.com>
	 <6bffcb0e0607111000q228673a9kcbc6c91f76331885@mail.gmail.com>
	 <b0943d9e0607111454l1f9919eahbb3b683492a651e@mail.gmail.com>
	 <6bffcb0e0607120435x31eceab7r3fdb055a7bee6da2@mail.gmail.com>
	 <b0943d9e0607120917pa0c191aw5814a19b9e6f31fd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 12/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > BTW I have _very_ annoying soft lockup. Can you fix that?
> >
> > Jul 12 13:15:47 ltg01-fedora kernel: printk: 1527 messages suppressed.
> > Jul 12 13:15:47 ltg01-fedora kernel: ipt_hook: happy cracking.
> > Jul 12 13:15:56 ltg01-fedora kernel: printk: 1631 messages suppressed.
> > Jul 12 13:15:56 ltg01-fedora kernel: Neighbour table overflow.
> >
> > I don't know why, but clock goes mad.
> >
> > Jul 12 14:08:21 ltg01-fedora kernel: BUG: soft lockup detected on CPU#0!
>
> Maybe the soft lockup report is cause by the clock change (it doesn't
> show any kmemleak functions in the backtrace).

I can't reproduce this on clean 2.6.18-rc1.

> You could change
> SCAN_BLOCK_SIZE in memleak.c to a smaller value as the scanning is
> done with the interrupt disabled.

I have tried
#define SCAN_BLOCK_SIZE         2048
and
#define SCAN_BLOCK_SIZE         1024
Unfortunately it doesn't change anything.

> I'll try tomorrow on my platforms with the soft lockup enabled.

Please try something like this
on tty1
isic -s rand -d your ip (http://www.packetfactory.net/Projects/ISIC/)
on tty2
kml_collector (http://www.stardust.webpages.pl/files/o_bugs/kml/ml/kml_collector.sh)

(I have tried to read random files from /sys on vanilla kernel, but I
can't reproduce that lockup)

>
> --
> Catalin
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
