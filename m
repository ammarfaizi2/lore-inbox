Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWCTWYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWCTWYq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWCTWYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:24:46 -0500
Received: from main.gmane.org ([80.91.229.2]:59579 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751312AbWCTWYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:24:44 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Happe <andreashappe@snikt.net>
Subject: Re: Announcing crypto suspend
Date: Mon, 20 Mar 2006 22:24:28 +0000 (UTC)
Message-ID: <slrne1uass.ffs.andreashappe@localhost.localdomain>
References: <20060320080439.GA4653@elf.ucw.cz> <200603202126.23861.rjw@sisk.pl> <20060320203507.GF24523@elf.ucw.cz> <200603202222.14634.rjw@sisk.pl> <20060320213400.GI24523@elf.ucw.cz> <441F2727.6020407@gmail.com>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: chello062178006202.3.11.tuwien.teleweb.at
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-03-20, Alon Bar-Lev <alon.barlev@gmail.com> wrote:
> Pavel Machek wrote:
> > Of course, agreed. Encrypting filesystem is stupid thing from
>> data-recovery standpoint; and I care about my data; it is also hard to
>> backup. For some uses it is of course neccessary, but it has lots of
>> disadvantages, too.
>
> Suspend is a feature that is most used by the mobile community.
> Disk encryption is also common for most of this community.

And it still is a PITA backup wise. There's nothing wrong with the stuff
Pavel said.

> Calling your clients stupid is not wise!

He hasn't done that.

>> [I believe we should encrypt swap with random key generated on boot by
>> default. That should be also very cheap, and has no real
>> disadvantages].
>
> Well... Good thinking... But how do you plan to encrypt the
> swap? There are about 1000 ways to do this...

* natively in the swap implementation (easier for end-users)
* distributions should do this through initramfs and dm-crypt (as long
  as this is done by distributions it is still easy for end users)

> Jari Ruusu had written the loop-aes which was not merged...

> From a similar reason suspend2 was rejected by you.
>
> I hope you don't think that file-system encryption should be
> implemented in user mode too...

I don't think that you followed the discussion or understand the reasons
behind uswsusp. If there's a (performance-wise) sane way to put
encryption (only the data translation) into userspace without copying of
buffers and too many context switches why not? But this won't happen.

> The dm-crypt is weak...

If you mean the IV schemes: as I understand it, this was mostly done to
stay compatible to cryptoloop. You are free to submit a patch that adds
another mode to dm_crypt.

> So we left with specific encryption implementation of swsusp... And
> now you offer a specific encryption for swap as well... Why not
> realize that there should be one encryption solution for block devices
> in kernel?

As well as swsusp-encryption is concerned this should be _userspace_ and
they can reuse libopenssl or such.

> As a result of this mess the mobile community uses external solutions.

I'm quite happy with dm_crypt + pam_mount. Works transparent and like a
charm. Don't know what your requirements are.

> Best Regards, Alon Bar-Lev.

cheers,
andreas happe
-- 
"With the proper course of action made so explicit, we had merely to choose
between wisdom and folly.  Precisely how we chose folly in this instance is
not entirely clear."			someone on penny-arcade.com

