Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbUA2Igl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 03:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbUA2Igl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 03:36:41 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:29933 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S262048AbUA2Igi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 03:36:38 -0500
From: Matthias Fouquet-Lapar <mfl@kernel.paris.sgi.com>
Message-Id: <200401290823.i0T8NTDi024477@mtv-vpn-hw-mfl-2.corp.sgi.com>
Subject: Re: [RFC/PATCH, 1/4] readX_check() performance evaluation
To: davidm@hpl.hp.com
Date: Thu, 29 Jan 2004 09:23:20 +0100 ("CET)
Cc: ak@suse.de (Andi Kleen), davidm@napali.hpl.hp.com, iod00d@hp.com,
       ishii.hironobu@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
In-Reply-To: <16408.3157.336306.812481@napali.hpl.hp.com> from "David Mosberger" at Jan 28, 2004 11:24:05 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Andi> e.g. one bit ECC errors in memory are quite common.  And with
>   Andi> ECC memory they are not really fatal.
> 
> Yet they are a good indicator that something is wrong (not performing
> properly) or may be failing soon.  I don't think putting on blinders
> for such problems is a good idea.  Though I agree that the question of
> how to report such things without needlessly alerting Joe Clueless is
> an interesting challenge.

We have done a rather large study with DIMMs that had SBEs and have
found no evidence that a SBE turns into a UCE, i.e. the fact that a SBE is
reported, is no indication that the device might fail soon.

As a matter of fact the soft error rates increases while parts use
smaller process technologies and lower supply voltages. Cosmic rays
are one source for soft errors. Another source are alpha particles
emitted by the solder.

Still I think it's important to log SBEs, but you probably will need
a treshhold in case you hit a hard SBE. Also scrubbing the memory location
(and re-read the location to check if the error was transient or not)
might be a good idea if the memory controller supports this.
If it is a true, hard SBE it should be reported. It also might be a good
idea to mark the page, so it does not get re-allocated. 


Thanks

Matthias Fouquet-Lapar  Core Platform Software    mfl@sgi.com  VNET 521-8213
Principal Engineer      Silicon Graphics          Home Office (+33) 1 3047 4127

