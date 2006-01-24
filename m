Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbWAXGRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWAXGRs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 01:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWAXGRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 01:17:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25811 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932435AbWAXGRr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 01:17:47 -0500
Date: Tue, 24 Jan 2006 01:17:21 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>, laredo@gnu.org
Cc: xslaby@fi.muni.cz
Subject: Re: stradis oopses on modprobe.
Message-ID: <20060124061721.GA6861@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, laredo@gnu.org,
	xslaby@fi.muni.cz
References: <20060124060103.GA3532@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124060103.GA3532@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 01:01:03AM -0500, Dave Jones wrote:

 > The backtrace is a bit of a mess, but what seems to happen is that we're oopsing
 > on the saawrite(0xffff0000, SAA7146_MC1)  in init_saa7146
 > saawrite does a   writel((dat), saa->saa7146_mem+(adr)), and as we've already
 > dereferenced 'saa' a few lines above, the oops is due to saa7146_mem being NULL
 > however that should be set up by configure_saa7146, which gets called in stradis_probe()
 > prior to calling init_saa7146.
 > 
 > *puzzled*.

This came from Jiri's PCI probing cleanups in 9ae82293ff3a3057d939b4f56d57eeea2f91bbec

There's a memset in init_saa7146 now, which wipes out the whole struct,
so we lose track of saa7146_mem

Jiri ?

		Dave

