Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266311AbUA2Ta3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 14:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266309AbUA2T2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 14:28:42 -0500
Received: from palrel13.hp.com ([156.153.255.238]:5794 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S266316AbUA2T2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 14:28:10 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16409.24257.589224.818006@napali.hpl.hp.com>
Date: Thu, 29 Jan 2004 11:28:01 -0800
To: Matthias Fouquet-Lapar <mfl@kernel.paris.sgi.com>
Cc: davidm@hpl.hp.com, ak@suse.de (Andi Kleen), davidm@napali.hpl.hp.com,
       iod00d@hp.com, ishii.hironobu@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [RFC/PATCH, 1/4] readX_check() performance evaluation
In-Reply-To: <200401290823.i0T8NTDi024477@mtv-vpn-hw-mfl-2.corp.sgi.com>
References: <16408.3157.336306.812481@napali.hpl.hp.com>
	<200401290823.i0T8NTDi024477@mtv-vpn-hw-mfl-2.corp.sgi.com>
X-Mailer: VM 7.17 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 29 Jan 2004 09:23:20 +0100 ("CET), Matthias Fouquet-Lapar <mfl@kernel.paris.sgi.com> said:

  Matthias> We have done a rather large study with DIMMs that had SBEs
  Matthias> and have found no evidence that a SBE turns into a UCE,
  Matthias> i.e. the fact that a SBE is reported, is no indication
  Matthias> that the device might fail soon.

  Matthias> As a matter of fact the soft error rates increases while
  Matthias> parts use smaller process technologies and lower supply
  Matthias> voltages. Cosmic rays are one source for soft
  Matthias> errors. Another source are alpha particles emitted by the
  Matthias> solder.

Ehh, wait a second: you're saying that your study proved that if the
device isn't failing, it isn't failing. ;-) Of course you'll get noise
and perhaps even lots of it due to cosmic rays but this doesn't say
anything about the error pattern you when a device _is_ failing (e.g.,
due to overheating, over-clocking, or wrong voltage).  Or did your
study cover the cases where a system is operated under "out-of-spec"
situation?

  Matthias> Still I think it's important to log SBEs, but you probably
  Matthias> will need a treshhold in case you hit a hard SBE. Also
  Matthias> scrubbing the memory location (and re-read the location to
  Matthias> check if the error was transient or not) might be a good
  Matthias> idea if the memory controller supports this.  If it is a
  Matthias> true, hard SBE it should be reported. It also might be a
  Matthias> good idea to mark the page, so it does not get
  Matthias> re-allocated.

Yes.  And once I finally received Andi's earlier mails (guess I have
to thank MyDoom for that... ;-( ), it was clear that nobody argued for
turning off the error reporting.  The issue was only whether or not to
log a message via printk() (which, in this case, clearly isn't a good
idea).  So I think we're all in violent agreement.

	--david
