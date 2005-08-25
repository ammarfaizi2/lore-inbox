Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbVHYPQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbVHYPQw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 11:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVHYPQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 11:16:52 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:2446 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1751139AbVHYPQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 11:16:49 -0400
Subject: HPET drift question
From: Alex Williamson <alex.williamson@hp.com>
To: venkatesh.pallipadi@intel.com
Cc: robert.picco@hp.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: LOSL
Date: Thu, 25 Aug 2005 09:17:08 -0600
Message-Id: <1124983028.5331.15.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Venki,

   I'm confused by the calculation of the drift value in the hpet
driver.  The specs defines the recommended minimum hardware
implementation is a frequency drift of 0.05% or 500ppm.  However, the
drift passed in when registering with the time interpolator is:

ti->drift = ti->frequency * HPET_DRIFT / 1000000;

Isn't that absolute number of ticks per second drift?  The time
interpolator defines the drift in parts per million.  Shouldn't this
simply be:

ti->drift = HPET_DRIFT;

The current code seems to greatly penalize any hpet timer with greater
than a 1MHz frequency.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

