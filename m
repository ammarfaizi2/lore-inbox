Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263188AbUD2GUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263188AbUD2GUI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 02:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbUD2GUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 02:20:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:2263 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263188AbUD2GUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 02:20:05 -0400
Date: Thu, 29 Apr 2004 08:19:58 +0200
From: Jens Axboe <axboe@suse.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Kenneth Johansson <ken@kenjo.org>,
       Moritz Muehlenhoff <jmm@informatik.uni-bremen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] DVD writing in 2.6.6-rc2
Message-ID: <20040429061956.GA3558@suse.de>
References: <1083088772.2679.11.camel@tiger> <20040427183607.GA3011@suse.de> <8n23m1-g22.ln1@legolas.mmuehlenhoff.de> <20040428113056.GA2150@suse.de> <1083176956.2679.19.camel@tiger> <20040428200953.GA3470@suse.de> <20040428221334.GA22404@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040428221334.GA22404@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28 2004, Chris Wedgwood wrote:
> On Wed, Apr 28, 2004 at 10:09:54PM +0200, Jens Axboe wrote:
> 
> > So it just helped me unearth a different problem :-). There
> > certainly is a bug here, it looks like it's hardware though (see the
> > above description). ide-cd just needs to have it's SYNC_CACHE
> > retries limited, then the kernel should at least recover.
> 
> I see cache flushes also go mute and hang forwever.  I think ideally
> we need to hack the IDE layer to have sane timeouts or something
> perhaps?

Yeah, with 'retries' I mean waiting retries. The command does expire and
ide-cd notices it just doesn't put an upper bound on how long it waits.
A minute or so should suffice, unless the caller specifies otherwise.

-- 
Jens Axboe

