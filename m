Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbUK3OcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbUK3OcQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 09:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbUK3OcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 09:32:16 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:65495 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262088AbUK3OcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 09:32:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=dNyLnyQcB9sGKKn8At/GBkAQppMMf5UANSGM1CaKCEdtZdjLe1oAYIXGAe+UBwbSLg7LkfXuTj0JZMWFRvLt8kMtjZpBg8rSzoyQ4mMlbjuUV02YNOh7O7g2BWvrshy2rr4plemLYOTMKC6PmeQU+6JuuKyC/R/vZHsHDyX51/M=
Message-ID: <8783be6604113006318d40ea4@mail.gmail.com>
Date: Tue, 30 Nov 2004 09:31:59 -0500
From: Ross Biro <ross.biro@gmail.com>
Reply-To: Ross Biro <ross.biro@gmail.com>
To: Jagadeesh Bhaskar P <jbhaskar@hclinsys.com>
Subject: Re: usage of WIN_SMART
Cc: Edward Falk <efalk@google.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1101784239.3789.7.camel@myLinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1101290068.3787.26.camel@myLinux>
	 <8783be6604112611137bcbfb61@mail.gmail.com>
	 <41ABB93F.8060206@google.com> <1101784239.3789.7.camel@myLinux>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As Ed said, you need the ATA spec to make sense of all that. 
Fortunately, a draft copy is available online at t13.org.  In
particular at http://www.t13.org/#Project_drafts  The docs will
explain the register settings, but not the meanings of the output.

You can avoid the driver is you wish, but it's a really bad idea to do
so since you will change the state of the drive when the driver is not
expecting it.  To safely access the drive from user space, you would
have to make sure the driver is disabled, disable interrupts, and then
poll the controller directly.  The exact method would of course be
controller specific.  You need to look at the ioperm man page and
/dev/port.

Finally, if all you want to do is access the SMART data, you should
look at smartsuite http://sourceforge.net/projects/smartsuite/  or
something similiar.  It already includes much of the vendor specific
information and knows how to get along with the kernel.

    Ross


On Tue, 30 Nov 2004 08:40:40 +0530, Jagadeesh Bhaskar P
<jbhaskar@hclinsys.com> wrote:
> Dear Edward,
>         I am grateful for such a descriptive reply. I was exploring through the
> ide-disk driver interface, which provides the SMART readings through the
> ioctl, using WIN_SMART. At the end its calling an inb and an outb to the
> regs, like u said, feature regs and all. Is it possible to do it
> directly with an inb and outb from a C program, avoiding the
> complexities involved in the WIN_SMART command.
> 
> And, can u help me out with the syntax of WIN_SMART class of ioctl?
> I know that a buffer like
> 
>         buffer = {WIN_SMART, 0, SMART_READ_VALUES, 1};
> and it is passed to the ioctl.
> 
> I have seen the significance of 1st element(WIN_SMART) and 3rd element
> (SMART_READ_VALUES) in the ide-disk module's code.
> 
> What does the second argument and the fourth argument signify?
> 
> Can u help me with this also, coz I've been digging for this a long
> time, and haven't been that successfull!!
> 
> --
> Thanks & Regards,
> 
> Jagadeesh Bhaskar P
> R&D Engineer
> HCL Infosystems Ltd
> Pondicherry
> INDIA
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
