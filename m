Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264291AbTH2BTM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 21:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbTH2BTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 21:19:12 -0400
Received: from codepoet.org ([166.70.99.138]:13701 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S264291AbTH2BTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 21:19:09 -0400
Date: Thu, 28 Aug 2003 19:19:10 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
Subject: Re: [RFC] /proc/ide/hdx/settings with ide-default pseudo-driver is a 2.6/2.7 show-stopper
Message-ID: <20030829011910.GA19351@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andre Hedrick <andre@linux-ide.org>
References: <200308281646.16203.bzolnier@elka.pw.edu.pl> <1062083581.24982.21.camel@dhcp23.swansea.linux.org.uk> <200308281747.11359.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308281747.11359.bzolnier@elka.pw.edu.pl>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Aug 28, 2003 at 05:47:11PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Problem is when integrating ide with driverfs.
> Then you need to register/unregister ide-default as driverfs driver
> and now it can "steal" devices, ie. you have cd drive owned by ide-default,
> later you load ide-cdrom driver and your cd drive needs to be unregistered
> from ide-default driver first before it can be registered with ide-cdrom
> driver - you need to add code to do this or device will be "stealed".
> Its not very hard to do but it adds complexity.

Make an interface whereby ide-cdrom (and ide-disk, etc) can walk
the list of all unclaimed devices (i.e. devices owned by
ide-default), check they are of the correct type, and claim them
(thereby removing them from the ide-default driver).  When
unregistering, reverse the process and give the device back to
ide-default...  i.e. make ide-default a holding pen for unclaimed
devices,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
