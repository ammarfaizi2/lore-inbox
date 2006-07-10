Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422815AbWGJUlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422815AbWGJUlA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 16:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422814AbWGJUlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 16:41:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13476 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422815AbWGJUk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 16:40:59 -0400
Date: Mon, 10 Jul 2006 13:40:22 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Benjamin Cherian <benjamin.cherian.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@sourceforge.net,
       zaitcev@redhat.com
Subject: Re: Bug with USB proc_bulk in 2.4 kernel
Message-Id: <20060710134022.c059d06c.zaitcev@redhat.com>
In-Reply-To: <200607101258.34005.benjamin.cherian.kernel@gmail.com>
References: <mailman.1152332281.24203.linux-kernel2news@redhat.com>
	<20060708132856.41644999.zaitcev@redhat.com>
	<200607101258.34005.benjamin.cherian.kernel@gmail.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 12:58:32 -0700, Benjamin Cherian <benjamin.cherian.kernel@gmail.com> wrote:

> I understand your decision but this does not follow the USB spec. According 
> to the spec, two threads should be able to perform operations on the same 
> device at the same time.

This consideration is wholly irrelevant to the pertinent topic,
because the very issue arises from devices being non-compliant.
If we want them to operate, we have to apply workarounds, which
may but us outside of the spec envelope. So I am not even going
to argue if the spec in fact mandates this behaviour.

> > But it seems to me that the best approach would be if you made
> > a special case for bulk+bulk and locked out control transfers somehow.
> 
> This is exactly what I suggested in my first email. It just involves adding a 
> couple of lines of code, but I'm not sure how the unlock function works in 
> 2.4. In 2.6, the device is unlocked WITHIN proc_bulk before usb_bulk_mesg is 
> called and is locked after usb_bulk_mesg returns. Therefore, the device is 
> still locked during control transfers.

I explained why this technique is not applicable to 2.4 in the part
of the message you failed to quote. To recap, if bulk methods were
simply to drop locks with a "couple of lines of code", they would allow
control transfers to happen simultaneously with bulk transfers.
It happens to work in 2.6 only because of its string caching feature.
Indeed, Stuart Hayes of Dell reported that he can cause TEAC CD-210PU
to break under 2.6.16 in the same way it did in 2.4.27, simply by doing
"lsusb -v" instead of "cat /proc/bus/usb/devices". The issue is still
with us. Greg chose to bypass it in 2.6, instead of fixing it, due
to the amount of work involved.

This is a fixable issue, but it's not two lines of code. And its
impact is very limited. If you, the person who actually suffers, are
not willing to do the necessary work, then why would anyone else be?
Still, I would be happy to consider your patch, if it were to emerge.

-- Pete
