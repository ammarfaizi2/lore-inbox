Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262352AbVEMMrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbVEMMrm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 08:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbVEMMrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 08:47:42 -0400
Received: from orb.pobox.com ([207.8.226.5]:36498 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262352AbVEMMrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 08:47:39 -0400
Date: Fri, 13 May 2005 05:47:35 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Gabor MICSKO <gmicsko@szintezis.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050513124735.GA7436@ip68-225-251-162.oc.oc.cox.net>
References: <1115963481.1723.3.camel@alderaan.trey.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115963481.1723.3.camel@alderaan.trey.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 07:51:20AM +0200, Gabor MICSKO wrote:
> Is this flaw affects the current stable Linux kernels? Workaround?
> Patch?

Some pages with relevant information:
http://www.ussg.iu.edu/hypermail/linux/kernel/0403.2/0920.html
http://bugzilla.kernel.org/show_bug.cgi?id=2317

AFAICT, the workaround is something like this:
1. If possible, disable HyperThreading in BIOS.
2. If you have only one CPU, boot a UP kernel rather than SMP.
3. If you have 2 or more CPU's and you can't disable HT in the BIOS,
   boot with "maxcpus=n", where "n" is the number of physical CPU's
   in the computer (e.g. "maxcpus=2"). If you are running a kernel
   earlier than 2.6.5 or 2.4.26, this probably isn't going to work.
   If you try this, check dmesg afterward to make sure it worked
   properly (see the bugzilla.kernel.org URL for details).
4. If you would try #3 except you are running a 2.4.xx *vendor* kernel
   (not mainline), where xx < 26, try "noht".
5. If #3 and #4 don't work, try "acpi=off".

Option #3 ("maxcpus=2") is what I expect to be deploying in the next
several hours, FWIW...

-Barry K. Nathan <barryn@pobox.com>
