Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbVHIPyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbVHIPyD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 11:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbVHIPyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 11:54:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44516 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964837AbVHIPyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 11:54:01 -0400
Date: Tue, 9 Aug 2005 11:53:44 -0400
From: Dave Jones <davej@redhat.com>
To: Tim Waugh <twaugh@redhat.com>
Cc: linux-parport@lists.infradead.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-parport] Incorrect permissions on parport sysctls.
Message-ID: <20050809155344.GG5844@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Tim Waugh <twaugh@redhat.com>, linux-parport@lists.infradead.org,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20050809044440.GA7725@redhat.com> <20050809101110.GN7718@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050809101110.GN7718@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 11:11:10AM +0100, Tim Waugh wrote:
 > On Tue, Aug 09, 2005 at 12:44:41AM -0400, Dave Jones wrote:
 > 
 > > We have a bunch of 'probe' sysctl's in parport, which are
 > > readable. (world readable even). Make them write-only.
 > > Without this, sysctl -a will try to read these files.
 > 
 > ??
 > 
 > This change is wrong.  The probing happens at module load time, and
 > the IEEE 1284 device IDs are stored for later retrieval to user space
 > via these sysctls.
 > 
 > They are backed by read-only variables.  Reading does not trigger any
 > device interaction.
 > 
 > Make them 0400 if you think it's a security issue: but then,
 > /proc/ide/hda/model etc should also get the same treatment.

It wasn't a security related change.  As I mentioned above,
sysctl -a would fail to read them anyway when I last tried
(circa 2.6.9/10)

I'll try and reproduce without that patch later today.

		Dave

