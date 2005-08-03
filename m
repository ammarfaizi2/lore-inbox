Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbVHCLmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbVHCLmp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 07:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVHCLmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 07:42:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:14766 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262228AbVHCLmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 07:42:40 -0400
Subject: Re: Calling suspend() in halt/restart/shutdown -> not a good idea
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, ebiederm@xmission.com
In-Reply-To: <20050802095312.GA1442@elf.ucw.cz>
References: <1122908972.18835.153.camel@gaston>
	 <20050802095312.GA1442@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 03 Aug 2005 13:38:28 +0200
Message-Id: <1123069109.30257.23.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-02 at 11:53 +0200, Pavel Machek wrote:
> Hi!
> 
> > Why are we calling driver suspend routines in these ? This is _not_
> 
> Well, reason is that if you remove device_suspend() you'll get
> emergency hard disk park during powerdown. As harddrives can survive
> only limited number of emergency stops, that is not a good idea.

No, that is bogus. We have shutdown() already for that and it used to be
implemented at least by IDE.

You are just blindly "dropping" the device_suspend() call in there
without thinking. There is a lot of differences between suspend and
shutdown, you can't "just do that". In addition to the number of drivers
with broken suspend of course, causing many boxes to not shutdown
anymore (and not only PPCs)

Andrew, please back that off before 2.6.13. I'll try to send a patch if
you want later today if I find some time with a kernel source at hand.

Ben.


