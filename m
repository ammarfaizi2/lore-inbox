Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265306AbUADWhP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 17:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265351AbUADWhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 17:37:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58507 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265306AbUADWhO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 17:37:14 -0500
Date: Sun, 4 Jan 2004 22:37:10 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, Rob Love <rml@ximian.com>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040104223710.GY4176@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0401022033010.10561@home.osdl.org> <20040103141029.B3393@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031423180.2162@home.osdl.org> <20040104000840.A3625@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031802420.2162@home.osdl.org> <20040104034934.A3669@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040104230104.A11439@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 11:01:04PM +0100, Andries Brouwer wrote:
> A common Unix idiom is testing for the identity
> of two files by comparing st_ino and st_dev.
> A broken idiom?

	No, just your usual highly selective reading.  First of all, that
idiom relies only on different ->s_dev *among* *currently* *mounted*
*filesystems*.  In part that has anything to do with devices, it means
only one thing:

	Any two different block devices that are both currently opened by
	the kernel and are both alive must have different device numbers.

Note the "are alive" part - we can even allow reuse of device numbers
as long as we make sure that stat() will fail on filesystems mounted
from dead ones.

Now, care to explain how preserving aforementioned common Unix idiom
is related to your expostulations?
