Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265689AbUADNXt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 08:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265693AbUADNXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 08:23:49 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:58884 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S265689AbUADNXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 08:23:48 -0500
Date: Sun, 4 Jan 2004 14:21:11 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Rob Love <rml@ximian.com>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040104142111.A11279@pclin040.win.tue.nl>
References: <1072972440.3975.29.camel@fur> <Pine.LNX.4.58.0401021238510.5282@home.osdl.org> <20040103040013.A3100@pclin040.win.tue.nl> <Pine.LNX.4.58.0401022033010.10561@home.osdl.org> <20040103141029.B3393@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031423180.2162@home.osdl.org> <20040104000840.A3625@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031802420.2162@home.osdl.org> <20040104034934.A3669@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031856130.2162@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0401031856130.2162@home.osdl.org>; from torvalds@osdl.org on Sat, Jan 03, 2004 at 07:04:17PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 07:04:17PM -0800, Linus Torvalds wrote:

> I agree that for a stable kernel we should then go back to "best effort" 
> mode, where for simple politeness reasons we should try to keep device 
> numbers as stable as we can.

Good - you understand now.
So, the right setup - you call it politeness, I call it quality
of implementation - is to have both stable names and stable numbers,
in as many cases as possible.

Concerning the names, we are in reasonable shape. We have nameif
that binds a stable name to a MAC address. Much beter than eth2.
Also udev is a good step in the right direction - it gives
stable names under certain circumstances.

(And since udev can use the kernel device number, it can give stable
names under more circumstances when the kernel device number is
more often stable.)

Concerning the numbers, numbers based on enumeration are less than
satisfactory - they must be the last fallback when nothing else
can be found. And the ordering then is the ordering in time.

Almost always something better can be found. It is the drivers' job
to invent the device number. For the important special case of
SCSI or IDE disk, the disk serial number can be used.

Our helper function takes a string and an integer and a range, and
produces a device number in the given range, distinct from already
existing numbers. If you prefer random device numbers you make this
function ignore the string argument. I prefer stable device numbers
so would do an md5sum-like thing.

And that brings us back to the start of this thread:
Life is simpler when there is more room.
So it is a pity that we chose for less room.

Andries

