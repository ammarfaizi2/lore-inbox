Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUABAg6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 19:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbUABAg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 19:36:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29331 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261928AbUABAg5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 19:36:57 -0500
Date: Fri, 2 Jan 2004 00:36:52 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: Tommi Virtanen <tv@tv.debian.net>, Rob Love <rml@ximian.com>,
       Nathan Conrad <lk@bungled.net>, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040102003651.GT4176@parcelfarce.linux.theplanet.co.uk>
References: <3FF34522.8060106@tv.debian.net> <15B77182-3CB9-11D8-A498-000A95A0560C@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15B77182-3CB9-11D8-A498-000A95A0560C@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 01, 2004 at 06:17:43PM -0600, Hollis Blanchard wrote:
> "console=" takes driver-supplied names which usually happen to match 
> /dev node names. For example, drivers/serial/8250.c names itself 
> "ttyS", so "console=ttyS0" will end up going to that driver, regardless 
> of the state of /dev.
> 
> I'm not saying that's good or bad, but what's the alternative? 
> "console=class/tty/ttyS0"?

Console code will need serious work anyway; note that current names
do _not_ refer to tty devices - there is some overlap, but right now
we have
	* console drivers
	* some of them being connected with tty drivers; those can tell
which tty driver corresponds to them
	* console ouput code maintaining chain of console drivers; output
is sent to them, attempt to open() /dev/console ends up picking the first
console driver that has corresponding tty one (== has console->device())
and opening the tty device in question
	* unholy mess with redirects.

There's no device nodes for console drivers.  So names in console=... are
something very odd, indeed.
