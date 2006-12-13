Return-Path: <linux-kernel-owner+w=401wt.eu-S932518AbWLMC6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbWLMC6x (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 21:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWLMC6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 21:58:53 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:60737 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932518AbWLMC6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 21:58:52 -0500
X-Greylist: delayed 1628 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 21:58:52 EST
Date: Tue, 12 Dec 2006 20:31:32 -0600
From: Erik Jacobson <erikj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Erik Jacobson <erikj@sgi.com>, linux-kernel@vger.kernel.org,
       guillaume.thouvenin@bull.net, matthltc@us.ibm.com
Subject: Re: [PATCH] connector: Some fixes for ia64 unaligned access errors
Message-ID: <20061213023132.GA29897@sgi.com>
References: <20061207232213.GA29340@sgi.com> <1165881166.24721.71.camel@localhost.localdomain> <20061212175411.GA20407@sgi.com> <20061212164504.d6f8a3cb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061212164504.d6f8a3cb.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But it's rather a lot of churn for such a thing.  Did you consider simply using
> put_unaligned() against the specific offending field(s)?

Hi.  This was not considered.

I wanted to give you some quick feedback, so I tried your suggestion in the
fork path.  It seemed to fix the problem as well.

put_unaligned(timespec_to_ns(&ts), (__u64 *) &ev->timestamp_ns);

Is what I tried.

I'm on vacation tomorrow but on Thursday, if you like, I can whip up
a patch that does this and test it more thoroughly.  Is this the
direction you prefer?  What I did just now was really quick and dirty
to see if it has a shot or not but it looks like put_unaligned will
fix it too.

-- 
Erik Jacobson - Linux System Software - SGI - Eagan, Minnesota
