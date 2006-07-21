Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbWGUPpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWGUPpd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 11:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWGUPpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 11:45:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:4908 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750892AbWGUPpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 11:45:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RLeCn2YaLqGWHzhJRnRF66/sdEPAfbEWCLR5ISH5mvmuEAkJ+erTRdx2KoWG6CQfRPLi08LyYG7ibQuZa9aqyKJLaBgFRmyJwWKuGwA79hL0GgUlA8GaR1dubk96Gpb5QwFA7DNv50W8NKzzjzqi2chQ3j3lvVZrqgEUKYbiewQ=
Message-ID: <d120d5000607210845m73fcc89di7b00495e77d4550b@mail.gmail.com>
Date: Fri, 21 Jul 2006 11:45:26 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "George Nychis" <gnychis@cmu.edu>
Subject: Re: thinkpad x60s: middle button doesn't work after hibernate
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <44C0EA85.30500@cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44BFD911.70106@cmu.edu>
	 <d120d5000607201246s6af0223o83be95ef54147f10@mail.gmail.com>
	 <44C0EA85.30500@cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/06, George Nychis <gnychis@cmu.edu> wrote:
>
>
> Dmitry Torokhov wrote:
> > On 7/20/06, George Nychis <gnychis@cmu.edu> wrote:
> >> Hey guys,
> >>
> >> I recently got the suspend to disk working and suspend to memory working
> >> thanks to many of you.  Whenever I suspend to disk and resume, the
> >> middle mouse button on my thinkpad x60s no longer works for scrolling or
> >> for pasting.  I either have to reboot, or suspend to memory and resume.
> >>  Therefore:
> >>
> >> Initial Boot: working
> >> Suspend to disk -> resume: not working
> >> Suspend to memory -> resume: working
> >>
> >> To fix it for now, i simply suspend to memory and resume after resuming
> >> a suspend to disk.
> >>
> >
> > It sounds like psmouse resume method either not getting called or
> > fails during resume from disk. Could you do:
> >
> > echo 1 > /sys/modules/i8042/parameters/debug
> >
> > before suspending and send me dmesg after resuming. Make sure you have
> > big dmesg buffer.
> >
> > Thanks!
> >
>
> Here it is:
> http://rafb.net/paste/results/hDJXzS85.html
>

Hmm, resume routine gets called but the controller seems to be
confused. It stopped reporting 1 in bit 3 of byte 0 in addition to not
reporting middle button. Does it allow you pasting if you
boot/suspend/resume with "psmouse.proto=exps" (assuming that psmouse
is built in)? If so then trackpoint portion of psmouse driver needs to
be looked at.

-- 
Dmitry
