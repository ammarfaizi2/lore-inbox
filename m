Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbUCDUOw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 15:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbUCDUOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 15:14:52 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:56716 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S262113AbUCDUOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 15:14:50 -0500
From: Gerhard Jaeger <gerhard@gjaeger.de>
To: large <large@lilymarleen.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Patch: Plustek scanner driver (pt_drv) port to 2.6, correction for 2.6.3
Date: Thu, 4 Mar 2004 21:12:26 +0100
User-Agent: KMail/1.5.1
Cc: Domen Puncer <domen@coderock.org>
References: <4047490F.8050504@lilymarleen.de>
In-Reply-To: <4047490F.8050504@lilymarleen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403042112.26770.gerhard@gjaeger.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm,

I don't think that this patch is necessary anymore. The latest driver
is contained in the sane-backends package. The backend is called
plustek_pp can can either be used completely from userspace or if
you want to as kernel-module (including all the patches for 2.6
kernel, except devfs support).

Ciao,
  Gerhard

On Thursday 04 March 2004 16:19, large wrote:
> Hi,
>
> I recently updated from 2.6.0-test4 to 2.6.3 and noticed that my pt_drv
> won't work any more. It did not load, telling me something like
> missing symbol: kdev_t_to_nr
>
> I investigated and found the problem:
> the inline function kdev_t_to_nr does not exist any longer, I think it's
> depr. due to the kdev device changes in 2.6.3 (2.6.2?).
>
> ptdrv.c:
> 255: int minor = MINOR(kdev_t_to_nr(ip->i_rdev));
>
> Anyway, I could not figure out what function might be it's successor, so
> I simply removed the function call, leading to:
>
> ptdrv.c:
> 225: int minor = MINOR(ip->i_rdev);
>
> All kdev_t.h functions existing in 2.6.3 did only bad stuff to the
> numbers so think this might be correct.
>
> I just removed it, as it works for me (and should logically, reviewing
> how the MINOR inline works now). I could not test it with more than one
> scanner device, so it might still be false.
>
> Anyone out there who can proof whether this is OK like this?
>
> Attached the changed patch...
>
> cu,
> ~  Lars

