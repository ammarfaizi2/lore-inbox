Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWCYLUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWCYLUn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 06:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbWCYLUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 06:20:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:61415 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751043AbWCYLUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 06:20:43 -0500
Date: Sat, 25 Mar 2006 11:20:42 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] loop: potential kernel hang waiting for kthread
Message-ID: <20060325112041.GA25252@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20060325014932.GA16485@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060325014932.GA16485@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2006 at 02:49:32AM +0100, Herbert Poetzl wrote:
> 
> Hi Andrew! Folks!
> 
> just stumbled over the following issue with loop_set_fd()
> calling kernel_thread(loop_thread), ignoring the return
> value, even if it is an error, then doing wait_for_completion()
> on the device, which, in beforementioned error case, would
> wait forever (keeping a process stuck in 'D' state)
> 
> I can imagine at least three other solutions, but this
> one seemed quite organic to me, YMMV ...

Best thing would be to switch it to the kthread_ API.

