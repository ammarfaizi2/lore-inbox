Return-Path: <linux-kernel-owner+w=401wt.eu-S1759698AbWLJC5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759698AbWLJC5F (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 21:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759876AbWLJC5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 21:57:04 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:33153 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759698AbWLJC5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 21:57:03 -0500
Date: Sat, 9 Dec 2006 18:57:37 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] ucb1400_ts depends SND_AC97_BUS
Message-Id: <20061209185737.1768315d.randy.dunlap@oracle.com>
In-Reply-To: <200612092150.02940.dtor@insightbb.com>
References: <20061209003635.e778ff76.randy.dunlap@oracle.com>
	<200612092150.02940.dtor@insightbb.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2006 21:50:01 -0500 Dmitry Torokhov wrote:

> On Saturday 09 December 2006 03:36, Randy Dunlap wrote:
> > From: Randy Dunlap <randy.dunlap@oracle.com>
> > 
> > This driver is an AC97 codec according to its help text.
> > However, if SOUND is disabled, the "select SND_AC97_BUS"
> > still inserts that into the .config file:
> > 
> > #
> > # Sound
> > #
> > # CONFIG_SOUND is not set
> > CONFIG_SND_AC97_BUS=m
> > 
> 
> I consider this abug in kconfig - users of "select" should not know
> full dependency chain for selected symbol.

Seems that I've heard that somewhere else.
so I agree with that part.

> > Even if the config software followed dependency chains on selects,
> > we should try to limit usage of "select" to library-type
> > code that is needed (e.g., CRC functions) instead of bus-type
> > support.
> >
> 
> I do not agree here - the way our directory structure is laid out
> "sound" comes after "Input device support" menuconfig entry.
> Your patch makes user go back and forth in menuconfig, which is
> awkward. I think using select is fine when an option depends on
> something down the stream. If user already had a chance to select
> necessary option then using "depends on" is preferred.

Traversing the menus is not difficult.
(It's easier in xconfig or gconfig than menuconfig IMO,
but not a big deal in any of them.)

Anyway, are you saying that the only fix for this build error
is to fix *config to handle select dependencies?
or could propose another way to handle the build error?

Thanks,
---
~Randy
