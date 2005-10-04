Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbVJDTWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbVJDTWg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 15:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbVJDTWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 15:22:36 -0400
Received: from smtp.innovsys.com ([66.115.232.196]:58514 "EHLO
	mail.innovsys.com") by vger.kernel.org with ESMTP id S964924AbVJDTWg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 15:22:36 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: clock skew on B/W G3
Date: Tue, 4 Oct 2005 14:22:29 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B85947A@ismail.innsys.innovsys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: clock skew on B/W G3
thread-index: AcXJF/syrS/lYtTKT9yEWAZbNBalMQAADJJQ
From: "Rune Torgersen" <runet@innovsys.com>
To: <george@mvista.com>
Cc: "Paul Mackerras" <paulus@samba.org>, "Marc" <marvin24@gmx.de>,
       <linuxppc-dev@ozlabs.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> From: George Anzinger [mailto:george@mvista.com] 
> But this is defined in include/asm/???.h  so you should be 
> able to set something more to your liking 
> (or rather to your archs liking).  It is true that it SHOULD 
> be defined as it is used to define 
> TICK_NSEC which is used to define the 
> jiffies<-->timeval/timespec conversions which would be VERY 
> slow it it were a variable.

Just make them variables, and compute them ONCE during boot.
ppc calls calibrate_decr() before enabling the timer interrupt anyways.

time_nsec is easy. 
in a platfrom specific file do (very simplified):

extern unsigned long time_nsec;

void platform_specific_calibrate_decr()
{
	time_nsec = REAL_TIME_NSEC;
}

This (of course) will do nothing about LATCH and ACTHZ that might be
used other places.
