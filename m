Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262244AbSJJWfW>; Thu, 10 Oct 2002 18:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262325AbSJJWfW>; Thu, 10 Oct 2002 18:35:22 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:58851 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262244AbSJJWfW>;
	Thu, 10 Oct 2002 18:35:22 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] EVMS core (3/9) discover.c
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFF9323A4C.87C7BFD1-ON85256C4E.007AF27F@pok.ibm.com>
From: "Mark Peloquin" <peloquin@us.ibm.com>
Date: Thu, 10 Oct 2002 17:53:55 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 10/10/2002 06:40:59 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/10/2002 at 05:19 PM, Andi Kleen wrote:

> > We plan to register a "__this_module.can_unload()" that
> > should prevent plugin modules from unloading during
> > discovery.

> Ok in this case. But how about when you search that list later after
> discovery for some reason and drop the lock. Then you could race with
someone
> else removing the plugin inbetween, no ?

The only time the lock is released while actively
searching the list is during discovery and direct
ioctl communication. So yes, you are correct, the
can_unload() would have to take both operations
into account. All other list operations take
place completely inside the lock. All in-use
plugins are kept from unloading by module ref
counts. Outside of the scope of the discover and
direct ioctl operations, any unused plugins
should be safe to unload.

Is something being missed?

Mark


