Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266901AbUHSR5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266901AbUHSR5x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 13:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266890AbUHSR5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 13:57:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26043 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266901AbUHSR5Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 13:57:25 -0400
Message-ID: <4124E9F6.6030000@pobox.com>
Date: Thu, 19 Aug 2004 13:57:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: new tool:  blktool
References: <411FD744.2090308@pobox.com> <4120E693.8070700@pobox.com> <4124C135.7050200@rtr.ca> <200408191751.19101.bzolnier@elka.pw.edu.pl> <4124E701.5020905@rtr.ca>
In-Reply-To: <4124E701.5020905@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Simply dropping HDIO_DRIVE_CMD/HDIO_DRIVE_TASK into there would
> immediately gain full compatibility with the existing toolsets,
> and give some time for a newer scheme to be rolled out in the
> kernel, the tools, and ultimately all of the various distros.

Addendum:  don't misunderstand my other emails, I do agree with what 
you're saying above.  But random thoughts (some of which conflict with 
each other):

* In Linux we want to keep ancient userland binaries working for as long 
as possible.

* I don't mind HDIO_DRIVE_TASK nearly as much as HDIO_DRIVE_CMD, since 
the command protocol is available.  But if I give in and decide that a 
command opcode->protocol lookup table is inevitable for supporting 
legacy interface, then I might as well implement both HDIO_DRIVE_TASK 
and HDIO_DRIVE_CMD.

* OTOH, this is an excellent opportunity to _not_ implement these 
ioctls, if an obviously-better interface is available.  Since libata and 
SATA are new drivers using new interfaces, it's not difficult to move 
things to new interfaces.

* And it's not a big deal to update blktool and hdparm to use <new 
method X> to send ATA taskfiles, rather than existing HDIO_DRIVE_xxx. 
(that leaves only existing applications)

