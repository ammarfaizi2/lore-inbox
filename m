Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263584AbUD2Gak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbUD2Gak (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 02:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263594AbUD2Gah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 02:30:37 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:25561 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263584AbUD2G3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 02:29:54 -0400
Date: Thu, 29 Apr 2004 08:29:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Kenneth Johansson <ken@kenjo.org>,
       Moritz Muehlenhoff <jmm@informatik.uni-bremen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] DVD writing in 2.6.6-rc2
Message-ID: <20040429062949.GB3558@suse.de>
References: <1083088772.2679.11.camel@tiger> <20040427183607.GA3011@suse.de> <8n23m1-g22.ln1@legolas.mmuehlenhoff.de> <20040428113056.GA2150@suse.de> <1083176956.2679.19.camel@tiger> <20040428200953.GA3470@suse.de> <20040428221334.GA22404@taniwha.stupidest.org> <20040429061956.GA3558@suse.de> <20040429062436.GA6507@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429062436.GA6507@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28 2004, Chris Wedgwood wrote:
> On Thu, Apr 29, 2004 at 08:19:58AM +0200, Jens Axboe wrote:
> 
> > Yeah, with 'retries' I mean waiting retries. The command does expire
> > and ide-cd notices it just doesn't put an upper bound on how long it
> > waits.  A minute or so should suffice, unless the caller specifies
> > otherwise.
> 
> Can we poke the IDE drive is it's hung or reset it in these cases?  I
> wonder more in the general case where I've had to reboot because the
> burner went nuts for some reason...

Drive needs to be reset. Something like this should be all that's
needed.

===== drivers/ide/ide-cd.c 1.81 vs edited =====
--- 1.81/drivers/ide/ide-cd.c	Mon Apr 26 22:56:10 2004
+++ edited/drivers/ide/ide-cd.c	Thu Apr 29 08:29:07 2004
@@ -844,7 +844,6 @@
 		case GPCMD_FORMAT_UNIT:
 		case GPCMD_RESERVE_RZONE_TRACK:
 		case GPCMD_CLOSE_TRACK:
-		case GPCMD_FLUSH_CACHE:
 			wait = ATAPI_WAIT_PC;
 			break;
 		default:

-- 
Jens Axboe

