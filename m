Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbTESSWk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 14:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbTESSWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 14:22:40 -0400
Received: from palrel10.hp.com ([156.153.255.245]:6039 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262252AbTESSWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 14:22:37 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16073.9205.641605.741130@napali.hpl.hp.com>
Date: Mon, 19 May 2003 11:35:33 -0700
To: Arjan van de Ven <arjanv@redhat.com>
Cc: davidm@hpl.hp.com, "David S. Miller" <davem@redhat.com>,
       Andrew Morton <akpm@digeo.com>, Andi Kleen <ak@muc.de>,
       john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       David Mosberger <davidm@napali.hpl.hp.com>
Subject: Re: time interpolation hooks
In-Reply-To: <20030519174203.A7061@devserv.devel.redhat.com>
References: <20030516142311.3844ee97.akpm@digeo.com>
	<16069.24454.349874.198470@napali.hpl.hp.com>
	<1053139080.7308.6.camel@rth.ninka.net>
	<16073.5555.158600.61609@napali.hpl.hp.com>
	<20030519174203.A7061@devserv.devel.redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 19 May 2003 17:42:03 +0000, Arjan van de Ven <arjanv@redhat.com> said:

  Arjan> On Mon, May 19, 2003 at 10:34:43AM -0700, David Mosberger wrote:

  >> struct time_interpolator {
  >> void (*update_wall_time) (long delta_nsec);
  >> void (*reset_wall_time) (long delta_nsec);
  >> unsigned long frequency;	/* frequency in counts/second */
  >> unsigned long drift;		/* drift in parts-per-million (?) */
  >> };

  Arjan> probably also a "get interpolated value" kind of thing ?

Yes, of course.  Not a good idea to write an email in a hurry.

  Arjan> other than that it seems to match what I had in mind.
  Arjan> For the score we may need something creative; I'm not sure all timers
  Arjan> have a defined drift, otoh parts-per-million seems to be the
  Arjan> standard mechanism of reporting this.

What could you possibly do about a timer with an unknown drift?
Perhaps give preference to higher frequency, even if the drift is
unknown?  In any case, I suppose we can fine-tune the policy
afterwards.

Andrew, I assume it's OK with you if I update the ia64 code to the
proposed interface and then send you an updated patch?

	--david
