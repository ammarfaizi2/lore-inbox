Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbVJQDlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbVJQDlo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 23:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbVJQDlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 23:41:44 -0400
Received: from xenotime.net ([66.160.160.81]:41106 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932105AbVJQDln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 23:41:43 -0400
Date: Sun, 16 Oct 2005 20:41:41 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] indirect function calls elimination in IO scheduler
Message-Id: <20051016204141.1d13b720.rdunlap@xenotime.net>
In-Reply-To: <6694B22B6436BC43B429958787E454988F53C2@mssmsx402nb>
References: <6694B22B6436BC43B429958787E454988F53C2@mssmsx402nb>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2005 02:28:09 +0400 Ananiev, Leonid I wrote:

> > Put <...> around the email address.
> Fixed
> > Ugh.  Does exchange (server) add all of those extra lines?
> I do not see extra lines in my "sent box". Next is one more exempt. The
> text is plain.

It's a lot better, but there are still some lines that were broken
in the outbound mail body that should not have been broken (split).
See below.

You should send email to yourself (going out of intel.com and back
into it) and then be able to apply the patch cleanly.

First error is:
patch: **** malformed patch at line 39: *rq)

So I join lines 38 & 39 and try again:
patch: **** malformed patch at line 66: *rq)

Repeat...
patch: **** malformed patch at line 162: *rq)

and:
patch: **** malformed patch at line 234: *cfqq)


> @@ -945,7 +945,7 @@ static void update_write_batch(struct as
>   */
>  static void as_completed_request(request_queue_t *q, struct request
> *rq)     <<<<<<<<<<< this should not be a separate line <<<<<<<<<<
>  {
> -	struct as_data *ad = q->elevator->elevator_data;
> +	struct as_data *ad = q->elevator.elevator_data;
>  	struct as_rq *arq = RQ_DATA(rq);
>  
>  	WARN_ON(!list_empty(&rq->queuelist));
> @@ -1465,7 +1465,7 @@ static void as_add_request(struct as_dat
>  
>  static void as_deactivate_request(request_queue_t *q, struct request
> *rq)     <<<<<<<<<<<<<<< Should not be a separate line. <<<<<<<<<<<
>  {
> -	struct as_data *ad = q->elevator->elevator_data;
> +	struct as_data *ad = q->elevator.elevator_data;
>  	struct as_rq *arq = RQ_DATA(rq);
>  
>  	if (arq) {

> diff -rup linux-2.6.14-rc2/drivers/block/cfq-iosched.c
> linux-2.6.14-rc2elv1/drivers/block/cfq-iosched.c
> --- linux-2.6.14-rc2/drivers/block/cfq-iosched.c	2005-09-24
> 09:13:54.000000000 +0400
> +++ linux-2.6.14-rc2elv1/drivers/block/cfq-iosched.c	2005-10-13
> 04:18:12.000000000 +0400
> @@ -678,7 +678,7 @@ out:
>  
>  static void cfq_deactivate_request(request_queue_t *q, struct request
> *rq)       <<<<<<<<<<<<<<<<<< Same <<<<<<<<<<<<<<<<<<
>  {

There are (lots) more, but I'm not pointing to every one of them.

After joining about 20 lines, I did get it to apply successfully
(to 2.6.14-rc4).  You should also make sure that it applies cleanly
to the current kernel version.

Sometimes it works to send email as text/plain attachments.
Are you using a decent email client?   :)

---
~Randy
