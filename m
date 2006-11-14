Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966294AbWKNUyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966294AbWKNUyP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966258AbWKNUyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:54:15 -0500
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:57234 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S966294AbWKNUyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:54:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=k5QNilNs6l/mKzooXQqWyo/rJO92gepjBOBrg1YfPA9luUQhh2GrpCZ45LZ3j6zQvtepOChHyjrY6EGS5/NydExuNIqh0b50oNcSe9Rfy27cPUNAKl0DuR33FZ5sirN1TE0IVtYTo5DBGhI4ftRiQD+XSzzK1J4FKgLe4kaNz7g=  ;
X-YMail-OSG: UYLQiWwVM1mZxv_d0eHx9oEl1SayjSZWo0p6uyRURon_xDfqrUEFYWh59I8W.D6u6KpuOHsGv0Ys667NHc.UXVMxN4MK0PzA6bkPHa18qzMhs.6JKolSrQ--
From: David Brownell <david-b@pacbell.net>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [Bulk] Re: [linux-usb-devel] 2.6.19-rc5 regression: can't disable OHCI wakeup via sysfs
Date: Tue, 14 Nov 2006 12:54:09 -0800
User-Agent: KMail/1.7.1
Cc: Alan Stern <stern@rowland.harvard.edu>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0611131457050.2390-100000@iolanthe.rowland.org> <200611142348.30082.arvidjaar@mail.ru>
In-Reply-To: <200611142348.30082.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611141254.09474.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 November 2006 12:48 pm, Andrey Borzenkov wrote:
> On Monday 13 November 2006 22:58, Alan Stern wrote:
> > Andrey:
> >
> > Try this patch for 2.6.19-rc5.  Although it doesn't make all the changes
> > Dave and I have discussed, it ought to fix your problem.
> >
> 
> It did. Thank you

Then this should get merged into 2.6.19-rc ASAP ...

- Dave


> -andrey
> 
> > Alan Stern
> >
> >
> > Index: 2.6.19-rc5/drivers/usb/host/ohci-hub.c
> > ===================================================================
> > --- 2.6.19-rc5.orig/drivers/usb/host/ohci-hub.c
> > +++ 2.6.19-rc5/drivers/usb/host/ohci-hub.c
> > @@ -422,7 +422,8 @@ ohci_hub_status_data (struct usb_hcd *hc
> >  				ohci->autostop = 0;
> >  				ohci->next_statechange = jiffies +
> >  						STATECHANGE_DELAY;
> > -			} else if (time_after_eq (jiffies,
> > +			} else if (device_may_wakeup(&hcd->self.root_hub->dev)
> > +					&& time_after_eq(jiffies,
> >  						ohci->next_statechange)
> >  					&& !ohci->ed_rm_list
> >  					&& !(ohci->hc_control &
> 
