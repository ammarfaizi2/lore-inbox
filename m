Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbVKADkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbVKADkB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 22:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbVKADkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 22:40:01 -0500
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:7332 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964995AbVKADkA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 22:40:00 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: Commit "[PATCH] USB: Always do usb-handoff" breaks my powerbook
Date: Mon, 31 Oct 2005 22:39:56 -0500
User-Agent: KMail/1.8.3
Cc: David Brownell <david-b@pacbell.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-usb-devel@lists.sourceforge.net,
       Paul Mackerras <paulus@samba.org>,
       Alan Stern <stern@rowland.harvard.edu>
References: <17253.43605.659634.454466@cargo.ozlabs.ibm.com> <1130812903.29054.408.camel@gaston> <200510311909.32694.david-b@pacbell.net>
In-Reply-To: <200510311909.32694.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200510312239.57601.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 22:09, David Brownell wrote:
> > > > I'm not sure it's legal to do pci_enable_device() from within a pci
> > > > quirk anyway. I really wonder what that code is doing in the quirks, I
> > > > don't think it's the right place, but I may be wrong.
> > > 
> > > Erm, what "code is doing" what, that you mean ??
> > 
> > What _That_ code is doing in the quirks... shouldn't it be in the
> > {U,O,E}HCI drivers instead ?
> 
> Not for PCI.  Vojtech, this is your cue to explain some of how late handoff
> borks the input layer, as observed by SuSE on way too many BIOS/hardware combos
> for me to remember ... :)
> 

Not Vojtech, but here is goes... Not everyone has USB compiled in and
even then I think USB is registered after serio. So when we probe for
i8042 BIOS still has its dirty hands on USB controllers and pretends
that they are in fact PS/2 devices. Crazy stuff like that... That's
why we can't keep that code in HCI drivers. 

-- 
Dmitry
