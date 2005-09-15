Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932592AbVIOR6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbVIOR6X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 13:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbVIOR6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 13:58:23 -0400
Received: from kanga.kvack.org ([66.96.29.28]:38560 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932592AbVIOR6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 13:58:22 -0400
Date: Thu, 15 Sep 2005 13:57:25 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: davem@davemloft.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [NETFILTER]: Use correct type for "ports" module parameter
Message-ID: <20050915175725.GD8677@kvack.org>
References: <200509140100.j8E10NLw009915@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509140100.j8E10NLw009915@hera.kernel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 06:00:23PM -0700, Linux Kernel Mailing List wrote:
> --- a/net/ipv4/netfilter/ip_conntrack_ftp.c
> +++ b/net/ipv4/netfilter/ip_conntrack_ftp.c
> @@ -29,9 +29,9 @@ static char *ftp_buffer;
>  static DEFINE_SPINLOCK(ip_ftp_lock);
>  
>  #define MAX_PORTS 8
> -static int ports[MAX_PORTS];
> +static short ports[MAX_PORTS];
>  static int ports_c;
> -module_param_array(ports, int, &ports_c, 0400);
> +module_param_array(ports, short, &ports_c, 0400);

Shouldn't this be unsigned short?  As near as I can tell the negative sign 
extension will result in the same problem this patch was trying to fix as 
the code does 'sprintf(tmpname, "ftp-%d", ports[i]);'...

		-ben

