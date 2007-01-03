Return-Path: <linux-kernel-owner+w=401wt.eu-S1751839AbXACBGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbXACBGk (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 20:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752708AbXACBGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 20:06:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50507 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751839AbXACBGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 20:06:40 -0500
Date: Tue, 2 Jan 2007 20:06:31 -0500
From: Dave Jones <davej@redhat.com>
To: Bodo Eggert <7eggert@gmx.de>
Cc: mingo@redhat.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Shrink the held_lock struct by using bitfields.
Message-ID: <20070103010631.GA11031@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Bodo Eggert <7eggert@gmx.de>, mingo@redhat.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <7z1oG-6Jr-5@gated-at.bofh.it> <E1H1uI5-0000mn-0j@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1H1uI5-0000mn-0j@be1.lrz>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 01:47:36AM +0100, Bodo Eggert wrote:
 > Dave Jones <davej@redhat.com> wrote:
 > 
 > > Shrink the held_lock struct by using bitfields.
 > > This shrinks task_struct on lockdep enabled kernels by 480 bytes.
 > 
 > >  * The following field is used to detect when we cross into an
 > >  * interrupt context:
 > >  */
 > > -     int                             irq_context;
 > [...]
 > > +     unsigned char irq_context:1;
 > [...]
 > 
 > Can these fields be set by concurrent processes, e.g.:
 > CPU0        CPU1
 > load flags
 >             load flags
 >             flip bit
 >             store
 > flip bit
 > store

It's a per-process structure.

		Dave

-- 
http://www.codemonkey.org.uk
