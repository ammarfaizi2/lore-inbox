Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264593AbTK0S4Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 13:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264595AbTK0S4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 13:56:16 -0500
Received: from bolt.sonic.net ([208.201.242.18]:51878 "EHLO bolt.sonic.net")
	by vger.kernel.org with ESMTP id S264593AbTK0S4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 13:56:13 -0500
Date: Thu, 27 Nov 2003 10:56:12 -0800
From: David Hinds <dhinds@sonic.net>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Ricoh Cardbus -> Can't get interrupts
Message-ID: <20031127105612.B28106@sonic.net>
References: <Pine.LNX.4.58.0311241845200.1599@home.osdl.org> <Pine.LNX.4.44.0311241906500.1986-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311241906500.1986-100000@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 24, 2003 at 07:08:26PM -0800, Davide Libenzi wrote:
> 
> I didn't want to post this because I was ashamed of the fix, but w/out 
> this my orinoco cardbus gets an interrupt one every ten boots. This is 
> against 2.4.20 ...
> 
> - Davide

Your patch seems to do two things:

First, it automatically falls back on using a socket's PCI interrupt
if its ISA interrupts are not available.  That part seems ok.

But, it also falls back on sharing an interrupt if a driver requested
an exclusive interrupt and that was not available.  This part is not
ok.  The original code will share a PCI interrupt automatically, but
will not share an ISA interrupt except under certain circumstances
(for multifunction cards or when the driver specifically requests it).
Sharing ISA interrupts is unsafe and should never be done blindly.

-- Dave
