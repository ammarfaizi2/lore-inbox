Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932770AbVHTAFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932770AbVHTAFe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 20:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932774AbVHTAFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 20:05:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:33507 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932770AbVHTAFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 20:05:33 -0400
Subject: Re: pmac_nvram problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1124448920.24113.2.camel@localhost>
References: <1124277416.6336.11.camel@localhost>
	 <1124341212.8848.78.camel@gaston>  <1124370184.30888.5.camel@localhost>
	 <1124401227.5182.14.camel@gaston>  <1124448920.24113.2.camel@localhost>
Content-Type: text/plain
Date: Sat, 20 Aug 2005 10:03:32 +1000
Message-Id: <1124496213.5182.87.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-19 at 12:55 +0200, Johannes Berg wrote:
> On Fri, 2005-08-19 at 07:40 +1000, Benjamin Herrenschmidt wrote:
> 
> > Just a question: Why do you want to have the nvram low level code as a
> > module ? It's sort-of an intergral part of the arch code ...
> 
> Because I Can (TM). Actually, I just did this because of the suspend
> issue where OSX would reset some values (notably the boot sound volume),
> but Linux wouldn't see this. So I figured that if I can compile it as a
> module (the Kconfig option is a tristate after all) I could just unload
> it. But that failed because of the alloc_bootmem issue.
> 
> I wouldn't mind having it built-in at all, if it would re-read the
> cached values when resuming from suspend.

Best then is to add a sysdev there so you get suspend() and resume()
notification. You can then write to flash on suspend (same call done by
machine restart/powerdown) and re-read on resume.

Ben.


