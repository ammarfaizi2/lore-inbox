Return-Path: <linux-kernel-owner+w=401wt.eu-S1757216AbWLJAzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757216AbWLJAzw (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 19:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758826AbWLJAzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 19:55:52 -0500
Received: from gate.crashing.org ([63.228.1.57]:33108 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757216AbWLJAzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 19:55:51 -0500
Subject: Re: sysfs file creation result nightmare (WAS radeonfb: Fix
	sysfs_create_bin_file warnings)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Olivier Galibert <galibert@pobox.com>, Jean Delvare <khali@linux-fr.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20061209145303.3d5fe141.akpm@osdl.org>
References: <20061209165606.2f026a6c.khali@linux-fr.org>
	 <1165694351.1103.133.camel@localhost.localdomain>
	 <20061209123817.f0117ad6.akpm@osdl.org>
	 <20061209214453.GA69320@dspnet.fr.eu.org>
	 <20061209135829.86038f32.akpm@osdl.org>
	 <20061209223418.GA76069@dspnet.fr.eu.org>
	 <20061209145303.3d5fe141.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 10 Dec 2006 11:55:31 +1100
Message-Id: <1165712131.1103.166.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> And (ultimately) make the function return void.
> 
> Yes, that's probably a valid approach - we've discussed it before but nobody has
> taken it further.

I would have preferred that approach (with a WARN_ON rather than a BUG
though). On the other hand that would make it slightly harder for the
few cases (if any ?) who actually want something like a "create if it
doesn't exist already" semantic.

I'm a bit worried by the amount of code added by systematic checking of
the results for cases that really should never happen. That's why I
prefer a BUG/WARN type semantic.

Maybe the best is to have the examples like radeonfb actually do the

WARN_ON(sysfs_create_file(...));

Ben.
 

