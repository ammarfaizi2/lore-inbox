Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWGKRIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWGKRIk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 13:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWGKRIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 13:08:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8154 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751119AbWGKRIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 13:08:39 -0400
Date: Tue, 11 Jul 2006 13:07:25 -0400
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: RFC: cleaning up the in-kernel headers
Message-ID: <20060711170725.GD5362@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>, torvalds@osdl.org,
	akpm@osdl.org
References: <20060711160639.GY13938@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711160639.GY13938@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 06:06:39PM +0200, Adrian Bunk wrote:
 > I'd like to cleanup the mess of the in-kernel headers, based on the 
 > following rules:
 > - every header should #include everything it uses
 > - remove unneeded #include's from headers
 > 
 > This would also remove all the implicit rules "before #include'ing 
 > header foo.h, you must #include header bar.h" you usually only see when 
 > the compilation fails.

You may want to add as a secondary goal, splitting up some of the
huge 3-headed monster include files like sched.h
(It's better than it used to be, but it still sucks, and that thing
#include's the world).  Worst, iirc module.h pulls it in, which means
everything built as a module is pulling in hundreds of includes
even though most of the time, it'll never use anything from the
indirect ones.

ghviz & hviz from http://www.kernel.org/pub/linux/kernel/people/acme/
are invaluable for eyeballing include dependancies btw.
They need graphviz installed, and run like so..

ghviz include/linux/sched.h 10

to produce a pretty graph.

 > There might be exceptions (e.g. for avoiding circular #include's) but 
 > these would be special cases.

In many cases, adding forward references is a lot cleaner than
adding dozens of indirect include dependancies.

		Dave

-- 
http://www.codemonkey.org.uk
