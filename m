Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262672AbVAFAMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbVAFAMz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 19:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262670AbVAFAMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 19:12:55 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:4077 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262672AbVAFAMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 19:12:42 -0500
Subject: Re: [PATCH] prohibit slash in proc directory entry names
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: olh@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20050105160704.7dc36ca4.akpm@osdl.org>
References: <20050105075357.GA12473@suse.de>
	 <20050105000129.63478670.akpm@osdl.org>
	 <1104952961.10796.41.camel@pants.austin.ibm.com>
	 <20050105160704.7dc36ca4.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 05 Jan 2005 18:12:56 -0600
Message-Id: <1104970376.9193.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-05 at 16:07 -0800, Andrew Morton wrote:
> Nathan Lynch <nathanl@austin.ibm.com> wrote:
> >
> > proc_create() needs to check that the name of an entry to be created
> >  does not contain a '/' character.
> > 
> >  To test, I hacked the ibmveth driver to try to call request_irq with a
> >  bogus "foo/bar" devname.  The creation of the /proc/irq/1234/xxx entry
> >  silently fails, as intended.  Perhaps the irq code should be made to
> >  check for the failure.
> > 
> >  Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>
> > 
> >  Index: 2.6.10/fs/proc/generic.c
> >  ===================================================================
> >  --- 2.6.10.orig/fs/proc/generic.c	2004-12-24 21:35:40.000000000 +0000
> >  +++ 2.6.10/fs/proc/generic.c	2005-01-05 18:44:56.000000000 +0000
> >  @@ -551,6 +551,11 @@
> >   
> >   	if (!(*parent) && xlate_proc_name(name, parent, &fn) != 0)
> >   		goto out;
> >  +
> >  +	/* At this point there must not be any '/' characters beyond *fn */
> >  +	if (strchr(fn, '/'))
> >  +		goto out;
> >  +
> 
> hm.  From a brief code-squint I don't see how the string can ever have a
> slash in it by this stage.  Unless the caller provided a non-null *parent
> and we never called xlate_proc_name()?

Right.


