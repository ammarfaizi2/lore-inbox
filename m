Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264961AbVBFF31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbVBFF31 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 00:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272106AbVBFF30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 00:29:26 -0500
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:49784 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264961AbVBFF3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 00:29:22 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.de>
Subject: Re: [RFC/RFT] Better handling of bad xfers/interrupt delays in psmouse
Date: Sun, 6 Feb 2005 00:29:20 -0500
User-Agent: KMail/1.7.2
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       zhilla <zhilla@spymac.com>, Victor Hahn <victorhahn@web.de>
References: <200502051448.57492.dtor_core@ameritech.net> <20050205211136.GB8451@ucw.cz>
In-Reply-To: <20050205211136.GB8451@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502060029.21068.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 February 2005 16:11, Vojtech Pavlik wrote:
> On Sat, Feb 05, 2005 at 02:48:56PM -0500, Dmitry Torokhov wrote:
> > Hi,
> > 
> > The patch below attempts to better handle situation when psmouse interrupt
> > is delayed for more than 0.5 sec by requesting a resend. This will allow
> > properly synchronize with the beginning of the packet as mouse is supposed
> > to resend entire package.
> 
> Have you actually tested the mouse is really sending the whole packet?
> I'd suspect it could just resend the last byte. :I Maybe using the

Well, I did test and my touchpad behaved properly. But then I tried 2 external
mice and they are both sending ACK (and they should not) and then the last byte
only. So I guess we'll have to scrap using 0xfe idea...

> GET_PACKET command would be more useful in this case.
>

Are you talking about 0xeb? We could also try sending "set stream" mode as a
sync marker...

-- 
Dmitry
