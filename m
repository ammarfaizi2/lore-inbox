Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287488AbSCLXDj>; Tue, 12 Mar 2002 18:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287862AbSCLXDU>; Tue, 12 Mar 2002 18:03:20 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:26607 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S287488AbSCLXDM>; Tue, 12 Mar 2002 18:03:12 -0500
Message-ID: <3C8E8912.64435C1E@us.ibm.com>
Date: Tue, 12 Mar 2002 15:02:42 -0800
From: Larry Kessler <kessler@us.ibm.com>
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Dominik Kubla <kubla@sciobyte.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH-RFC] POSIX Event Logging, kernel 2.5.6 & 2.4.18
In-Reply-To: <3C8E7E08.C3CF4227@us.ibm.com> <20020312224101.GB12952@duron.intern.kubla.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Kubla wrote:
> 
> On Tue, Mar 12, 2002 at 02:15:36PM -0800, Larry Kessler wrote:
> > 2) If the buffer overruns the oldest events are kept, newest
> >    discarded, and a count of discarded events is reported.
> 
> Hmm. That sounds like a possible security problem to me: simply generate a
> bunch of harmless messages to fill the buffer and then one can do the nasty
> stuff...

I assume that you mean do the nasty stuff but never have anything in
your
event log indicating that it happened.  Good point, but if the buffer is
sized appropriately for the incoming volume of events and the logging
daemon 
is reading the events out of the kernel buffer (as should normally be
the case), 
then you would see the events.  

The reasoning behind this approach is to increase the liklihood that
events
indicating "root cause" would be logged and not over-written by a flood
of 
secondary events.  Keep in mind that only events originating in the
kernel (or
kernel module) are stored in this buffer.
