Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTFTP3r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 11:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTFTP3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 11:29:47 -0400
Received: from mail.ccur.com ([208.248.32.212]:34065 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S263176AbTFTP3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 11:29:46 -0400
Subject: Re: [PATCH] PCI changes and fixes for 2.5.72
From: Albert Cahalan <albert.cahalan@ccur.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1056123842.986.60.camel@albertc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 20 Jun 2003 11:44:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg writes:

> [PATCH] PCI: Unconfuse /proc
>
> If we are to cope with multiple domains with clashing PCI bus
> numbers, we must refrain from creating two directories of the
> same name in /proc/bus/pci.  This is one solution to the
> problem; busses with a non-zero domain number get it prepended.
>
> Alternative solutions include cowardly refusing to create
> non-domain-zero bus directories, refusing to create directories
> with clashing names, and sticking our heads in the sand and
> pretending the problem doesn't exist.

Please don't do this. It's gross. As long as we have
the bus number mangling, stuff can stay as it is.
When the bus number mangling goes, the old-style
entries can go as well. I'm working on a patch that
makes the old-style entries be symlinks like this:

../../pci%d/bus%d/dev%d/fn%d/config-space

That solves the problem for good, in the right way.
It allows for migration to something sane.


