Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUFJR3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUFJR3i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 13:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbUFJR3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 13:29:37 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:58575 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262085AbUFJR3g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 13:29:36 -0400
Message-ID: <40C89A16.8030301@pacbell.net>
Date: Thu, 10 Jun 2004 10:27:50 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, viro@parcelfarce.linux.theplanet.co.uk
CC: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>,
       Al Viro <viro@math.psu.edu>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Finding user/kernel pointer bugs [no html]
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu> <20040610044903.GE12308@parcelfarce.linux.theplanet.co.uk> <20040610165821.GB32577@kroah.com>
In-Reply-To: <20040610165821.GB32577@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Jun 10, 2004 at 05:49:03AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:

>>272 is interesting - it's in
>>static void async_completed(struct urb *urb, struct pt_regs *regs)
>>{
>>        ...
>>}
>>and it brings two questions:
>>	a) shouldn't ->si_addr be a __user pointer (in all contexts I see
>>it is one)
>>	b) WTF is usb doing messing with it directly?
>>Note that drivers/usb/core/{devio,inode}.c are the only users of that animal
>>outside of arch/*.  Looks fishy...
> 
> 
> I really don't know.  I think David added that code.  David, any ideas?

Not me.  I think that's the original code from Thomas Sailer;
I've never touched the usbfs AIO core.  (Maybe you're thinking
of some oops-on-disconnect fixups I did, forcing completions
on all the usbfs-internal async requests.  That's now done in
usbcore.)

Speaking of AIO, I've been thinking I should submit that
gadgetfs AIO support for 2.6.7+ kernels.  It's amazing what
can be done with that small an amount of code ... and IMO
that's the right model to use for stuff like this.  I'll
re-test first, on the off chance it broke recently.

- Dave



