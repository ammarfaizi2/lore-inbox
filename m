Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbTJFO4G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 10:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbTJFO4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 10:56:06 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:48657 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262195AbTJFO4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 10:56:03 -0400
Date: Mon, 6 Oct 2003 15:55:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] s390 (2/7): common i/o layer.
Message-ID: <20031006155559.A21462@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <OF79F7FC5D.894CD912-ONC1256DB7.0051545B-C1256DB7.00516DD4@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF79F7FC5D.894CD912-ONC1256DB7.0051545B-C1256DB7.00516DD4@de.ibm.com>; from schwidefsky@de.ibm.com on Mon, Oct 06, 2003 at 04:49:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 04:49:25PM +0200, Martin Schwidefsky wrote:
> > > Just checked. You right about chp_release which should do
> > > a kfree on the struct channel_path object. But the two
> > > other release functions are really dummy functions because
> > > cu3088_root_dev and iucv_root are static structures.
> >
> > Even in that case you're screwed in case they are in modules..
> 
> Why? The root device are registered in the module init function
> and unregistered in the module exit function. I fail to see the
> problem.

You can still have a reference to the object when the module is unloaded.

unregistered != last reference is gone
