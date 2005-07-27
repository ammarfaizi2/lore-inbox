Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbVG0T6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVG0T6s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 15:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbVG0T4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 15:56:43 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:39608 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262150AbVG0Tym
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 15:54:42 -0400
Date: Wed, 27 Jul 2005 14:54:56 -0500
From: serue@us.ibm.com
To: James Morris <jmorris@redhat.com>
Cc: serue@us.ibm.com, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton <akpm@osdl.org>, Michael Halcrow <mhalcrow@us.ibm.com>
Subject: Re: [patch 0/15] lsm stacking v0.3: intro
Message-ID: <20050727195456.GC23040@serge.austin.ibm.com>
References: <20050727181732.GA22483@serge.austin.ibm.com> <Lynx.SEL.4.62.0507271527390.1844@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Lynx.SEL.4.62.0507271527390.1844@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, James.  I'll give this a shot and send out performance results
this weekend or next week.

thanks,
-serge

Quoting James Morris (jmorris@redhat.com):
> On Wed, 27 Jul 2005 serue@us.ibm.com wrote:
> 
> > if interested in the performance results.  I am certainly interested in
> > ways to further speed up security_get_value.
> 
> What about having a small static array of security blob pointers for the 
> common case (e.g. SELinux + capabilities + perhaps something else), the 
> total number of which is compile-time configurable.  Reserve one pointer 
> at the end for the hlist.
> 
> When a module registers with stacker, if there's room in the array, it 
> reserves a slot for the module.  This slot value can be stored by stacker 
> in a handle held by the module (along with the stacker ID etc. perhaps).
> 
> Calls to security_get_value() etc. can then be very fast and simple for 
> the common case, where the security blob is a pointer offset by an index 
> in a small array.  The arbitrarily sized hlist would then be a fallback 
> with a higher performance hit.
> 
> 
> - James
> -- 
> James Morris
> <jmorris@redhat.com>
> 
> 
