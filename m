Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWAKOEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWAKOEw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 09:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWAKOEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 09:04:52 -0500
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:50833 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932141AbWAKOEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 09:04:51 -0500
From: Ian Campbell <ijc@hellion.org.uk>
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       lgb@lgb.hu
In-Reply-To: <1136987743.6547.122.camel@tara.firmix.at>
References: <20060111123745.GB30219@lgb.hu>
	 <1136983910.2929.39.camel@laptopd505.fenrus.org>
	 <20060111130255.GC30219@lgb.hu>  <1136985918.6547.115.camel@tara.firmix.at>
	 <1136987361.6517.1.camel@localhost.localdomain>
	 <1136987743.6547.122.camel@tara.firmix.at>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 14:05:16 +0000
Message-Id: <1136988316.6517.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 213.104.11.16
X-SA-Exim-Mail-From: ijc@hellion.org.uk
Subject: Re: OT: fork(): parent or child should run first?
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on hopkins.hellion.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 14:55 +0100, Bernd Petrovitsch wrote:
> On Wed, 2006-01-11 at 13:49 +0000, Ian Campbell wrote:
> > On Wed, 2006-01-11 at 14:25 +0100, Bernd Petrovitsch wrote:
> > > Then this leaves the race if an old pid is reused in a newly created
> > > process before the last instances of that pid is cleaned up.
> > 
> > The PID won't be available to be re-used until the signal handler has
> > called waitpid() on it?
> 
> Yes.
> But ATM the signal handler calls waitpid() and stores the pid in a
> to-be-cleaned-pids array (at time X).
> The main loop at some time in the future (say at time X+N) walks through
> the to-be-cleaned-pids array and cleans them from the active-childs
> array.

yuk... I'd say the application is a bit dumb for calling waitpid before
it is actually prepared for the pid to be reclaimed. 

A possible solution would be to also defer the waitpid until the main
loop cleanup function, perhaps flagging the entry in the child array as
not-active between the signal and that time or moving the pid from the
active to an inactive array in the signal handler.

Ian.
-- 
Ian Campbell
Current Noise: Sloth - Into The Sun

To err is human,
To purr feline.
		-- Robert Byrne

