Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269719AbUJGGH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269719AbUJGGH1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 02:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267287AbUJGGH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 02:07:27 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:1530 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S269719AbUJGGHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 02:07:10 -0400
Subject: Re: scsi Target card and scsi Initiator card
From: "NucleoDyne Systems, " "Inc." <nucleon@nucleodyne.com>
Reply-To: nucleon@nucleodyne.com
To: Nikhil Dharashivkar <dharashivkar.nikhil@spsoftindia.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <017901c4ac30$cde21510$1610a8c0@spsoft.com>
References: <017e01c4ab91$510a3e90$1610a8c0@spsoft.com>
	 <4163DDC6.3030102@vlnb.net>  <017901c4ac30$cde21510$1610a8c0@spsoft.com>
Content-Type: text/plain
Organization: NucleoDyne Corporation
Message-Id: <1097129221.3261.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 06 Oct 2004 23:07:01 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   Is your configuration as described below?

server-----scsi cable ---- target port ---initiator(s)----devices


   There is an easy solution. You may develop a kernel module
that will accept the packets from the target card and forward them
to the initiator. There are a few calls in linux to submit a request 
to an initiator. You may look at scsi_do_request() call.

I guess I can not disclose more in details as I have signed a NDA.

A single LSI card (at least a fusion MPT) can be programmed so that it
responds in the SELECTION phase for multiple target devices. That is 
the same card can raise the BUSY signal for different target ids
and responds to a selection. This way you can present multiple targets
behind your initiator through your target mode port on the board.

Please feel free to contact me if you need additional help.

Kallol
-- 
--
NucleoDyne Corporation
nucleon@nucleodyne.com
www.nucleodyne.com
408-718-8164

On Wed, 2004-10-06 at 22:44, Nikhil Dharashivkar wrote:
> Hi,
>      Actually our setup of hardware is : There is one board . On that we
> have one target mode card (LSI) and more than one initiator cards.
>        First thing I have to do is I should able to export all LUNS or
> target devices connected to initiator card through this target mode card.
>       For that how should i think to develop software layer . Is there
> already implemeted code ?
> 
> 
>  ---- Original Message -----
> From: "Vladislav Bolkhovitin" <vst@vlnb.net>
> To: "Nikhil Dharashivkar" <dharashivkar.nikhil@spsoftindia.com>
> Sent: Wednesday, October 06, 2004 5:27 PM
> Subject: Re: scsi Target card and scsi Initiator card
> 
> 
> > Nikhil,
> >
> > Everything is done according to appropriate SCSI standards, like Fibre
> > Channel or iSCSI. Try to find their description, for example, on
> > http://www.t10.org.
> >
> > Best regards,
> > Vlad
> >
> > Nikhil Dharashivkar wrote:
> > > hi all,
> > >     I want to know how target card is exposed to the intiator.
> > > How connectivity is done between both cards. How luns are exposed from
> > > target mode card to initiator card.
> > >  How communication is done when there is one target mode card and
> multiple
> > > initiator cards.
> > >
> > >
> > > Thanks,
> > >  Nikhil.
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >
> > >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


