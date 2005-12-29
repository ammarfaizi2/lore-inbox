Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbVL2Isw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbVL2Isw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 03:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbVL2Isw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 03:48:52 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:11378 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965061AbVL2Isv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 03:48:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aDF1A1zJaMmqutCdmlpgO8jMyXrBtaniLPsjMtGNTwAIS21omz2SmV+GriIfNb+6CCVR+sKuBpZI2qLb5ByQvDm8T9+qh0CuN1PkdxG+Sfh0+Wl4ra8KyzRM/Zv7xlGkWljdOUwPlCJ/gCsYMYPn1X8Y2JfhLr+NMTNkdvx2fd8=
Message-ID: <84144f020512290048g4d2a6a49hf6a41a2c0651c9ba@mail.gmail.com>
Date: Thu, 29 Dec 2005 10:48:50 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] ipw2200 stack reduction
Cc: yi.zhu@intel.com, jketreno@linux.intel.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051228212934.GA2772@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051228212934.GA2772@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On 12/28/05, Jens Axboe <axboe@suse.de> wrote:
> -static int ipw_send_host_complete(struct ipw_priv *priv)
> +static struct host_cmd *ipw_host_cmd_get(u8 command, u8 len)
>  {
> -       struct host_cmd cmd = {
> -               .cmd = IPW_CMD_HOST_COMPLETE,
> -               .len = 0
> -       };
> +       struct host_cmd *cmd;
> +
> +       cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
> +       if (cmd) {
> +               cmd->cmd = command;
> +               cmd->len = len;
> +               return cmd;
> +       }
> +
> +       return NULL;

A minor nitpick: you can always return cmd here.

                               Pekka
