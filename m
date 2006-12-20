Return-Path: <linux-kernel-owner+w=401wt.eu-S1030371AbWLTVxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbWLTVxA (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 16:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030372AbWLTVw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 16:52:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46424 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030371AbWLTVw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 16:52:58 -0500
Date: Wed, 20 Dec 2006 16:52:46 -0500 (EST)
Message-Id: <20061220.165246.85417944.k-ueda@ct.jp.nec.com>
To: jens.axboe@oracle.com
Cc: agk@redhat.com, mchristi@redhat.com, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, j-nomura@ce.jp.nec.com, k-ueda@ct.jp.nec.com
Subject: Re: [RFC PATCH 2/8] rqbased-dm: add block layer hook
From: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
In-Reply-To: <20061220134924.GG10535@kernel.dk>
References: <20061219.171150.75425661.k-ueda@ct.jp.nec.com>
	<20061220134924.GG10535@kernel.dk>
X-Mailer: Mew version 2.3 on Emacs 20.7 / Mule 4.1
 =?iso-2022-jp?B?KBskQjAqGyhCKQ==?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

Sorry for the less explanation.

On Wed, 20 Dec 2006 14:49:24 +0100, Jens Axboe <jens.axboe@oracle.com> wrote:
> On Tue, Dec 19 2006, Kiyoshi Ueda wrote:
> > This patch adds new "end_io_first" hook in __end_that_request_first()
> > for request-based device-mapper.
> 
> What's this for, lack of stacking?

I don't understand the meaning of "lack of stacking" well but
I guess that it means "Is the existing hook in end_that_request_last()
not enough?"  If so, the answer is no.
(If the geuss is wrong, please let me know.)

The new hook is needed for error handling in dm.
For example, when an error occurred on a request, dm-multipath
wants to try another path before returning EIO to application.
Without the new hook, at the point of end_that_request_last(),
the bios are already finished with error and can't be retried.

Thanks,
Kiyoshi Ueda

