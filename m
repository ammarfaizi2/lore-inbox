Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWIGOEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWIGOEt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 10:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWIGOEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 10:04:49 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:23721 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932072AbWIGOEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 10:04:47 -0400
Subject: Re: Linux 2.6.18-rc6
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060907091517.GA21728@aepfle.de>
References: <Pine.LNX.4.64.0609031939100.27779@g5.osdl.org>
	 <20060905122656.GA3650@aepfle.de>
	 <1157490066.3463.73.camel@mulgrave.il.steeleye.com>
	 <20060906110147.GA12101@aepfle.de>
	 <1157551480.3469.8.camel@mulgrave.il.steeleye.com>
	 <20060907091517.GA21728@aepfle.de>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 09:04:34 -0500
Message-Id: <1157637874.3462.8.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-07 at 11:15 +0200, Olaf Hering wrote:
> This does not work: ahc_linux_get_signalling: f 56f6
> 
> echo $(( 0x56f6 & 0x00002 )) gives 2, and the ahc_inb is called.

Erm, there's something else going on then:  An ultra 2 card has to have
this register.  It's used to signal mode changes in
ahc_handle_scsiint().  The piece of code in there will trigger and read
this register for any ultra 2 + controller every time there's an error
(just to see if the bus mode changed).

James


