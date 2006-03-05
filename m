Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWCEXwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWCEXwj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 18:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWCEXwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 18:52:39 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:64986 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932226AbWCEXwj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 18:52:39 -0500
Date: Sun, 5 Mar 2006 23:52:38 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Keith Ownes <kaos@ocs.com.au>
Subject: Re: kbuild - status on section mismatch warnings
Message-ID: <20060305235238.GE27946@ftp.linux.org.uk>
References: <20060305193012.GA14838@mars.ravnborg.org> <20060305200659.GD27946@ftp.linux.org.uk> <20060305215853.GA14998@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060305215853.GA14998@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2006 at 10:58:53PM +0100, Sam Ravnborg wrote:
> Hi Al.
> 
> > Now try x86 with sd.o non-modular.  And see
> > 
> > 
> > __init foo()
> > {
> > ....
> > 	switch(n) {
> > 	....
> > 	....
> > 	}
> > }
> Hmm, in my tree sd.o has no switch in the init function. But that does
> not change your point which is valid indeed.

sd_major() gets inlined there with sufficiently recent gcc.
 
> For the same reason references to .init.text from .rodata are not warned
> upon - there are simply too many compielr generated false positives.
> 
> Following is the original comment from reference_init.pl:

Oops, right you are - it's reference_discarded that gets buggered on that.
My apologies.  Still gets a spew on make buildcheck, though...
