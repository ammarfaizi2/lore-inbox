Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbUFCHPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUFCHPL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 03:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUFCHPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 03:15:11 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:36174 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261321AbUFCHPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 03:15:06 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Changing SysRq - show registers handling
Date: Thu, 3 Jun 2004 02:15:04 -0500
User-Agent: KMail/1.6.2
Cc: Andy Lutomirski <luto@myrealbox.com>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Vojtech Pavlik <vojtech@suse.cz>
References: <fa.jjf8osn.670mbt@ifi.uio.no> <40BECD28.70806@myrealbox.com>
In-Reply-To: <40BECD28.70806@myrealbox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406030215.04054.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 June 2004 02:03 am, Andy Lutomirski wrote:
> 
> Dmitry Torokhov wrote:
> 
> > Hi,
> > 
> > Currently SysRq "show registers" command dumps registers and the call
> > trace from keyboard interrupt context when SysRq-P. For that struct pt_regs *
> > has to be dragged throughout entire input and USB systems. Other than passing
> > this pointer to SysRq handler these systems has no interest in it, it is
> > completely foreign piece of data for them and I would like to get rid of it.
> > 
> > I am suggesting slightly changing semantics of SysRq-P handling - instread
> > of dumping registers and call trace immediately it will simply post a request
> > for this information to be dumped. When next HW interrupt arrives and is
> > handled, before running softirqs then current stack trace will be printed.
> > This approach adds small overhead to the HW interrupt handling routine as the
> > condition has to be checked with every interrupt but I expect it to be
> > negligible as it is only check and conditional jump that is almost never
> > taken. The code should be hot in cache so branch prediction should work just
> > fine.
> 
> What about checking the flag on return from the input interrupts?  That way 
> the overhead would be confined to code paths take the hit from passing an 
> extra parameter.
>

It is hard to define what input interrupt is - PS/2 keyboard in KBD port (IRQ 1),
PS/2 keyboard in AUX port (IRQ 12), USB, serial port, parralel port keyboard
adapter... and all other achitectures taht have their means - it's impossible to
track them all.

-- 
Dmitry
