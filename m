Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262487AbVCPDmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbVCPDmj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 22:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbVCPDmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 22:42:39 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:34969 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262487AbVCPDmg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 22:42:36 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC] Changes to the driver model class code.
Date: Tue, 15 Mar 2005 22:42:33 -0500
User-Agent: KMail/1.7.2
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Kay Sievers <kay.sievers@vrfy.org>
References: <20050315170834.GA25475@kroah.com> <20050315201503.GA3591@isilmar.linta.de> <20050315221431.GC28880@kroah.com>
In-Reply-To: <20050315221431.GC28880@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503152242.34234.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 March 2005 17:14, Greg KH wrote:
> > Ease-of-use, maybe. However, it also means
> > ease-of-getting-reference-counting-wrong. And reference counting trumps it
> > all :)
> 
> It will not make the reference counting logic easier to get wrong, or
> easier to get right.  It totally takes it away from the user, and makes
> them implement it themselves if they so wish (like the USB HCD patch
> does.)

Exactly, _IF_ they wish. And as practice shows proper reference counting
is not the very first thing people are concerned about.

I see the the new class interface useful in the following scenario:

 - We have a proper subsystem that already does proper refcounting and
   one might not want to consolidate core reference counting with
   subsystems as it is too invasive.

If you consider the following scenario I do not think we want to
encourage it:

 - We have "bad" system and user says "ah, I'll just use the new model
   so I don't have to think about lifetime rules at the moment, I don't
   have time/have something more interesting to do/I'll do that later
   when I have time".

There is a third scenario:

 - We have a completely new system or a system undergoing overhaul: the
   coder tries to do it right and does consider all lifetime rules and
   makes sure that all objects are properly accounted for. In this case
   old interface is much more clear and easier to use than the new one.

I also not quite sure why a bus with its devices and drivers can be
implemented correctly (I believe we have a bunch of them now - PCI, USB,
serio, gameport) but class interface cannot be tamed?

-- 
Dmitry
