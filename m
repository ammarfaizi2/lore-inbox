Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264305AbUGHVeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbUGHVeX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 17:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264276AbUGHVeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 17:34:23 -0400
Received: from [213.146.154.40] ([213.146.154.40]:57761 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264305AbUGHVeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 17:34:20 -0400
Date: Thu, 8 Jul 2004 22:34:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: linux-kernel@vger.kernel.org, breed@users.sourceforge.net,
       fabrice@bellet.info
Subject: Re: [PATCH] fix airo oops-on-removal
Message-ID: <20040708213420.GA19036@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org, breed@users.sourceforge.net,
	fabrice@bellet.info
References: <20040708213151.GE13918@nostromo.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708213151.GE13918@nostromo.devel.redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 05:31:51PM -0400, Bill Nottingham wrote:
> airo creates /proc/driver/aironet/<device name> on device activation.
> However, the device can be renamed - then on teardown
> it tries to remove the wrong directory. The removal of 
> /proc/driver/aironet then runs afoul of the BUG_ON() in remove_proc_entry.
> 
> This fixes it by keeping a copy of the name of the directory
> it created.
> 
> (It doesn't actually solve the problem of the stats directory
> still being /proc/driver/aironet/eth0 when you rename the device
> to, say, 'joe'. But that patch would be a little less trivial.)

Still sounds like a rather broken behaviour.  We should probably
nuke that whole procfs interface thingy instead.

