Return-Path: <linux-kernel-owner+w=401wt.eu-S1752725AbWLOPRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbWLOPRd (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 10:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752729AbWLOPRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 10:17:33 -0500
Received: from smtp-dmz-235-friday.dmz.nerim.net ([195.5.254.235]:60020 "EHLO
	kellthuzad.dmz.nerim.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752726AbWLOPRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 10:17:32 -0500
X-Greylist: delayed 1716 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 10:17:32 EST
Date: Fri, 15 Dec 2006 15:47:51 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Olivier Galibert <galibert@pobox.com>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sysfs file creation result nightmare
Message-Id: <20061215154751.86a2dbdd.khali@linux-fr.org>
In-Reply-To: <1165712131.1103.166.camel@localhost.localdomain>
References: <20061209165606.2f026a6c.khali@linux-fr.org>
	<1165694351.1103.133.camel@localhost.localdomain>
	<20061209123817.f0117ad6.akpm@osdl.org>
	<20061209214453.GA69320@dspnet.fr.eu.org>
	<20061209135829.86038f32.akpm@osdl.org>
	<20061209223418.GA76069@dspnet.fr.eu.org>
	<20061209145303.3d5fe141.akpm@osdl.org>
	<1165712131.1103.166.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben,

On Sun, 10 Dec 2006 11:55:31 +1100, Benjamin Herrenschmidt wrote:
> > And (ultimately) make the function return void.
> > 
> > Yes, that's probably a valid approach - we've discussed it before but nobody has
> > taken it further.
> 
> I would have preferred that approach (with a WARN_ON rather than a BUG
> though). On the other hand that would make it slightly harder for the
> few cases (if any ?) who actually want something like a "create if it
> doesn't exist already" semantic.

Let's just boldly state that nobody wants that semantic, if it helps.

> I'm a bit worried by the amount of code added by systematic checking of
> the results for cases that really should never happen. That's why I
> prefer a BUG/WARN type semantic.
> 
> Maybe the best is to have the examples like radeonfb actually do the
> 
> WARN_ON(sysfs_create_file(...));

Beware that sysfs_remove_bin_file() will complain loudly if you later
attempt to delete that file that was never created.

-- 
Jean Delvare
