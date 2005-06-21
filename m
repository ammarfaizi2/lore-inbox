Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVFUJh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVFUJh7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 05:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbVFUJhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 05:37:21 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:63650 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262090AbVFUJg3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 05:36:29 -0400
Subject: Re: PATCH: Fix crashes with hotplug serverworks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <20050621065221.GA31420@infradead.org>
References: <1119298859.3325.43.camel@localhost.localdomain>
	 <20050621065221.GA31420@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119346417.3325.82.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 21 Jun 2005 10:33:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-06-21 at 07:52, Christoph Hellwig wrote:
> Well, because of fake-hotplug we really need to mark every ->probe routine
> and what's called from it __devinit.  Debian has patch to do that forever
> but Bart refused to take it.

I'm not surprised from our experience either.

Actually marking all the devices __devinit may be overkill. One approach
that does also seem to work is passing "hotplug yes/no" information when
registering the driver. This is then used to run the ide scan at boot
and avoid registering that driver with the PCI core for hotplug.

A move to __devinit is certainly simpler.

