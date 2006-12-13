Return-Path: <linux-kernel-owner+w=401wt.eu-S932420AbWLMCmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWLMCmu (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 21:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWLMCmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 21:42:50 -0500
Received: from smtp.osdl.org ([65.172.181.25]:42881 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932420AbWLMCmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 21:42:49 -0500
Date: Tue, 12 Dec 2006 18:38:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Erik Jacobson <erikj@sgi.com>
Cc: linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net,
       matthltc@us.ibm.com
Subject: Re: [PATCH] connector: Some fixes for ia64 unaligned access errors
Message-Id: <20061212183826.6edb3a3f.akpm@osdl.org>
In-Reply-To: <20061213023132.GA29897@sgi.com>
References: <20061207232213.GA29340@sgi.com>
	<1165881166.24721.71.camel@localhost.localdomain>
	<20061212175411.GA20407@sgi.com>
	<20061212164504.d6f8a3cb.akpm@osdl.org>
	<20061213023132.GA29897@sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2006 20:31:32 -0600
Erik Jacobson <erikj@sgi.com> wrote:

> > But it's rather a lot of churn for such a thing.  Did you consider simply using
> > put_unaligned() against the specific offending field(s)?
> 
> Hi.  This was not considered.
> 
> I wanted to give you some quick feedback, so I tried your suggestion in the
> fork path.  It seemed to fix the problem as well.

OK.

> put_unaligned(timespec_to_ns(&ts), (__u64 *) &ev->timestamp_ns);
> 
> Is what I tried.
> 
> I'm on vacation tomorrow but on Thursday, if you like, I can whip up
> a patch that does this and test it more thoroughly.  Is this the
> direction you prefer?  What I did just now was really quick and dirty
> to see if it has a shot or not but it looks like put_unaligned will
> fix it too.
> 

Well it's a one-liner and it makes it very clear what's going on.  So
unless there's some undiscovered downside, yes, I think it's a good way to
go.  It'll be an easier patch for the -stable guys to swallow too.

There's no particular hurry on it.
