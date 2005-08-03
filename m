Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbVHCRA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbVHCRA1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 13:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbVHCRA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 13:00:27 -0400
Received: from fmr13.intel.com ([192.55.52.67]:53952 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S262344AbVHCRAY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 13:00:24 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] optimize writer path in time_interpolator_get_counter()
Date: Wed, 3 Aug 2005 10:00:11 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F040F6E87@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] optimize writer path in time_interpolator_get_counter()
Thread-Index: AcWYRfZFgWY9Gg32QtmwXUHtXHQEqgABVeUQ
From: "Luck, Tony" <tony.luck@intel.com>
To: "Christoph Lameter" <clameter@engr.sgi.com>,
       "Alex Williamson" <alex.williamson@hp.com>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
X-OriginalArrivalTime: 03 Aug 2005 17:00:13.0219 (UTC) FILETIME=[D074F730:01C5984C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Think about a threaded process that gets time on multiple processors 
>and then compares the times. This means that the time value obtained later 
>on one thread may indicate a time earlier than that obtained on another 
>thread. An essential requirement for time values is that they are 
>monotonically increasing. You are changing that basic nature.

But this comes down to how much time does it take for two threads
to perform some synchronization operation so that they know that one
thread made the call before the other[1]?  I think that it might be
possible to make the claim[2] that we have synchonized the ITC values
more closely than the fastest user synchronization method ... hence
a simplistic kernel implementation will be monotonic in practice.

-Tony

[1] It is pointless to expect one return value to be greater than
another unless we know that the calls were made in a particular sequence.

[2] Hands are waving so wildly here that it is a wonder that I can
even type.
