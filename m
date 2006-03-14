Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWCNWMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWCNWMA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbWCNWMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:12:00 -0500
Received: from fmr17.intel.com ([134.134.136.16]:2188 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S964791AbWCNWMA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:12:00 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: [PATCH] provide hrtimer exports for module use [Was: Exports for hrtimer APIs]
Date: Tue, 14 Mar 2006 14:11:44 -0800
Message-ID: <CBDB88BFD06F7F408399DBCF8776B3DC06A92BAC@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] provide hrtimer exports for module use [Was: Exports for hrtimer APIs]
Thread-Index: AcZHr0cFtDO0p068SiapIBwj5obT7wAAblKw
From: "Stone, Joshua I" <joshua.i.stone@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>
X-OriginalArrivalTime: 14 Mar 2006 22:11:46.0465 (UTC) FILETIME=[489E3110:01C647B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Wordwrapped...

Yes, Outlook/Exchange betrayed me... sorry.

> gee, that's a lot of exports.  I don't know whether all of these
> would be considered stable over the long-term?

For that first patch, I simply looked for the functions that looked
appropriate for general users of hrtimers.  If you would like to be more
conservative, these five are all I need for SystemTap:

EXPORT_SYMBOL_GPL(ktime_add_ns);
EXPORT_SYMBOL_GPL(hrtimer_forward);
EXPORT_SYMBOL_GPL(hrtimer_start);
EXPORT_SYMBOL_GPL(hrtimer_cancel);
EXPORT_SYMBOL_GPL(hrtimer_init);

> Can you tell us a bit about why systemtap modules need the hrtimer
> capability?  How it's being used and for what, etc?

Sure - SystemTap uses timers to provide an asynchronous probe during
module execution.  This might be utilized for polling kernel states, for
flushing trace data, and perhaps other similar uses.  Currently we're
using the main timer APIs - add_timer, mod_timer, etc.

My motivation for moving to hrtimer is because of what I read in its
documentation - basically that the timer wheel is best for timeout cases
which are rarely recascaded.  The way SystemTap uses timers is more for
defining intervals, and they are always cascaded until the module is
complete.  The hrtimers seem more suited to this methodology.

Correct me if I'm wrong...

Josh
