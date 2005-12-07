Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbVLGOdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVLGOdn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 09:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbVLGOdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 09:33:43 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:50372 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751095AbVLGOdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 09:33:42 -0500
Date: Wed, 7 Dec 2005 14:33:37 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-ide <linux-ide@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, pavel <pavel@ucw.cz>,
       Len Brown <len.brown@intel.com>, akpm <akpm@osdl.org>
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
Message-ID: <20051207143337.GA16938@srcf.ucam.org>
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com> <20051206222001.GA14171@srcf.ucam.org> <58cb370e0512070017u606ee22fse207b9a859856dd4@mail.gmail.com> <20051207131454.GA16558@srcf.ucam.org> <58cb370e0512070619k17022317v8e871dc3f9cafb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0512070619k17022317v8e871dc3f9cafb9@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 03:19:07PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On 12/7/05, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > On Wed, Dec 07, 2005 at 09:17:31AM +0100, Bartlomiej Zolnierkiewicz wrote:
> >
> > > Isn't ide-io.c:ide_{start,complete}_power_step() enough?
> >
> > No.
> 
> Why? :)

Heh :) The failure is (IIRC, I don't have the serial logs to hand) 
before ide_start_power_step() is called. We get to start_request(), and 
the system then fails with "bus not ready on wakeup" and "drive not 
ready on wakeup". Calling the _GTM and _STM ACPI methods before then 
lets the system come back up normally.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
