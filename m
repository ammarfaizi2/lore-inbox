Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264119AbUFPQHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264119AbUFPQHa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 12:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264117AbUFPQHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 12:07:30 -0400
Received: from [213.146.154.40] ([213.146.154.40]:55963 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264113AbUFPQHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 12:07:20 -0400
Date: Wed, 16 Jun 2004 17:07:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dimitri Sivanich <sivanich@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Option to run cache reap in thread mode
Message-ID: <20040616160714.GA14413@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dimitri Sivanich <sivanich@sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20040616142413.GA5588@sgi.com> <20040616152934.GA13527@infradead.org> <20040616160355.GA5963@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616160355.GA5963@sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 11:03:55AM -0500, Dimitri Sivanich wrote:
> On Wed, Jun 16, 2004 at 04:29:34PM +0100, Christoph Hellwig wrote:
> > YAKT, sigh..  I don't quite understand what you mean with a "holdoff" so
> > maybe you could explain what problem you see?  You don't like cache_reap
> > beeing called from timer context?
> 
> The issue(s) I'm attempting to solve is to achieve more deterministic interrupt
> response times on CPU's that have been designated for use as such.  By setting
> cache_reap to run as a kthread, the cpu is only unavailable during the time
> that irq's are disabled.  By doing this on a cpu that's been restricted from
> running most other processes, I have been able to achieve much more
> deterministic interrupt response times.
> 
> So yes, I don't want cache_reap to be called from timer context when I've
> configured a CPU as such.

Well, if you want deterministic interrupt latencies you should go for a realtime OS.
I know Linux is the big thing in the industry, but you're really better off looking
for a small Hard RT OS.  From the OpenSource world eCOS or RTEMS come to mind.  Or even
rtlinux/rtai if you want to run a full linux kernel as idle task.

