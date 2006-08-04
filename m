Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWHDLEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWHDLEK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 07:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWHDLEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 07:04:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:45791 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751420AbWHDLEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 07:04:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PGU1v1KQrKZyxPZ0eU++Uv2T3HdGRv60KMzrZJILnhyyGzCwiUqIdvLH0oFJiJghRBrDytrAUaG/FtTvVgdsAZXUBgRGw0RF/+SGDEIBkkop7lVylXUVbfUhfCzEyLBmubqU47Bkb5ajoJd6zG7L0Xi2+VMscJ1fIadgOQKrX+g=
Message-ID: <62b0912f0608040404p59545a0asc7f5fc5f537ec32c@mail.gmail.com>
Date: Fri, 4 Aug 2006 13:04:07 +0200
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: "Auke Kok" <auke-jan.h.kok@intel.com>
Subject: Re: e100: checksum mismatch on 82551ER rev10
Cc: "Charlie Brady" <charlieb@budge.apana.org.au>,
       NetDev <netdev@vger.kernel.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <44D0D7CA.2060001@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.61.0607311653360.24450@e-smith.charlieb.ott.istop.com>
	 <44D0D7CA.2060001@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Auke Kok wrote:
> Charlie Brady wrote:
> > Let's assume that these things are all true, and the NIC currently does
> > not work perfectly, just imperfectly, but acceptably. With the recent
> > driver change, it now does not work at all. That's surely a bug in the
> > driver.
>
> There is no logic in that sentence at all. You're saying that the driver is
> broken because it doesn't fix an error in the EEPROM?

It's broken because it bails completely instead of just emitting a
warning message.

You wouldn't believe the number of hours people spend out there trying
to get a Linux box up when there's no network access.  Bailing out and
completely disabling the hardware on checksum errors is shooting those
people in the foot, because they'll need to try and debug the driver,
or the hardware, or do something completely else, perhaps on an
embedded device, and you're basically telling them "We at Intel do not
want to allow you to even attempt to make this your hardware work.".
By refusing to add an option to NOT bail, you're adding "And we're
happy to handicap any attempts you might make at it.".

> We're trying extremely hard to fix real errors here

You're not fixing anything, you're creating a problem for the user, sorry.

> (especially when we find that hardware resellers send out
> hardware with EEPROM problems) and you are asking for
> a workaround that will (likely) introduce random errors
> and failure into your kernel.

You've established yourself that the most likely cause of the error is
that the vendor forgot to run a checksumming tool.  That's hardly
random errors and failure.  You're trying to pull Linux end users into
a war between Intel and it's vendors, so you can make end users scream
at the vendors when they forget to run the checksum tool.  Well,
perhaps you should drop that and instead make it so that the *tools*
bail when the checksum is wrong, not the end user's driver.

> If you want to recalculate the checksum yourself and
> put it in the EEPROM then I am also fine with that.

Could you please provide a method and/or tool to do that?

> But we can't support an option that allows all users to willingly enable
> a piece of non-properly-working hardware.

The tactful thing to do would be to put out a big fat error message
during boot, but not bailing.
If you're worried that the end user might not see the message, then
bail, but provide an option to load anyway.
This is the only constructive and meaningful way forward.  There's no
point in holding the end user hostage.

> The bottom line is that your problem is that a specific hardware vendor
> is/was selling badly configured hardware, and you buy it from them, even
> after it's End Of Lifed for that vendor. Even though that vendor did buy the units
> properly configured and had all the tools needed to configure them properly.

There's no way for me to make Nokia do anything about this problem.
Please don't try to drag me into a Intel vs vendors war just for the
purpose of making me a number in their statistics.
(Maybe you could improve your tools so they'll want to fix the checksum.)

> I can maybe fix your problem by seeing if we can get you an eeprom update

Any chance you could get one of those for me?

(Yeah, I do realize that I'm critizicing and then asking for help.  Cocky :-D.)
