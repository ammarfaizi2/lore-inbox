Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVAXVD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVAXVD0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 16:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVAXVCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:02:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56213 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261665AbVAXU6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:58:49 -0500
Subject: Re: [Ext2-devel] [PATCH] JBD: log space management optimization
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alex Tomas <alex@clusterfs.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <m3fz0qd1cf.fsf@bzzz.home.net>
References: <m3llapv3i7.fsf@bzzz.home.net>
	 <1106593003.2103.147.camel@sisko.sctweedie.blueyonder.co.uk>
	 <m3fz0qd1cf.fsf@bzzz.home.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106600313.2103.261.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 24 Jan 2005 20:58:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-01-24 at 20:22, Alex Tomas wrote:

> during truncate ext3 calls journal_forget() for freed blocks, but
> before these blocks go to the transaction and jbd reserves space
> in log for them (->t_outstanding_credits). also, journal_forget()
> removes these blocks from the transaction, but doesn't correct
> log space reservation. for example, removal of 500MB file reserves
> 136 blocks, but only 10 blocks go to the log. a commit is expensive
> and correct reservation allows us to avoid needless commits. here
> is the patch. tested on UP.

> +drop:
> +	if (drop_reserve) {
> +		/* no need to reserve log space for this block -bzzz */
> +		handle->h_buffer_credits++;
> +	}
> +

Looks good to me.

--Stephen

