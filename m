Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbTEBOSY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 10:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbTEBOSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 10:18:24 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:40196 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262912AbTEBOST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 10:18:19 -0400
Subject: Re: Aic7xxx and Aic79xx Driver Updates
From: James Bottomley <James.Bottomley@steeleye.com>
To: "Justin T. Gibbs" <gibbs@btc.adaptec.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <1866260000.1051828092@aslan.btc.adaptec.com>
References: <1866260000.1051828092@aslan.btc.adaptec.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 02 May 2003 09:30:35 -0500
Message-Id: <1051885837.1820.34.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First off, could you take a look at

http://bugzilla.kernel.org/show_bug.cgi?id=608

I thought it was an sr problem, but it doesn't seem to show up on
anything other than adaptec controllers?  Thanks.

On Thu, 2003-05-01 at 17:28, Justin T. Gibbs wrote:
> ChangeSet
>   1.1118.33.5 03/04/24 15:12:48 gibbs@overdrive.btc.adaptec.com +7 -0
>   Aic7xxx and Aic79xx Driver Updates
>    o Adapt to new IRQ handler declaration/behavior for 2.5.X

The changes for this:

+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+#define        AIC_LINUX_IRQRETURN_T irqreturn_t
+#define        AIC_LINUX_IRQRETURN(ours) return (IRQ_RETVAL(ours))
+#else
+#define        AIC_LINUX_IRQRETURN_T void
+#define        AIC_LINUX_IRQRETURN(ours)  return
+#endif

Are rather convoluted.  Could you just remove the wrappering for 2.5?


> ChangeSet
>   1.971.94.5 03/04/24 11:46:55 gibbs@overdrive.btc.adaptec.com +2 -0
>   Aic7xxx and Aic79xx driver updates
>    o Work around peculiarities in the scan_scsis routines
>      that could, due to having duplicate devices on our
>      host's device list, cause tagged queing to be disabled
>      for devices added via /proc.

-ahc_linux_select_queue_depth(struct Scsi_Host * host,
-                            Scsi_Device * scsi_devs)
+ahc_linux_select_queue_depth(struct Scsi_Host *host, Scsi_Device
*scsi_devs)

select_queue_depth isn't a 2.5 interface anymore, why do you even still
need it?

> ChangeSet
>   1.971.94.3 03/04/24 11:24:15 gibbs@overdrive.btc.adaptec.com +6 -0
>   Aic7xxx and Aic79xx driver Update
>   o Avoid pre-2.5.X mid-layer deadlock due to SCSI malloc fragmentation
[...]

This is entirely irrelevant to 2.5 as well.

James


