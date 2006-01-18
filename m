Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030459AbWARXid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbWARXid (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 18:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030460AbWARXid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 18:38:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42217 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030459AbWARXic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 18:38:32 -0500
Date: Wed, 18 Jan 2006 18:37:39 -0500
From: Dave Jones <davej@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Reuben Farrelly <reuben-lkml@reub.net>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       arjan@infradead.org
Subject: Re: 2.6.16-rc1-mm1
Message-ID: <20060118233739.GH5278@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
	Reuben Farrelly <reuben-lkml@reub.net>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	arjan@infradead.org
References: <20060118005053.118f1abc.akpm@osdl.org> <43CE2210.60509@reub.net> <20060118032716.7f0d9b6a.akpm@osdl.org> <20060118190926.GB316@redhat.com> <1137626021.1760.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137626021.1760.18.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 11:13:41PM +0000, Alan Cox wrote:
 > On Mer, 2006-01-18 at 14:09 -0500, Dave Jones wrote:
 > > On Wed, Jan 18, 2006 at 03:27:16AM -0800, Andrew Morton wrote:
 > > 
 > >  > Well yes, that code is kfree()ing a locked mutex.  It's somewhat weird to
 > >  > take a lock on a still-private object but whatever.  The code's legal
 > >  > enough.
 > >  > 
 > 
 > If someone else can be waiting on it then it doesn't look legal ?

it's allocated in this function, and we only kfree it in an error path
if something goes wrong.  If we get to the kfree, the policy has
never been seen anywhere outside of cpufreq_add_dev(), so nothing
else can be waiting on it.

		Dave

