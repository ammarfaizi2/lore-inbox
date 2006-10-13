Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751560AbWJMCgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbWJMCgx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 22:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbWJMCgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 22:36:53 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:15708 "EHLO
	asav10.insightbb.com") by vger.kernel.org with ESMTP
	id S1751495AbWJMCgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 22:36:52 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAPCXLkWBSopPLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Jiri Kosina <jikos@jikos.cz>
Subject: Re: [PATCH] fix fm801_gp_probe() ignoring return value from pci_enable_device()
Date: Thu, 12 Oct 2006 22:36:47 -0400
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz
References: <Pine.LNX.4.64.0610130123270.29022@twin.jikos.cz>
In-Reply-To: <Pine.LNX.4.64.0610130123270.29022@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610122236.49321.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 October 2006 19:27, Jiri Kosina wrote:
> [PATCH] fix fm801_gp_probe() ignoring return value from pci_enable_device()
> 
> Fix fm801_gp_probe() not handling pci_enable_device() return value 
> correctly.
> 
> Signed-off-by: Jiri Kosina <jikos@jikos.cz>
> 
> --- 
> 
>  drivers/input/gameport/fm801-gp.c |   23 ++++++++++++++++-------
>  1 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/gameport/fm801-gp.c b/drivers/input/gameport/fm801-gp.c
> index 90de5af..5ac9e15 100644
> --- a/drivers/input/gameport/fm801-gp.c
> +++ b/drivers/input/gameport/fm801-gp.c
> @@ -82,17 +82,22 @@ static int __devinit fm801_gp_probe(stru
>  {
>  	struct fm801_gp *gp;
>  	struct gameport *port;
> +	int err;
>  
>  	gp = kzalloc(sizeof(struct fm801_gp), GFP_KERNEL);
>  	port = gameport_allocate_port();
>  	if (!gp || !port) {
>  		printk(KERN_ERR "fm801-gp: Memory allocation failed\n");
> -		kfree(gp);
> -		gameport_free_port(port);
> -		return -ENOMEM;
> +		err = -ENOMEM;
> +		goto out_err;
>  	}
>  

Hi Jiri,

It looks like you left pci device enabled. Anyway, Jeff Garzik beat you
to it ;) I spplied his patch to my tree yesterday.

-- 
Dmitry
