Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161231AbWHDOpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161231AbWHDOpT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 10:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161237AbWHDOpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 10:45:19 -0400
Received: from [212.76.86.19] ([212.76.86.19]:50180 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1161231AbWHDOpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 10:45:17 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] [3/3] Add the Elevator I/O scheduler
Date: Fri, 4 Aug 2006 17:46:59 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200608041746.59729.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nate Diller wrote:
> This is the Elevator I/O scheduler.  It is a simple one-way elevator,

Thanks for yet another attempt to achieve an efficient 2.6 elevator.

> +static inline char contig_char(struct el_request *e)

You probably meant el_req.  Check the rest.

> +static void print_queue(struct request_queue *q, struct el_data *el)
> +{
> +       struct el_req *e;
> +
> +       printel(el);

Should be print_el_data.

Applied against 2.6.17, it boots with this:
	io scheduler elevator registered (default)
	elevator: forced dispatching is broken (nr_sorted=13), please report this

> +In pure form its largest weakness is starvation of other processes due to
> +one process writing a very large number of contiguous requests (e.g.
> +tarring a very large tar file while other processes are trying to run).

cat /dev/hda > /dev/null starves the rest of the system.

> +The max_contig and max_write tunables are two (imperfect) solutions. They
> +
> +These two tunables are still under construction, but they have proven
> +somewhat useful in practice.  Usually, max_contig should be the same size
> +(in bytes) as ra_pages.

It's 0 by default.  Setting it to ra_pages prints this:
	nate 1977: max_contig went backwards

> +
> +  SSTF
> +
> +The SSTF feature was added on a whim.  It ignores the tunables, and
> probably +breaks tracing.  I didn't ever see it perform better than SCAN,
> but who +knows?

Starves too.


Thanks!

--
Al

