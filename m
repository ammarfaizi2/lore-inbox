Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbVG0SuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbVG0SuM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 14:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbVG0SuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 14:50:05 -0400
Received: from palrel10.hp.com ([156.153.255.245]:33996 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262451AbVG0Ssf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 14:48:35 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: /proc/<pid>/maps syntax
Date: Wed, 27 Jul 2005 11:48:33 -0700
Message-ID: <65953E8166311641A685BDF71D8658262B70C2@cacexc12.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: /proc/<pid>/maps syntax
Thread-Index: AcWS28nq1KVe7mXyTzOzEqv2Bcl+eQ==
From: "Boehm, Hans" <hans.boehm@hp.com>
To: <gc@linux.hpl.hp.com>
Cc: <linux-kernel@vger.kernel.org>, <ak@suse.de>
X-OriginalArrivalTime: 27 Jul 2005 18:48:33.0737 (UTC) FILETIME=[CA2D0B90:01C592DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI -

[I'm not subscribed the kernel list.]

The syntax for /proc/<pid>/maps as exported by
the Linux kernel changed around August 2003.
The layout of individual lines used to start
with a bunch of fixed width fields (mostly addresses).
It no longer does on 64-bit platforms.  This
introduced subtle breakage in our garbage collector.
I'll post a patch shortly,  though it seems to cause
problems mostly in nonstandard configurations.  

I copied the kernel list, since I'd like to

a) Encourage better documentation of such formats
(as if I didn't have that problem).

b) Possibly encourage consideration of other alternatives
in future issues along these lines.

Presumably this was done, so that 32-bit apps could
decode /proc/self/maps?

The down side is that

a) It broke some existing 64-bit code.

b) We ended up with an inferior format in the long run.
Both the fixed-field width format, and a hypothetical
alternative with no leading zeroes, have advantages in
speeding up parsing.  The latter is shorter, and probably
easier to generate.  The current hybrid seems to lose
both benefits.

Perhaps the documentation should clearly state that
address and offset fields may or may not have leading zeroes,
and declare the intent to eventually remove the remaining
leading zeroes?  I think that would have no impact on a sane
parser that wasn't already broken by the last change?

Hans
