Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWHBV7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWHBV7H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 17:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWHBV7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 17:59:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:42709 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932259AbWHBV7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 17:59:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YPKm6D+o8goMHe15Q71U0+Q6LH4ry/IwulCti8aHvz2auLz+1aUIKYZq6832cn+d+8OHD8+T9Nk5VRQ50hvgrNGMoRUy1MdG8gi4YrKNaZgM1mXIYN10kft7T5ZaZ6vQwxvspHttN8l96QNJVKYYsqIhrXDp9ETCEn0rGcr8I58=
Message-ID: <41840b750608021458h2c7238d6xe1d412cfae1d5569@mail.gmail.com>
Date: Thu, 3 Aug 2006 00:59:00 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Michael Olbrich" <michael.olbrich@gmx.net>
Subject: Re: [ltp] Re: Generic battery interface
Cc: linux-thinkpad@linux-thinkpad.org, LKML <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, "Vojtech Pavlik" <vojtech@suse.cz>
In-Reply-To: <20060801114303.GA13000@creature.apm.etc.tu-bs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060728074202.GA4757@suse.cz> <20060728202359.GB5313@suse.cz>
	 <41840b750607281548h5ee2219eka1de6745b692c092@mail.gmail.com>
	 <41840b750607291406p2f843054rc89fa1c3c467688d@mail.gmail.com>
	 <41840b750607301137t1e10fe88o3a1c73e7a4b4bf44@mail.gmail.com>
	 <20060731113735.GA22081@creature.apm.etc.tu-bs.de>
	 <41840b750607310818j7ab2dcddpcb7a14b9a8f10871@mail.gmail.com>
	 <20060731183719.GB22081@creature.apm.etc.tu-bs.de>
	 <41840b750607311545h72cd5b1dq730c35b084c43db7@mail.gmail.com>
	 <20060801114303.GA13000@creature.apm.etc.tu-bs.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Micael,

I ask again: please do a Reply to All. This discussion is CCed on
several mailing lists, not just link-thinkpad.

On 8/1/06, Michael Olbrich <michael.olbrich@gmx.net> wrote:
> On Tue, Aug 01, 2006 at 01:45:27AM +0300, Shem Multinymous wrote:
> >>And keeping the latest readout for each app isn't that heavy. After all
> >>we already have to keep track of the timeouts for each app.
> >
> >The timeouts bookkeeping will normally be done by some infrastructure,
> >and can often be (in principle) be optimized to less than on value per
> >app. Also, it's just one timestamp. By contrast, what you're asking
> >for requires explicit handling by every driver, and the attribute
> >value may take significant amount of storage -- per app.
>
> If you are that concerned about storage why the complex timeout model?
> That can easily handled in userspace with just the blocking and
> nonblocking reads.

Please explain how this can be done  in a way that (a) works
transparently with both event-driven and query-based drivers, (b)
handles multiple clients efficiently, (c) minimizes hardware queries
in the case of query-based drivers, and (d) doesn't cause unnecessary
timer interrupts on tickless kernels.


> > The app can do this itself by polling and checking the value, with a
> > (not too) small value of dupeq.min_wait. In the case of a
> > polling-based data source, the resulting hardware queries and timer
> > interrupts are exactly the same as an in-kernel implementation which
> > does the polling and comparions itself. If the data source is
> > event-based then the comparison in userspace does have a drawback: the
> > comparions are done just dupeq.min_wait apart even if the event rate
> > happens to be higher. Can you think of a case where this matters?
>
> The problem I see is the overhead. Visual feedback that feels
> instantaneous would require dupeq.min_wait<50ms. And as far as I can
> tell each read requires to switch from userspace to kernelspace and
> back. When I look at the available variables I can easily imagine
> applications that would read >10 variables. That's not something I would
> want to do that often.

This is relevant only to query-based drivers, not event-based. How
expensive is a context switch compared to a typical hwmon hardware
query?

  Shem
