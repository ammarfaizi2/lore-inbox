Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbTJHQX3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 12:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbTJHQX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 12:23:29 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:62938 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261731AbTJHQX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 12:23:27 -0400
Subject: Re: Time precision, adjtime(x) vs. gettimeofday
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031008154846.GA29868@iram.es>
References: <1065619951.25818.15.camel@gaston>
	 <20031008154846.GA29868@iram.es>
Content-Type: text/plain
Message-Id: <1065630178.26943.54.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 08 Oct 2003 18:22:58 +0200
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well, it it affects gettimeofday which has a precision of 1 part in
> 10000 (100 ppm), it means that our boot time timebase calibration was
> not very good to start with, on my set of running VME machines I have
> the following (values in ppm):
>
> ../..

Boot time calibration can't be perfect... I depends very much on the
quality of what your are calibrating against, and the bus path to it.

On most pmacs, I'm calibrating either against a VIA timer which isn't
_that_ good or on OF value (which are themselves calibrated, I think,
against the KeyLargo timer).

On all cases, those will drift some way from what the NTP server will
give, either a lot or not, it will. So we may end up adjusting our
kernel rate and thus opening a window for the problem.

Ben.

