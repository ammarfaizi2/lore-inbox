Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbWEZUfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWEZUfn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 16:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWEZUfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 16:35:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16256 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751496AbWEZUfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 16:35:42 -0400
Date: Fri, 26 May 2006 13:34:10 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Frank Gevaerts <frank.gevaerts@fks.be>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net, zaitcev@redhat.com
Subject: Re: usb-serial ipaq kernel problem
Message-Id: <20060526133410.9cfff805.zaitcev@redhat.com>
In-Reply-To: <20060526182217.GA12687@fks.be>
References: <20060526182217.GA12687@fks.be>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2006 20:22:17 +0200, Frank Gevaerts <frank.gevaerts@fks.be> wrote:

> usb 1-4.5.7: USB disconnect, address 79
> ------------[ cut here ]------------
> kernel BUG at kernel/workqueue.c:110!

Please let me know if this helps:

--- linux-2.6.17-rc2/drivers/usb/serial/usb-serial.c	2006-04-23 21:06:18.000000000 -0700
+++ linux-2.6.17-rc2-lem/drivers/usb/serial/usb-serial.c	2006-05-22 21:23:29.000000000 -0700
@@ -162,6 +162,8 @@ static void destroy_serial(struct kref *
 		}
 	}
 
+	flush_scheduled_work();		/* port->work */
+
 	usb_put_dev(serial->dev);
 
 	/* free up any memory that we allocated */

-- Pete
