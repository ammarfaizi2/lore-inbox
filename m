Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbWKMSGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWKMSGi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbWKMSGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:06:38 -0500
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:5895 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932467AbWKMSGh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:06:37 -0500
Date: Mon, 13 Nov 2006 19:06:35 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Stelian Pop <stelian@popies.net>
Cc: Andrew Morton <akpm@osdl.org>, Dmitry Torokhov <dtor_core@ameritech.net>,
       Michael Hanselmann <linux-kernel@hansmi.ch>,
       "Aristeu S. Rozanski F." <aris@cathedrallabs.org>,
       Johannes Berg <johannes@sipsolutions.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, Robert Love <rml@novell.com>,
       Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Apple Motion Sensor driver
Message-Id: <20061113190635.597ab587.khali@linux-fr.org>
In-Reply-To: <1163280972.32084.13.camel@localhost.localdomain>
References: <1163280972.32084.13.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stelian,

On Sat, 11 Nov 2006 22:36:11 +0100, Stelian Pop wrote:
> This driver adds support for the Apple Motion Sensor (AMS) as found in 2005
> revisions of Apple PowerBooks and iBooks.  It implements both the PMU and
> I²C variants.  The I²C driver and mouse emulation is based on code by
> Stelian Pop <stelian@popies.net>, while the PMU driver has been developped
> by Michael Hanselmann <linux-kernel@hansmi.ch>. HD parking support will be
> added later.
> 
> Various people contributed fixes to this driver, including
> Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org> and
> Jean Delvare <khali@linux-fr.org>.
> 
> This patch lived for a while in the -mm tree but was dropped by Andrew in
> 2.6.18-mm1 because of some conflicting changes he was send at the time.
> Things have settled down since then, I merged all the bits and pieces and 
> rediffed against the latest git.
> 
> This driver should be quite mature to go directly into the input tree. If not,
> Andrew please pick it up again.
> 
> (...)
>  b/drivers/hwmon/ams/Makefile    |    8 +
>  b/drivers/hwmon/ams/ams-core.c  |  265 +++++++++++++++++++++++++++++++++++
>  b/drivers/hwmon/ams/ams-i2c.c   |  299 ++++++++++++++++++++++++++++++++++++++++
>  b/drivers/hwmon/ams/ams-mouse.c |  147 +++++++++++++++++++
>  b/drivers/hwmon/ams/ams-pmu.c   |  207 +++++++++++++++++++++++++++
>  b/drivers/hwmon/ams/ams.h       |   72 +++++++++
>  drivers/hwmon/Kconfig           |   25 +++
>  drivers/hwmon/Makefile          |    1 
>  8 files changed, 1024 insertions(+)

There's some confusion here. On the one hand, you placed your driver
in the hwmon directory, and integrated it in the Hardware Monitoring
menu. But on the other hand you seem to think that the input tree is
the natural merge path for this patch. Isn't it strange?

This raises the question of what these drivers (ams, hdaps...) really
are, and where they really belong. The hdaps driver is very different
from all other driver in the hwmon directory. Maybe they would be
better located in drivers/input/accel? This is an open question, I
really don't know.

(Side note: you could use the -p1 parameter of diffstat for better
results.)

-- 
Jean Delvare
