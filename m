Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWHXMmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWHXMmN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 08:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWHXMmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 08:42:13 -0400
Received: from smarthost2.sentex.ca ([205.211.164.50]:19651 "EHLO
	smarthost2.sentex.ca") by vger.kernel.org with ESMTP
	id S1751207AbWHXMmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 08:42:12 -0400
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'David Woodhouse'" <dwmw2@infradead.org>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>
Subject: RE: Serial custom speed deprecated?
Date: Thu, 24 Aug 2006 08:41:44 -0400
Organization: Connect Tech Inc.
Message-ID: <033001c6c77a$a7d8ab10$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <1156411101.3012.15.camel@pmac.infradead.org>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Woodhouse [mailto:dwmw2@infradead.org] 
> On Wed, 2006-08-23 at 17:41 -0400, Stuart MacDonald wrote:
> > If custom speeds are deprecated, what's the new method for setting
> > them? Specifically, how can the SPD_CUST functionality be 
> accomplished
> > without that flag? I've checked 2.5.64 and 2.6.17, and don't see how
> > it is possible. 
> 
> We need a way to set the baud rate as an _integer_ instead of 
> the Bxxxx
> flags.

Agreed. Our products have required this functionality since at least
1999.

It appears that the current method has been deprecated before the next
method has been constructed though. Is that correct?

The easiest thing is likely to add a new ioctl to serial_core.c
specifically for setting the baud rate. It takes an integer baud rate
and returns success or error. It will need to be able to call a
subdriver's set_baud_rate() as well, which means extending the ops
structure, because some hardware (like the XR16C954 IIRC) has
non-standard ways of actually programming the baud rate.

Hm, after some thought I think the core won't actually end up doing
anything except dispatching. So the better way is to add ioctls to the
subdrivers directly.

..Stu

