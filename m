Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbUD2Erv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUD2Erv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 00:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbUD2Erv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 00:47:51 -0400
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:11364 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261925AbUD2Eru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 00:47:50 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: locking in psmouse
Date: Wed, 28 Apr 2004 23:47:46 -0500
User-Agent: KMail/1.6.1
Cc: Pavel Machek <pavel@suse.cz>, vojtech@suse.cz
References: <20040428213040.GA954@elf.ucw.cz>
In-Reply-To: <20040428213040.GA954@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404282347.47411.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 April 2004 04:30 pm, Pavel Machek wrote:
> Hi!
> 
> psmouse-base.c does not have any locking. For example psmouse_command
> could race with data coming from the mouse, resulting in problem. This
> should fix it.
> 								Pavel

Although I am not arguing that locking might be needed in psmouse module I
am somewhat confused how it will help in case of data stream coming from the
mouse... If mouse sent a byte before the kernel issue a command then it will
be delivered by KBC controller and will be processed by the interrupt handler,
probably messing up detection process. That's why as soon as we decide that
the device behind PS/2 port is some kind of mouse we disable the stream mode.

-- 
Dmitry
