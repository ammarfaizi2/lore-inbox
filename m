Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262581AbVCPNbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbVCPNbq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 08:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbVCPNa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 08:30:59 -0500
Received: from smtpout19.mailhost.ntl.com ([212.250.162.19]:36706 "EHLO
	mta13-winn.mailhost.ntl.com") by vger.kernel.org with ESMTP
	id S262581AbVCPNaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 08:30:10 -0500
Subject: Re: Bogus buffer length check in linux-2.6.11  read()
From: Ian Campbell <ijc@hellion.org.uk>
To: linux-os@analogic.com
Cc: Tom Felker <tfelker2@uiuc.edu>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0503160724120.16304@chaos.analogic.com>
References: <Pine.LNX.4.61.0503151257450.12264@chaos.analogic.com>
	 <200503152056.16287.tfelker2@uiuc.edu>
	 <Pine.LNX.4.61.0503160724120.16304@chaos.analogic.com>
Content-Type: text/plain
Date: Wed, 16 Mar 2005 13:30:00 +0000
Message-Id: <1110979800.3057.69.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2005-03-16 at 07:29 -0500, linux-os wrote:

> This means that the read() is no longer perfectly happy
> to corrupt all of the user's memory which is the defacto
> correct response for a bad buffer as shown. Instead, some
> added "check in software" claims to prevent this, but
> is wrong anyway because it can't possibly know how much
> data area is available.

The manpage for read(2) that I've got says

       EFAULT buf is outside your accessible address space.

which is exactly what it would appear
        if (unlikely(!access_ok(VERIFY_WRITE, buf, count)))
                return -EFAULT;
checks for. Assuming this is the check you are bitching about -- you
could be a little more precise if you are going to complain about stuff.

Ian.

-- 
Ian Campbell

flannister, n.:
	The plastic yoke that holds a six-pack of beer together.
		-- "Sniglets", Rich Hall & Friends

