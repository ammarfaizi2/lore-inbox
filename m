Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264275AbUE2NXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbUE2NXh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 09:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264857AbUE2NXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 09:23:37 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:24336 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S264275AbUE2NXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 09:23:24 -0400
Date: Sat, 29 May 2004 15:23:20 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Chris Osicki <osk@osk.ch>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
Message-ID: <20040529132320.GC5175@pclin040.win.tue.nl>
References: <20040525201616.GE6512@gucio> <20040528194136.GA5175@pclin040.win.tue.nl> <20040528214620.GA2352@gucio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040528214620.GA2352@gucio>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 11:46:20PM +0200, Chris Osicki wrote:

>>> I tried to solve my problem using setkeycodes and tried:
>>> 
>>> setkeycodes 71 101
>>> 
>>> getkeycodes reported after that:
>>> 
>>> # getkeycodes | grep 0x70
>>>  0x70:   93 101   0  89   0   0  85  91

Yes, fine.

>>> But showkeys -s shows 0x5b when the key in question is pressed
>>> (and no release event!!??)

0x5b is 91 which is x86_keycodes[101].

Yes, so all is clear:
The 2.6 kernel no longer has a raw mode - it has a simulated raw mode
that is not very raw. When you updated the table used for the
scancode->keycode translation, the table used to reconstruct what
might have been the original scancode was not changed accordingly.
Thus, showkeys -s gave a garbage answer.

Thanks for the report. It shows that resurrecting raw mode is even
more desirable than I thought at first.

Andries
