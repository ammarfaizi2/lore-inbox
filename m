Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVFCWcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVFCWcg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 18:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVFCWcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 18:32:36 -0400
Received: from rrcs-24-123-59-149.central.biz.rr.com ([24.123.59.149]:32124
	"EHLO galon.ev-en.org") by vger.kernel.org with ESMTP
	id S261151AbVFCWce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 18:32:34 -0400
Message-ID: <42A0DA78.2040804@ev-en.org>
Date: Fri, 03 Jun 2005 23:32:24 +0100
From: Baruch Even <baruch@ev-en.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.12-rc5-mm2: "bic unavailable using TCP reno" messages
References: <20050601022824.33c8206e.akpm@osdl.org>	<20050602121511.GE4992@stusta.de>	<429F1079.5070701@ev-en.org>	<20050602103805.6beb4f4e@dxpl.pdx.osdl.net>	<20050602203823.GI4992@stusta.de> <20050603143702.0422101d@dxpl.pdx.osdl.net>
In-Reply-To: <20050603143702.0422101d@dxpl.pdx.osdl.net>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> Here is what I am working on as better way to make the sysctl selection.
> I am not totally happy with the way the default congestion control value is determined
> by the load order. But it does seem good that if you load "tcp_xxx" module and it
> registers it becomes the default.

Looks good.

> @@ -120,6 +117,52 @@ static int ipv4_sysctl_forward_strategy(
>  	return 1;
>  }
>  
> +static int proc_tcp_congestion_control(ctl_table *ctl, int write, struct file * filp,
> +				       void __user *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	char val[TCP_CA_NAME_MAX];
> +	ctl_table tbl = {
> +		.data = val,
> +		.maxlen = TCP_CA_NAME_MAX,
> +	};
> +	int ret;
> +
> +	tcp_get_congestion_control(val);

Maybe we should call this tcp_get_current_congestion_control(), the
current name implies (to me) that you give it a name and it returns the
the ca struct. get_current might also just return the current one and
the strcpy can be done here.

Otherwise you probably should document the tcp_get_congestion_control()
to say what size of string it accepts.

Baruch
