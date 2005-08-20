Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbVHTHLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbVHTHLO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 03:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbVHTHLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 03:11:14 -0400
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:17811 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932092AbVHTHLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 03:11:13 -0400
Date: Sat, 20 Aug 2005 03:07:43 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.13-rc6] i386: semaphore ownership tracking
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@elte.hu, ak@suse.de, torvalds@osdl.org, linux-kernel@vger.kernel.org
Message-ID: <200508200310_MC3-1-A7BC-D1C0@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2005 at 20:02:27 -0700, Andrew Morton wrote:

> Chuck Ebbert <76306.1226@compuserve.com> wrote:
> >
> >  This patch enables tracking semaphore ownership.
> 
> Why?  I can't think of any bug in recent years which needed this..

 It might be useful in new driver development.  OTOH it is really ugly
even if it's a small patch.

 I did get an education from it, though.  The usb-storage threads on my
system were sleeping on semaphores they already owned, making me wonder if
my patch really worked.  It turns out that code in scsiglue.c does an up()
to wake them without ever acquiring the semaphore.

__
Chuck
