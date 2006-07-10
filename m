Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161271AbWGJAGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161271AbWGJAGb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 20:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161272AbWGJAGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 20:06:31 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:31202 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1161271AbWGJAGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 20:06:30 -0400
Date: Sun, 9 Jul 2006 20:01:26 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Magic Alt-SysRq change in 2.6.18-rc1
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-input <linux-input@atrey.karlin.mff.cuni.cz>
Message-ID: <200607092004_MC3-1-C488-137B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <Pine.LNX.4.44L0.0607091657490.28904-100000@netrider.rowland.org>

On Sun, 9 Jul 2006 17:06:57 -0400, Alan Stern wrote:
> 
> <...> changes in the behavior of Alt-SysRq?
> 
> Before 2.6.18-rc1, I used to be able to use it as follows:
> 
>       Press and hold an Alt key,
>       Press and hold the SysRq key,
>       Release the Alt key,
>       Press and release some hot key like S or T or 7,
>       Repeat the previous step as many times as desired,
>       Release the SysRq key.
> 
> This scheme doesn't work any more, or if it does, the timing requirements
> are now much stricter.  In practice I have to hold down all three keys at
> the same time; I can't release the Alt key before pressing the hot key.


Look at the change history for keyboard.c:


[PATCH] fix magic sysrq on strange keyboards

Magic sysrq fails to work on many keyboards, particulary most of notebook
keyboards.  This patch fixes it.

The idea is quite simple: Discard the SysRq break code if Alt is still being
held down.  This way the broken keyboard can send the break code (or the user
with a normal keyboard can release the SysRq key) and the kernel waits until
the next key is pressed or the Alt key is released.


-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
