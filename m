Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWGQVfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWGQVfa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 17:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWGQVfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 17:35:30 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:13892 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750760AbWGQVfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 17:35:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=hZgk1JYa5rzvnX6oTNJpgFnyJyR4cW5EVrEHuXJBfD+WV9/GUbYx7647oilHCcdLNk1iaNbBVa1+kUm4GtGSAjzrkdCFDqbCzcLdDFIIT5+Ybf2klXH80CeJa7pXFIYG23p4MFkzPBvE0b75hXG3vWug/P5n85g2Nsso9LHvRJg=
From: Benjamin Cherian <benjamin.cherian.kernel@gmail.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Bug with USB proc_bulk in 2.4 kernel
Date: Mon, 17 Jul 2006 14:35:21 -0700
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@sourceforge.net
References: <mailman.1152332281.24203.linux-kernel2news@redhat.com> <200607101258.34005.benjamin.cherian.kernel@gmail.com> <20060710134022.c059d06c.zaitcev@redhat.com>
In-Reply-To: <20060710134022.c059d06c.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200607171435.22128.benjamin.cherian.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pete,

> This consideration is wholly irrelevant to the pertinent topic,
> because the very issue arises from devices being non-compliant.
> If we want them to operate, we have to apply workarounds, which
> may but us outside of the spec envelope. So I am not even going
> to argue if the spec in fact mandates this behaviour.

I understand the need to apply workarounds.  But here is why the spec is 
relevant.  By applying workarounds you have *broken* the functionality of 
Linux with respect to the USB specification.  In my opinion, workarounds 
should be constrained to fixing the problem rather than creating new ones.


> > This is exactly what I suggested in my first email. It just involves
> > adding a couple of lines of code, but I'm not sure how the unlock
> > function works in 2.4. In 2.6, the device is unlocked WITHIN proc_bulk
> > before usb_bulk_mesg is called and is locked after usb_bulk_mesg returns.
> > Therefore, the device is still locked during control transfers.
>
> I explained why this technique is not applicable to 2.4 in the part
> of the message you failed to quote. To recap, if bulk methods were
> simply to drop locks with a "couple of lines of code", they would allow
> control transfers to happen simultaneously with bulk transfers.
> It happens to work in 2.6 only because of its string caching feature.
> Indeed, Stuart Hayes of Dell reported that he can cause TEAC CD-210PU
> to break under 2.6.16 in the same way it did in 2.4.27, simply by doing
> "lsusb -v" instead of "cat /proc/bus/usb/devices". The issue is still
> with us. Greg chose to bypass it in 2.6, instead of fixing it, due
> to the amount of work involved.

Honestly, you provided very little information in your initial email.  I had 
to dig through the kernel source to make sense of what was going on.  Even 
for the above, I'm not understanding why "lsusb -v" causes problems under 
2.6.16.  Does the "-v" option cause the kernel to send control packets to the 
device?  You have to understand that the USB driver stack under Linux is not 
my domain of expertise and I'm coming to you with a problem that is not of my 
doing.  It would help a great deal to receive more details from you.


> This is a fixable issue, but it's not two lines of code. And its
> impact is very limited. If you, the person who actually suffers, are
> not willing to do the necessary work, then why would anyone else be?
> Still, I would be happy to consider your patch, if it were to emerge.

It is really looking like you are backing me into a corner to make the change 
myself.  However, before doing so I'd like to say that I am disappointed that 
the kernel developer list has not been more accommodating to this issue.  I 
understand that this problem only affects very few people.  However, please 
consider the spirit of what has happened here.  My device adheres to the 
specification.  In an effort to fix other devices that do not adhere to the 
specification you have broken my device.  Then I am being asked to make 
modifications to the OS, when clearly this is not my domain.  We all want 
Linux to be a primetime operating system and this sort of interaction with 
the developers list is *not* representative of that desire.

Besides, the device that is being broken is a 10x CD-ROM drive!  Who even uses 
these anymore? :-)

Regards,

Benjamin Cherian
