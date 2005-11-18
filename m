Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161105AbVKRTlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161105AbVKRTlg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 14:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbVKRTlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 14:41:36 -0500
Received: from cse-mail.unl.edu ([129.93.165.11]:9902 "EHLO cse-mail.unl.edu")
	by vger.kernel.org with ESMTP id S1161105AbVKRTlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 14:41:35 -0500
Date: Fri, 18 Nov 2005 13:41:04 -0600 (CST)
From: Hui Cheng <hcheng@cse.unl.edu>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
cc: Pavel Machek <pavel@suse.cz>, <kernelnewbies@nl.linux.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: How to quickly detect the mode change of a hard disk?
In-Reply-To: <20051116185628.M35560@linuxwireless.org>
Message-ID: <Pine.GSO.4.44.0511181333540.20511-100000@cse.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (cse-mail.unl.edu [129.93.165.11]); Fri, 18 Nov 2005 13:41:11 -0600 (CST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Nov 2005, Alejandro Bonilla wrote:

> On Sun, 13 Nov 2005 15:10:56 +0000, Pavel Machek wrote
> > > I am currently doing a kernel module involves detecting/changing
> > > disk mode among STANDBY and ACTIVE/IDLE. I used ide_cmd_wait() to issue
> > > commands like WIN_IDLEIMMEDIATELY and WIN_STANDBYNOW1. The problem is, a
> > > drive in standby mode will automatically awake whenever a disk operation
> > > is requested and I need to know the mode change as soon as possible. (So I
> >
> > AFAIK there's no nice way to get that info, but it is useful, so
> > patch would be welcome.
>
> I would check the hdparm man page again. Still, it sounds interesting.
>
> Additionally, it could be cool if someone could finish up or make the option
> for the HD freeze to use it with the HDAPS driver. ;-)
>
> .Alejandro
>

Thanks for reply :) What I did to handle this problem is a little stupid
: Suppose the disk is now in a standby mode. In case that there is a
request sent to the disk drive, a kernel thread is awake to detect/update
the current disk power mode. The disk power mode is stored in the
ide_drive_t structure and be protected by lock. It seems to work fine in
my simple tests. But again, there should be better solutions.

Hui

