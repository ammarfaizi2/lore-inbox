Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWAVOYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWAVOYH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 09:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWAVOYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 09:24:06 -0500
Received: from mx.freeshell.ORG ([192.94.73.21]:16086 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S1751258AbWAVOYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 09:24:05 -0500
From: Jim Nance <jlnance@sdf.lonestar.org>
Date: Sun, 22 Jan 2006 14:24:01 +0000
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: sendfile() with 100 simultaneous 100MB files
Message-ID: <20060122142401.GA24738@SDF.LONESTAR.ORG>
References: <9e4733910601201353g36284133xf68c4f6eae1344b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910601201353g36284133xf68c4f6eae1344b4@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 04:53:44PM -0500, Jon Smirl wrote:

> Any other ideas why sendfile() would get into a seek storm?

I can't really comment on the quality of the linux sendfile() implementation,
I've never looked at the code.  However, a couple of general observations.

The seek storm happens because linux is trying to be "fair," where fair
means no one process get to starve another for I/O bandwidth.

The fastest way to transfer 100 100M files would be to send them one at a
time.  The 99th person in line of course would percieve this as a very poor
implementation.  The current sendfile implementation seems to live at the
other end of the extream.

It is possible to come up with a compromise behavior by limiting the
number of concurrent sendfiles running, and the maximum size they are
allowed to send in one squirt.

Thanks,

Jim

-- 
jlnance@sdf.lonestar.org
SDF Public Access UNIX System - http://sdf.lonestar.org
