Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264768AbTFERhH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 13:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264777AbTFERhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 13:37:07 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:18342 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264768AbTFERhF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 13:37:05 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: dm-devel@sistina.com, Daniel Phillips <dphillips@sistina.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [dm-devel] Re: [RFC] device-mapper ioctl interface
Date: Thu, 5 Jun 2003 12:50:30 -0500
User-Agent: KMail/1.5
References: <20030605093943.GD434@fib011235813.fsnet.co.uk> <200306051147.10775.kevcorry@us.ibm.com> <200306051900.37276.dphillips@sistina.com>
In-Reply-To: <200306051900.37276.dphillips@sistina.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306051250.30994.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 June 2003 12:00, Daniel Phillips wrote:
> On Thursday 05 June 2003 18:47, Kevin Corry wrote:
> > 2) Removing suspended devices. The current code (2.5.70) does not allow a
> > suspended device to be removed/unlinked from the ioctl interface, since
> > removing it would leave you with no way to resume it (and hence flush any
> > pending I/Os). Alasdair mentioned a couple of new ideas. One would be to
> > reload the device with an error-map and force it to resume, thus erroring
> > any pending I/Os and allowing the device to be removed. This seems a bit
> > heavy-handed.
>
> Which is the heavy-handed part?

The part about automatically reloading the table with an error map and forcing 
it to resume. It just seemed to me that user-space ought to be able to gather 
enough information to determine that a device needed to be resumed before it 
could be removed. Thus the kernel driver wouldn't be forced to implement such 
a policy.

Talking with Alasadair again, he mentioned a case I hadn't considered. Devices 
would now be created without a mapping and initially suspended. If some other 
error occurred, and you decided to just delete the device before loading a 
mapping, it would fail.  And having to resume a device with no mapping just 
to be able to delete it definitely seems odd.

So, it's not like I'm dead-set against this idea. I was just curious what the 
reasoning was behind this change.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/

