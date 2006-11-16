Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424324AbWKPVel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424324AbWKPVel (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424662AbWKPVel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:34:41 -0500
Received: from gundega.hpl.hp.com ([192.6.19.190]:53206 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1424324AbWKPVek
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:34:40 -0500
Date: Thu, 16 Nov 2006 13:32:09 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: William Cohen <wcohen@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Komuro <komurojun-mbn@nifty.com>, Ernst Herzberg <earny@net4u.de>,
       Andre Noll <maan@systemlinux.org>, oprofile-list@lists.sourceforge.net,
       Jens Axboe <jens.axboe@oracle.com>, Adrian Bunk <bunk@stusta.de>,
       linux-usb-devel@lists.sourceforge.net, phil.el@wanadoo.fr,
       Eric Dumazet <dada1@cosmosbay.com>, Ingo Molnar <mingo@redhat.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Prakash Punnoor <prakash@punnoor.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Len Brown <len.brown@intel.com>, Alex Romosan <romosan@sycorax.lbl.gov>,
       Linus Torvalds <torvalds@osdl.org>, discuss@x86-64.org, gregkh@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [discuss] Re: 2.6.19-rc5: known regressions (v3)
Message-ID: <20061116213209.GB19306@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org> <20061116032109.GG9579@bingen.suse.de> <20061115210501.feaf230c.akpm@osdl.org> <200611160804.31806.ak@suse.de> <455C8520.8060109@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455C8520.8060109@redhat.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Nov 16, 2006 at 10:34:56AM -0500, William Cohen wrote:
> 
> Is this going to require sharing the nmi interrupt and knowing which perfcounter 
> register triggered the interrupt to get the correct action?  Currently the 
> oprofile interrupt handler assumes any performance monitoring counter it sees 
> overflowing is something it should count.
> 
Yes, you need to share the NMI interrupt. In my next perfmon patch you will
see that this can be made to work. You just need to add one check in the 
NMI handler callback: is it for me or else try perfmon? Perfmon can auto-detect
if NMI is active and give up the right counter (there is an API to check
what is reserved). The interface propagates the list of available counters
to apps which then pass the information onto libpfm which tries to use
the remaining counters.

-- 
-Stephane
