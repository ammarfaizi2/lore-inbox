Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWHYOjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWHYOjJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWHYOjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:39:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39358 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751051AbWHYOjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:39:06 -0400
Date: Fri, 25 Aug 2006 15:38:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, schwidefsky@de.ibm.com
Subject: Re: [PATCH 1/3] kthread: update s390 cmm driver to use kthread
Message-ID: <20060825143842.GA27364@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Serge E. Hallyn" <serue@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>, schwidefsky@de.ibm.com
References: <20060824212241.GB30007@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824212241.GB30007@sergelap.austin.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 04:22:42PM -0500, Serge E. Hallyn wrote:
> Update the s390 cooperative memory manager, which can be a module,
> to use kthread rather than kernel_thread, whose EXPORT is deprecated.
> 
> This patch compiles and boots fine, but I don't know how to really
> test the driver.

NACK.  Please do a real conversion to the kthread paradigm instead of
doctoring around the trivial bits that could be changed with a script.

Please use kthread_should_stop() and remove the cmm_thread_wait
waitqueue in favour of wake_up_process.  The timer useage could
probably be replaced with smart usage of schedule_timeout().
Also the code seems to miss a proper thread termination on module
removal.

