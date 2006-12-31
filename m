Return-Path: <linux-kernel-owner+w=401wt.eu-S933175AbWLaNjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933175AbWLaNjZ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 08:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933172AbWLaNjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 08:39:24 -0500
Received: from ns.firmix.at ([62.141.48.66]:49345 "EHLO ns.firmix.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933175AbWLaNjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 08:39:23 -0500
Subject: Re: [PATCH] [DISCUSS] Make the variable NULL after freeing it.
From: Bernd Petrovitsch <bernd@firmix.at>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Pavel Machek <pavel@ucw.cz>, Amit Choudhary <amit2030@yahoo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0612280952450.15825@yvahk01.tjqt.qr>
References: <20061221234127.29189.qmail@web55606.mail.re4.yahoo.com>
	 <20061227171010.GA4088@ucw.cz>
	 <Pine.LNX.4.61.0612280952450.15825@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: http://www.firmix.at/
Date: Sun, 31 Dec 2006 14:38:32 +0100
Message-Id: <1167572312.3318.47.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-Firmix-Scanned-By: MIMEDefang 2.56 on ns.firmix.at
X-Spam-Score: -2.41 () AWL,BAYES_00,FORGED_RCVD_HELO
X-Firmix-Spam-Status: No, hits=-2.41 required=5
X-Firmix-Spam-Score: -2.41 () AWL,BAYES_00,FORGED_RCVD_HELO
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-28 at 09:54 +0100, Jan Engelhardt wrote:
> On Dec 27 2006 17:10, Pavel Machek wrote:
> 
> >> Was just wondering if the _var_ in kfree(_var_) could be set to
> >> NULL after its freed. It may solve the problem of accessing some
> >> freed memory as the kernel will crash since _var_ was set to NULL.
> >> 
> >> Does this make sense? If yes, then how about renaming kfree to
> >> something else and providing a kfree macro that would do the
> >> following:
> >> 
> >> #define kfree(x) do { \
> >>                       new_kfree(x); \
> >>                       x = NULL; \
> >>                     } while(0)
> >> 
> >> There might be other better ways too.

----  snip  ----
(x) = NULL; \
----  snip  ----
?

> >No, that would be very confusing. Otoh having
> >KFREE() do kfree() and assignment might be acceptable.
> 
> What about setting x to some poison value from <linux/poison.h>?

That depends on the decision/definition if (so called) "double free" is
an error or not (and "free(NULL)" must work in POSIX-compliant
environments).
Personally I think it is pointless to disallow "kfree(NULL)" by using
some poison value and force people to add a "we have to free that
variable" variable to work around it instead of keeping it NULL (which
makes the "kfree($variable)" a no-op).
Former discussions are to be found in the archives ......

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

