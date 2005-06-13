Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVFMNsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVFMNsr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 09:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVFMNsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 09:48:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48076 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261569AbVFMNsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 09:48:35 -0400
Date: Mon, 13 Jun 2005 09:48:26 -0400
From: Neil Horman <nhorman@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Neil Horman <nhorman@redhat.com>, Matthew Wilcox <matthew@wil.cx>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC] fcntl: add ability to stop monitored processes
Message-ID: <20050613134826.GB8810@hmsendeavour.rdu.redhat.com>
References: <20050611000548.GA6549@hmsendeavour.rdu.redhat.com> <20050611180715.GK24611@parcelfarce.linux.theplanet.co.uk> <20050611193500.GC1097@devserv.devel.redhat.com> <20050612181006.GC2229@hmsendeavour.rdu.redhat.com> <1118643185.5260.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118643185.5260.12.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 08:13:04AM +0200, Arjan van de Ven wrote:
> On Sun, 2005-06-12 at 14:10 -0400, Neil Horman wrote:
> > How about this?  Its the same feature, with an added check in fcntl_dirnotify to
> > ensure that only processes with CAP_SYS_ADMIN set can tell processes preforming
> > the monitored actions to stop.
> 
> SIGSTOP is kinda rude I think though..... I mean, how do you suppose you
> restart said processes again? manual sysadmin work?
> 
The idea I had was to catch processes which are preforming ostensibly
undesireable filesystem operations (as defined by the actions that F_NOTIFY can
monitor).  I'm not sure how else to avoid the race condition that can arise
between the delivery of the F_NOTIFY signal to the monitoring process, and the
exiting of the monitored process. If you have another thought, I'm certainly
open to it.

Re: restarting processes.  If a sysadmin wants to manually resart stopped
processes, that would certainly be an option.  My thought was that the
monitoring process could do it in code.  notice this patch also delivers the pid
of the stopped process in si_pid to the process receiving the signal.

Regards
Neil

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/
