Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312768AbSCVRt5>; Fri, 22 Mar 2002 12:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312770AbSCVRts>; Fri, 22 Mar 2002 12:49:48 -0500
Received: from mailout3-eri1.midsouth.rr.com ([24.165.200.8]:45560 "EHLO
	mailout3-eri1.midsouth.rr.com") by vger.kernel.org with ESMTP
	id <S312768AbSCVRtl>; Fri, 22 Mar 2002 12:49:41 -0500
Subject: Re: Linux-2.4.19pre3-ac5
From: Stephen Williams <mrsteve@midsouth.rr.com>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 22 Mar 2002 11:49:15 -0600
Message-Id: <1016819361.1165.3.camel@swilliam.home.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Worked like a champ, thank's Andre!

Steve

From: Andre Hedrick [mailto:andre@linux-ide.org]
Sent: Thursday, March 21, 2002 11:24 PM
To: Stephen Williams
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.19pre3-ac5


On 21 Mar 2002, Stephen Williams wrote:

> I can compile ac-5 fine but when trying to boot I get the following
> error:
> 
> kernel BUG at ide-cd.c:790!
> invalid operand: 0000
> 
> I am running 2.4.19pre3 without a problem.  I didn't have a way (as
far
> as I know) to get the full panic output but I can copy by hand and
post
> here if needed.
> 
> Have a good one,
> Steve

It is a BUG() check to see if there are cases where the interrupt
handler
is being set (re armed) while it is currently set for another event.

if (HWGROUP(drive)->handler != NULL)
     BUG();
ide_set_handler(drive, handler, timeout, expirey);

If we are reloading the handler but it was set but something else ,
never
called during a completion, and/or is dangling.  It is a typo my bad :-(

Edit and change it from "==" to "!="

Apology for the typo folks.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


