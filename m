Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966100AbWKJJSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966100AbWKJJSC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966099AbWKJJSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:18:01 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:17560 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S966098AbWKJJR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:17:59 -0500
Message-ID: <455442B6.30800@openvz.org>
Date: Fri, 10 Nov 2006 12:13:26 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Balbir Singh <balbir@in.ibm.com>
CC: Linux MM <linux-mm@kvack.org>, dev@openvz.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       rohitseth@google.com
Subject: Re: [RFC][PATCH 7/8] RSS controller fix resource groups parsing
References: <20061109193523.21437.86224.sendpatchset@balbir.in.ibm.com> <20061109193627.21437.88058.sendpatchset@balbir.in.ibm.com>
In-Reply-To: <20061109193627.21437.88058.sendpatchset@balbir.in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> echo adds a "\n" to the end of a string. When this string is copied from
> user space, we need to remove it, so that match_token() can parse
> the user space string correctly
> 
> Signed-off-by: Balbir Singh <balbir@in.ibm.com>
> ---
> 
>  kernel/res_group/rgcs.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff -puN kernel/res_group/rgcs.c~container-res-groups-fix-parsing kernel/res_group/rgcs.c
> --- linux-2.6.19-rc2/kernel/res_group/rgcs.c~container-res-groups-fix-parsing	2006-11-09 23:08:10.000000000 +0530
> +++ linux-2.6.19-rc2-balbir/kernel/res_group/rgcs.c	2006-11-09 23:08:10.000000000 +0530
> @@ -241,6 +241,12 @@ ssize_t res_group_file_write(struct cont
>  	}
>  	buf[nbytes] = 0;	/* nul-terminate */
>  
> +	/*
> +	 * Ignore "\n". It might come in from echo(1)

Why not inform user he should call echo -n?

> +	 */
> +	if (buf[nbytes - 1] == '\n')
> +		buf[nbytes - 1] = 0;
> +
>  	container_manage_lock();
>  
>  	if (container_is_removed(cont)) {
> _
> 

That's the same patch as in [PATCH 1/8] mail. Did you attached
a wrong one?
