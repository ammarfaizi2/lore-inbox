Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbUJYViU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbUJYViU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 17:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbUJYPTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:19:13 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:60684 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261963AbUJYPSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:18:43 -0400
Date: Mon, 25 Oct 2004 16:18:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mike Waychison <michael.waychison@sun.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       raven@themaw.net
Subject: Re: [PATCH 20/28] HOTPLUG: call_usermodehelper callback support
Message-ID: <20041025151842.GA1858@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mike Waychison <michael.waychison@sun.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	raven@themaw.net
References: <10987156903663@sun.com> <10987157204162@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10987157204162@sun.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 10:48:40AM -0400, Mike Waychison wrote:
> This patch extends the call_usermodehelper api by adding a callback variant.
> The callback is made right when the system is about to call execve into the
> new process.  This allows for the caller to provide changes to the default
> environment right before the exec takes place.  Note: the context of the
> callback will be _from within another process_.

I don't like this at all.  First it's the usual fork() + exec() vs spawn() with
gazillions of arguments debatte, second this sounds far too complex to do it in
kernelspace to me.  Why can't you do the enviroment changes from the program
beeing executed?

