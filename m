Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVCUADK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVCUADK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 19:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVCUADK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 19:03:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49579 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261392AbVCUACv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 19:02:51 -0500
Date: Sun, 20 Mar 2005 19:01:49 -0500
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386/x86_64 mpparse.c: kill maxcpus
Message-ID: <20050321000149.GD26230@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <20050320192549.GP4449@stusta.de> <20050320224233.GB26230@redhat.com> <20050320231232.GY4449@stusta.de> <20050320233203.GC26230@redhat.com> <20050320235946.GA4449@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050320235946.GA4449@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 12:59:46AM +0100, Adrian Bunk wrote:
 > On Sun, Mar 20, 2005 at 06:32:03PM -0500, Dave Jones wrote:
 > > On Mon, Mar 21, 2005 at 12:12:32AM +0100, Adrian Bunk wrote:
 > >  > On Sun, Mar 20, 2005 at 05:42:34PM -0500, Dave Jones wrote:
 > >  > > On Sun, Mar 20, 2005 at 08:25:49PM +0100, Adrian Bunk wrote:
 > >  > >  > Do we really need a global variable that does only hold the value of 
 > >  > >  > NR_CPUS?
 > >  > > 
 > >  > > Yes.
 > >  > >  
 > >  > > NR_CPUS = compile time
 > >  > > maxcpus = boot command line at runtime.
 > >  > 
 > >  > If this is how is was expected to work - it isn't exactly what is 
 > >  > currently implemented.
 > > 
 > > It's ugly, as its setting the same thing in two different places, but
 > > I don't see any obvious reason why it won't work.
 > >...
 > 
 > I might be too dumb, but where are the mpparse.c maxcpus variables ever 
 > set to any value different from NR_CPUS?

arch/x86_64/kernel/setup.c:parse_cmdline_early()

	...
        else if (!memcmp(from, "maxcpus=", 8)) {
            extern unsigned int maxcpus;

            maxcpus = simple_strtoul(from + 8, NULL, 0);
        }
	...


		Dave

