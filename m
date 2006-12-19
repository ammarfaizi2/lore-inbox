Return-Path: <linux-kernel-owner+w=401wt.eu-S933031AbWLSVex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933031AbWLSVex (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 16:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933033AbWLSVex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 16:34:53 -0500
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:48954 "HELO
	smtp110.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933031AbWLSVew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 16:34:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=m923RIyEdISD5NfSiP21Xbl2MCUd+4ZUWAUPVkXRCFpgTJtKJpIswr/IL8WG/EP2ccgMPyeClFLSwiEpNlUxbFGLZpmnEnd1qphTx4OnfUNVtWv8QWIFjc3Dhu9rLMRihQtZ3lmLzYfRJy+9cH+91yiR2fxF64NHixhoz6bJmes=  ;
X-YMail-OSG: pAHHCQgVM1nON3n7E6KxfHVjyjJTfqN9yI7wM8KReJWaMoOZ2xDHhwpAKsrRisvKbVCwi1iHu4MLMO5bvZIc4nid5t_gGXe4Xkn0HiHd7zz_o.tgQxUq3D2vc9cZL4XzekQs7jZ8GwFCC9MFJkhy1i3sMytNSik__4ocEwk5VD0jERqfIm7kQgA7nu2h
From: David Brownell <david-b@pacbell.net>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Changes to sysfs PM layer break userspace
Date: Tue, 19 Dec 2006 13:34:49 -0800
User-Agent: KMail/1.7.1
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
References: <20061219185223.GA13256@srcf.ucam.org> <1166559785.3365.1276.camel@laptopd505.fenrus.org> <20061219203251.GA14648@srcf.ucam.org>
In-Reply-To: <20061219203251.GA14648@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612191334.49760.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 December 2006 12:32 pm, Matthew Garrett wrote:
> On Tue, Dec 19, 2006 at 09:23:05PM +0100, Arjan van de Ven wrote:

> > right now the "spec" for Linux network drivers assumes that you put the
> > NIC into D3 on down, except for cases where Wake-on-Lan is enabled etc.
> 
> Really? I can't find any drivers that seem to do this. The only calls to 
> pci_set_power_state seem to be in the suspend, resume, init and exit 
> routines.

More drivers should do this, even though not many do so right now.  In the
ideal case, the PHY can be active for link detection without the rest of
the adapter being powered up...


> > > Some chips support more 
> > > fine-grained power management, so we could do something more sensible in 
> > > that case - but right now, there doesn't seem to be a lot of driver 
> > > support for it.
> > 
> > sounds like that's the right approach at least .. not talking to the PCI
> > hardware directly from userspace...
> 
> I'd certainly agree that that's the right thing to do, but userspace has 
> a habit of using whatever functionality /is/ available to get to a given 
> end. The semantics of the device/power/state file were never made 
> terribly clear, and it did have the desired effect of suspending the 
> device. Removing it without providing warning or a transition pathway is 
> a pain.

Documentation/feature-removal-schedule.txt has warned about this since
August, and the PM list has discussed how broken that model is numerous
times over the past several years.  (I'm pretty sure that discussion has
leaked out to LKML on occasion.)  It shouldn't be news today.


> > I can see the point of having more than just "UP" and "DOWN" as
> > interface states; "UP", "DOWN" and "OFF" for example... 
> 
> Agreed.

More than one driver stack probably needs to start paying attention to
its power management models.  I think Arjan is right about the basic
mindset of "down == off" for network drivers.  If there are cases where
that doesn't work, those can start driving improvements.

- Dave

