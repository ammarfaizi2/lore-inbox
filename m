Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264887AbUEQDuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264887AbUEQDuZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 23:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264888AbUEQDuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 23:50:25 -0400
Received: from smtp.knology.net ([24.214.63.101]:28080 "HELO smtp5.knology.net")
	by vger.kernel.org with SMTP id S264887AbUEQDuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 23:50:23 -0400
Subject: Re: 2.6.6 : bad PCI device ID for SiS ISA bridge => SiS900 eth0:
	Can not find ISA bridge
From: David Dillow <dave@thedillows.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Eric BENARD / Free <ebenard@free.fr>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, webvenza@libero.it,
       dominik.karall@gmx.net
In-Reply-To: <40A7E161.5060207@pobox.com>
References: <200405162004.57041.ebenard@free.fr>
	 <40A7E161.5060207@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1084765814.32116.20.camel@ori.thedillows.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 May 2004 23:50:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-05-16 at 17:47, Jeff Garzik wrote:
> Eric BENARD / Free wrote:
> > 1- bad PCI device ID for SiS ISA bridge
> > 
> > 2- In 2.6.3-rc2 (and 2.4.x), the PCI device ID of the ISA bridge of the 
> > SiS630e is 0x0008. This ID is used by sis900.c in order to get the MAC 
> > adress. 
> > In 2.6.6, the PCI device ID of the ISA bridge of the SiS630E is 0x0018. The 
> > SiS900 driver fail to read MAC adress and exit with the following message : 
> > eth0: Can not find ISA bridge
> [...]
[...]
> I'm not sure I understand your message.
> 
> Are you suggesting
> a) the hardware PCI id changed from 0x0008 to 0x0018 when booting 2.6.6.
> 	or
> b) sis900.c changed when booting 2.6.6.
> 
> If "a", the PCI id in sis900.c seems to be 0x0008 in both 2.4 and 2.6. 
> And further, I did not see any changes to this line of code in while 
> searching 2.6.2 -> 2.6.6 patches on ftp.kernel.org.  I would lean 
> towards a solution that modified sis900.c to check for -both- 0x08 and 0x18.

I'm not sure I understand the message, either. I can confirm that SiS's
LPC-to-ISA bridges can change their device ID based on writes to the PCI
config space -- 0x08 and 0x18 are both valid ids for that hardware.

Eric, if you'll send me an lspci -xxx on the ISA bridge run under both
kernels, that may be interesting. Then the fun part will be finding what
changed in the kernel to cause that.

In any event, I think it would be valid to have sis900 check for both
ids.

Dave
