Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbVHYQpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbVHYQpq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 12:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbVHYQpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 12:45:46 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:46025 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932302AbVHYQpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 12:45:45 -0400
Subject: Need better is_better_time_interpolator() algorithm
From: Alex Williamson <alex.williamson@hp.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: LOSL
Date: Thu, 25 Aug 2005 10:44:28 -0600
Message-Id: <1124988269.5331.49.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   In playing with an HPET device, I noticed that
kernel/timer.c:is_better_time_interpolator() is completely non-symmetric
in the timer it returns.  The test is simply:

return new->frequency > 2*time_interpolator->frequency ||
 (unsigned long)new->drift < (unsigned long)time_interpolator->drift;

Given two timers:

(a) 1.5GHz, 750ppm
(b) 250Mhz, 500ppm

the resulting "better" timer is completely dependent on the order
they're passed in.  For example, (a),(b) = (b); (b),(a) = (a).

   What are we really looking for in a "better" timer?  There are at
least 4 factors that I can think of that seem important to determining a
better clock:

      * resolution (frequency)
      * accuracy (drift)
      * access latency (may be non-uniform across the system?)
      * jitter (monotonically increasing)

How can we munge these all together to come up with a single goodness
factor for comparison?  There's probably a thesis covering algorithms to
handle this.  Anyone know of one or have some good ideas?  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

