Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269685AbTGaWGu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 18:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270413AbTGaWGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 18:06:31 -0400
Received: from AMarseille-201-1-5-189.w217-128.abo.wanadoo.fr ([217.128.250.189]:41255
	"EHLO gaston") by vger.kernel.org with ESMTP id S270530AbTGaWF6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 18:05:58 -0400
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <3F299069.1010905@pacbell.net>
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org>
	 <1059153629.528.2.camel@gaston> <3F21B3BF.1030104@pacbell.net>
	 <20030726210123.GD266@elf.ucw.cz>  <3F288CAB.6020401@pacbell.net>
	 <1059686596.7187.153.camel@gaston>  <3F299069.1010905@pacbell.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059689105.2417.195.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 01 Aug 2003 00:05:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I suspect that USB should do some non-global PM stuff too.
> Hub ports can be suspended when the devices connected to them
> are idle for long enough ... that's not something I'd expect
> system-wide PM policies to address.

Indeed, this is not addressed, though it may sense to have
a way in the device model to call the suspend/resume callbacks
of "childs" of a given hub only for that purpose, I don't think
this is implemented yet. Maybe talk to Patrick about it.

In general "local" power management (automatic disk spin down,
chipset idle-pm, etc...) is ... local to the driver, though you
can probably use the power state field of struct device to
store your current state if it maps to those semantics.

Ben.

