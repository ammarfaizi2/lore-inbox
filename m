Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263775AbUGIDsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUGIDsc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 23:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263790AbUGIDsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 23:48:32 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:7524 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263775AbUGIDsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 23:48:31 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 0/8] New set of input patches
Date: Thu, 8 Jul 2004 22:48:28 -0500
User-Agent: KMail/1.6.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>
References: <200407080155.07827.dtor_core@ameritech.net> <20040708203200.GA607@openzaurus.ucw.cz>
In-Reply-To: <20040708203200.GA607@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407082248.28835.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 July 2004 03:32 pm, Pavel Machek wrote:
> Hi!
> 
> > 03-i8042-broken-mux-workaround.patch
> > 	- Some MUXes get confused what AUX port the byte came from. Assume
> > 	  that is came from the same port previous byte came from if it
> > 	  arrived within HZ/10
> 
> Does that mean that (even if my hw is ok) when I two mice at once
> I get random movements?

No, that code will only kick in if your MUX gets confused and not during
normal course of operation. Some MUXes, when confused, raise MUXERR flag
but leave the data byte intact in violation of active multiplexing spec.
which says that with MUXERR the only valid data bytes are 0xfd, oxfe and
0xff (to signal timeout, resend or parity error). So if we get something
other than 0xfd, 0xfe or 0xff within HZ/10 of last successfully transmitted
byte we assume that MUX got confused and the byte was sent by the same
device that transmitted the previous byte.

Does it make any sense?

-- 
Dmitry
