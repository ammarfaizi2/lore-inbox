Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbVBPNh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbVBPNh1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 08:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVBPNh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 08:37:27 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:44735 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S261998AbVBPNhV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 08:37:21 -0500
Subject: Re: Thoughts on the "No Linux Security Modules framework" old
	claims
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, rsbac@rsbac.org,
       "linux-security-module@wirex.com" <linux-security-module@wirex.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1108560543.3826.89.camel@localhost.localdomain>
References: <1108507089.3826.83.camel@localhost.localdomain>
	 <200502160421.j1G4Ls7l004329@turing-police.cc.vt.edu>
	 <1108560543.3826.89.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Organization: National Security Agency
Message-Id: <1108560613.19756.76.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 16 Feb 2005 08:30:13 -0500
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-16 at 08:29, Lorenzo Hernández García-Hierro wrote:
> Yes, there are many cases that apply to such scenario and context, this
> may be worth to work on, but think it's main shortcoming is that it cuts
> performance and adds further overlapping to the DAC checks, that should
> be the first ones being called (as most times they do) and then apply
> the LSM basis, so, post-processing will be only required if the DAC
> checks get in override or passed, without adding too-much overhead to
> the current behavior.
> 
> So, I just agree partially, but yes, maybe modifying the DAC checks
> themselves and add what-ever-else helper function to handle by-default
> auditing in certain operations could be interesting.

Audit is being handled by a separate audit framework, not by LSM.  There
is already support in the Linux 2.6 kernel for auditing at syscall exit
(thereby guaranteeing that you capture the final return value in all
cases), with the ability of an LSM to enable such auditing for a
particular event from its hook functions.  Further, there is ongoing
work (see the linux-audit mailing list) for a set of audit-related hooks
that will allow auditing based on object identity and the requested mode
separate from any particular LSM.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

