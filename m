Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965152AbWD0Qv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbWD0Qv0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 12:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbWD0Qv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 12:51:26 -0400
Received: from hera.kernel.org ([140.211.167.34]:56993 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S965152AbWD0QvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 12:51:25 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH 05/16] ehca: InfiniBand query and multicast
 functionality
Date: Thu, 27 Apr 2006 09:51:13 -0700
Organization: OSDL
Message-ID: <20060427095113.2b4d1cad@localhost.localdomain>
References: <4450A17D.4030708@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1146156671 25324 10.8.0.54 (27 Apr 2006 16:51:11 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Thu, 27 Apr 2006 16:51:11 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2006 12:48:29 +0200
Heiko J Schick <schihei@de.ibm.com> wrote:

> Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>
> 
> 
>   ehca_hca.c   |  286 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   ehca_mcast.c |  198 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 484 insertions(+)
> 
> 
> +#define TO_MAX_INT(dest, src)			\
> +	if (src >= INT_MAX)			\
> +		dest = INT_MAX;			\
> +	else					\
> +		dest = src
> +

This is doubly ugly, replace 
	TO_MAX_INT(props->max_qp, (rblock->max_qp - rblock->cur_qp);
with
	props->max_qp = min(rblock->max_qp - rblock->cur_qp, INT_MAX);

