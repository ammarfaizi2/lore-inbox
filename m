Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965139AbVIAOTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965139AbVIAOTs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbVIAOTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:19:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33004 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965139AbVIAOTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:19:46 -0400
Subject: Re: [PATCH 01/14] GFS: headers
From: Arjan van de Ven <arjan@infradead.org>
To: David Teigland <teigland@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050901135442.GA25581@redhat.com>
References: <20050901135442.GA25581@redhat.com>
Content-Type: text/plain
Date: Thu, 01 Sep 2005 16:19:34 +0200
Message-Id: <1125584374.5025.18.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +#ifndef TRUE
> +#define TRUE 1
> +#endif
> +
> +#ifndef FALSE
> +#define FALSE 0
> +#endif

eh why can't you just use the regular kernel conventions


> +
> +#define NO_CREATE 0
> +#define CREATE 1
> +
> +#define NO_WAIT 0
> +#define WAIT 1
> +
> +#define NO_FORCE 0
> +#define FORCE 1

these deserve enums


> +
> +/* Actions */
> +#define HIF_MUTEX		0
> +#define HIF_PROMOTE		1
> +#define HIF_DEMOTE		2
> +#define HIF_GREEDY		3
> +
> +/* States */
> +#define HIF_ALLOCED		4
> +#define HIF_DEALLOC		5
> +#define HIF_HOLDER		6
> +#define HIF_FIRST		7
> +#define HIF_RECURSE		8
> +#define HIF_ABORTED		9

enum?


> +#define _GFS2C_(x)               (('G' << 16) | ('2' << 8) | (x))
> +
> +/* Ioctls implemented */
> +
> +#define GFS2_IOCTL_IDENTIFY      _GFS2C_(1)
> +#define GFS2_IOCTL_SUPER         _GFS2C_(2)

have you registered these in ioctl.txt?


> +
> +struct gfs2_ioctl {
> +	unsigned int gi_argc;
> +	char **gi_argv;
> +
> +        char __user *gi_data;
> +	unsigned int gi_size;
> +	uint64_t gi_offset;
> +};

what is this for??

> +/* Endian functions */

ehhhh again why?? 
Why is this a compiletime hack?
Either you care about either-endian on disk, at which point it has to be
a runtime thing, or you make the on disk layout fixed endian, at which
point you really shouldn't abstract be16_to_cpu etc any further!




