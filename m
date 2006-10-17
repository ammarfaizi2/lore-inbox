Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423171AbWJQIg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423171AbWJQIg5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 04:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423169AbWJQIg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 04:36:57 -0400
Received: from poczta.o2.pl ([193.17.41.142]:28035 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1423167AbWJQIg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 04:36:56 -0400
Date: Tue, 17 Oct 2006 10:41:57 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net
Subject: Re: Linux 2.6.17.14
Message-ID: <20061017084157.GC1742@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	davem@davemloft.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061016220426.GA9194@kroah.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-10-2006 00:04, Greg KH wrote:
...
> diff --git a/net/sched/cls_basic.c b/net/sched/cls_basic.c
> index dfb300b..0f42544 100644
> --- a/net/sched/cls_basic.c
> +++ b/net/sched/cls_basic.c
> @@ -197,7 +197,7 @@ static int basic_change(struct tcf_proto
>  	if (handle)
>  		f->handle = handle;
>  	else {
> -		int i = 0x80000000;
> +		unsigned int i = 0x80000000;
>  		do {
>  			if (++head->hgenerator == 0x7FFFFFFF)
>  				head->hgenerator = 1;

		} while (--i > 0 && basic_get(tp, head->hgenerator));

		if (i <= 0) {
...

I know it should be seen earlier but maybe somebody
should make it less funny at a next chance:

		if (i == 0) {
 
Jarek P.
