Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVEPLEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVEPLEP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 07:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVEPLEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 07:04:14 -0400
Received: from colin.muc.de ([193.149.48.1]:51983 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261429AbVEPLEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 07:04:01 -0400
Date: 16 May 2005 13:04:00 +0200
Date: Mon, 16 May 2005 13:03:59 +0200
From: Andi Kleen <ak@muc.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andy Isaacson <adi@hexapodia.org>, "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>, linux-kernel@vger.kernel.org,
       mpm@selenic.com, tytso@mit.edu
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050516110359.GA70871@muc.de>
References: <1115963481.1723.3.camel@alderaan.trey.hu> <m164xnatpt.fsf@muc.de> <1116009483.4689.803.camel@rebel.corp.whenu.com> <20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org> <20050515094352.GB68736@muc.de> <m1oebbwsrf.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1oebbwsrf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The only solution I have seen proposed so far that seems to work
> is to not schedule untrusted processes simultaneously with 
> the security code.  With the current API that sounds like
> a root process killing off, or at least stopping all non-root
> processes until the critical process has finished.

With virtualization and a hypervisor freely scheduling it is quite 
impossible to guarantee this. Of course as always the signal 
is quite noisy so it is unclear if it is exploitable in practical 
settings. On virtualized environments you cannot use ps to see
if a crypto process is running. 

> And those same processors will have the same problem if the share
> significant cpu resources.  Ideally the entire problem set
> would fit in the cache and the cpu designers would allow cache
> blocks to be locked but that is not currently the case.  So a shared
> L3 cache with dual core processors will have the same problem.

At some point the signal gets noisy enough and the assumptions
an attacker has to make too great for it being an useful attack.
For me it is not even clear it is a real attack on native Linux, at 
least the setup in the paper looked highly artifical and quite impractical. 
e.g. I suppose it would be quite difficult to really synchronize
to the beginning and end of the RSA encryptions on a server that
does other things too.

-Andi

