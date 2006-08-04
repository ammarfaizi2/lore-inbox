Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbWHDSR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWHDSR1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 14:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWHDSR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 14:17:27 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:53964 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932385AbWHDSR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 14:17:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mNwYK8Ogg4UxUFjB7nduzGHwyGmN5EFX1DE0XQjZmWnDezubB53iEWGbjpKI5pYw3HBVnTcH+8J8GhWCVmeWCdD7+DpyeVlbme3OgGjFegjDRcI2xMylw2QX1F6MvEJEvwoGhbAJgnp0S5VuHFCVApz+xzwSdO/s9iDqmIcjGvI=
Message-ID: <5c49b0ed0608041117l68230f28w91e0d9a26313acfa@mail.gmail.com>
Date: Fri, 4 Aug 2006 11:17:25 -0700
From: "Nate Diller" <nate.diller@gmail.com>
To: "Al Boldi" <a1426z@gawab.com>
Subject: Re: [PATCH -mm] [3/3] Add the Elevator I/O scheduler
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200608041746.59729.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608041746.59729.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/06, Al Boldi <a1426z@gawab.com> wrote:
> Nate Diller wrote:
> > This is the Elevator I/O scheduler.  It is a simple one-way elevator,
>
> Thanks for yet another attempt to achieve an efficient 2.6 elevator.

hopefully it's useful for you, I'd love to see performance results one
way or the other.

>
> > +static inline char contig_char(struct el_request *e)
>
> You probably meant el_req.  Check the rest.
>
> > +static void print_queue(struct request_queue *q, struct el_data *el)
> > +{
> > +       struct el_req *e;
> > +
> > +       printel(el);
>
> Should be print_el_data.
>
> Applied against 2.6.17, it boots with this:
>         io scheduler elevator registered (default)
>         elevator: forced dispatching is broken (nr_sorted=13), please report this

damn, i thought i fixed that.

>
> > +In pure form its largest weakness is starvation of other processes due to
> > +one process writing a very large number of contiguous requests (e.g.
> > +tarring a very large tar file while other processes are trying to run).
>
> cat /dev/hda > /dev/null starves the rest of the system.

yeah, that can be worse on some systems than others, it seems to vary
a bit with file system and device driver.  some setups cause more
"breaks" in the stream of requests.

>
> > +The max_contig and max_write tunables are two (imperfect) solutions. They
> > +
> > +These two tunables are still under construction, but they have proven
> > +somewhat useful in practice.  Usually, max_contig should be the same size
> > +(in bytes) as ra_pages.
>
> It's 0 by default.  Setting it to ra_pages prints this:
>         nate 1977: max_contig went backwards

hmmm, haven't tested this recently.  dunno why that would have broken...

>
> > +
> > +  SSTF
> > +
> > +The SSTF feature was added on a whim.  It ignores the tunables, and
> > probably +breaks tracing.  I didn't ever see it perform better than SCAN,
> > but who +knows?
>
> Starves too.

oh, yeah, definitely, this algorithm is only suitable for a workload
where you want latency over fairness.  suppose i should mention that.

Thanks for your comments and testing

NATE
