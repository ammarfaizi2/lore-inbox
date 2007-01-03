Return-Path: <linux-kernel-owner+w=401wt.eu-S1751044AbXACVuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbXACVuO (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 16:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbXACVuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 16:50:13 -0500
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:34272 "HELO
	smtp106.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751048AbXACVuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 16:50:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Q9qdr+PdyujPgb5HQapOOVvTiOfo44vjllfYfUpdq23kbBPmQkm4NBClCIrClhn6bBMxMiURvjoDhpxlLMoRGJFldw7QtWc0syve3ZBSDzTyPCOWWpEXnGLin3amFcqGy6jecOYhknq8om/6/Win1V5oTJuykMsHeNWqTFXglAw=  ;
X-YMail-OSG: fr3SPMQVM1nqNY03dCMzJ6R4dx3E9_wsNc7nO08z_Gye4izPZqMhH7DS6greqxsK3fhwtLCLEcEBLjyK8Lhc93doDFEWFSO8cMOSsaBEV9cxp0T9_.qR0lyQsK08EPEPo_K.QbwdDQlpyKyZ.0h6n2Q0HlgSo.JMVQY3SVP4Bs7Pj.4LOFhpBJpU.nht
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] OHCI: disallow autostop when wakeup is not available
Date: Wed, 3 Jan 2007 13:50:07 -0800
User-Agent: KMail/1.7.1
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Andrey Borzenkov <arvidjaar@mail.ru>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0701021013470.4122-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0701021013470.4122-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701031350.08679.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 January 2007 7:16 am, Alan Stern wrote:
> On Mon, 1 Jan 2007, Andrey Borzenkov wrote:

> > Is the original problem (OHCI constantly attempting and failing to suspend 
> > root hub) supposed to be fixed in 2.6.20?
> 
> No.  It can't be fixed in the kernel because it is a hardware bug.

I'm curious though:  did older kernels, say 2.6.18, have such issues?
If not, it may still be a software issue ... if you had to use the
sysfs based workaround before, I'm happy to call it a hardware issue.


> >  Currently in rc3 I have
> ...
> > ohci_hcd 0000:00:02.0: auto-stop root hub
> > ohci_hcd 0000:00:02.0: auto-wakeup root hub
> > ohci_hcd 0000:00:02.0: auto-stop root hub
> > ohci_hcd 0000:00:02.0: auto-wakeup root hub
> > ...
> > 
> > and it goes on and on until I stop it manually by usual method:
> > 
> > usb usb1: remote wakeup needed for autosuspend
> 
> The patch mentioned above allows the manual method to work. 

Not just that ... it also fixed the problem where quirk entries
saying "don't even try using remote wakeup" stopped working.

Once some pending PPC-related OHCI patches merge (support for
PS3 and other CELL systems), there will be infrastructure that
makes it easier to add quirk entries that say "this board can't
do remote wakeup properly".  At that point, we can start to
collect quirks for boards like this one.

- Dave

