Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751545AbWEZVMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbWEZVMq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 17:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWEZVMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 17:12:46 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:38310 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S1751543AbWEZVMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 17:12:45 -0400
Date: Fri, 26 May 2006 23:12:19 +0200
From: Frank Gevaerts <frank.gevaerts@fks.be>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Frank Gevaerts <frank.gevaerts@fks.be>, linux-kernel@vger.kernel.org,
       gregkh@suse.de, linux-usb-devel@lists.sourceforge.net
Subject: Re: usb-serial ipaq kernel problem
Message-ID: <20060526211219.GD13424@fks.be>
References: <20060526182217.GA12687@fks.be> <20060526133410.9cfff805.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060526133410.9cfff805.zaitcev@redhat.com>
User-Agent: Mutt/1.5.9i
X-FKS-MailScanner: Found to be clean
X-FKS-MailScanner-SpamCheck: geen spam, SpamAssassin (score=-105.813,
	vereist 5, autolearn=not spam, ALL_TRUSTED -3.30, AWL 0.09,
	BAYES_00 -2.60, USER_IN_WHITELIST -100.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 01:34:10PM -0700, Pete Zaitcev wrote:
> On Fri, 26 May 2006 20:22:17 +0200, Frank Gevaerts <frank.gevaerts@fks.be> wrote:
> 
> > usb 1-4.5.7: USB disconnect, address 79
> > ------------[ cut here ]------------
> > kernel BUG at kernel/workqueue.c:110!
> 
> Please let me know if this helps:

Thanks. It's now running with this applied. I'll let you know if it's
still running in a few days (I got the last one after running +- 2 days)

Frank

> 
> --- linux-2.6.17-rc2/drivers/usb/serial/usb-serial.c	2006-04-23 21:06:18.000000000 -0700
> +++ linux-2.6.17-rc2-lem/drivers/usb/serial/usb-serial.c	2006-05-22 21:23:29.000000000 -0700
> @@ -162,6 +162,8 @@ static void destroy_serial(struct kref *
>  		}
>  	}
>  
> +	flush_scheduled_work();		/* port->work */
> +
>  	usb_put_dev(serial->dev);
>  
>  	/* free up any memory that we allocated */
> 
> -- Pete

-- 
Frank Gevaerts                                 frank.gevaerts@fks.be
fks bvba - Formal and Knowledge Systems        http://www.fks.be/
Stationsstraat 108                             Tel:  ++32-(0)11-21 49 11
B-3570 ALKEN                                   Fax:  ++32-(0)11-22 04 19
