Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312670AbSCVFYc>; Fri, 22 Mar 2002 00:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312671AbSCVFYX>; Fri, 22 Mar 2002 00:24:23 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:56838
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S312670AbSCVFYO>; Fri, 22 Mar 2002 00:24:14 -0500
Date: Thu, 21 Mar 2002 21:23:36 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Stephen Williams <mrsteve@midsouth.rr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.19pre3-ac5
In-Reply-To: <1016734453.1017.11.camel@swilliam.home.net>
Message-ID: <Pine.LNX.4.10.10203212115360.4958-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Mar 2002, Stephen Williams wrote:

> I can compile ac-5 fine but when trying to boot I get the following
> error:
> 
> kernel BUG at ide-cd.c:790!
> invalid operand: 0000
> 
> I am running 2.4.19pre3 without a problem.  I didn't have a way (as far
> as I know) to get the full panic output but I can copy by hand and post
> here if needed.
> 
> Have a good one,
> Steve

It is a BUG() check to see if there are cases where the interrupt handler
is being set (re armed) while it is currently set for another event.

if (HWGROUP(drive)->handler != NULL)
     BUG();
ide_set_handler(drive, handler, timeout, expirey);

If we are reloading the handler but it was set but something else , never
called during a completion, and/or is dangling.  It is a typo my bad :-(

Edit and change it from "==" to "!="

Apology for the typo folks.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

