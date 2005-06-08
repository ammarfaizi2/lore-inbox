Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVFHRIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVFHRIb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 13:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVFHRHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 13:07:22 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:35436 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261386AbVFHRGp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 13:06:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iDNCYr+wNXIwKrKE2FLv5IV1WimW0S02jRWPmYma4PMg06mqLmi58N6jsUhYTHWS94CIMaG78TnOs/bNEciJodxrqetohPeFQf5jNLWb3DYgvyhoXMqhlMzlLpe3TEd+KlOS0DUe1aBF5YFAQTPLaVgKB1zwF0GaOo9JJDjbmRY=
Message-ID: <d120d5000506081006340052a1@mail.gmail.com>
Date: Wed, 8 Jun 2005 12:06:43 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <greg@kroah.com>
Subject: Re: [patch 2.6.12-rc3] modifications in firmware_class.c to support nohotplug
Cc: Abhay_Salunke@dell.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Matt_Domsch@dell.com, ranty@debian.org
In-Reply-To: <20050608162632.GA1588@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <367215741E167A4CA813C8F12CE0143B3ED3B6@ausx2kmpc115.aus.amer.dell.com>
	 <20050608162632.GA1588@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/05, Greg KH <greg@kroah.com> wrote:
> On Wed, Jun 08, 2005 at 11:23:30AM -0500, Abhay_Salunke@Dell.com wrote:
> >
> >
> > > -----Original Message-----
> > > From: Greg KH [mailto:greg@kroah.com]
> > > Sent: Wednesday, June 08, 2005 11:10 AM
> > > To: Salunke, Abhay
> > > Cc: dtor_core@ameritech.net; linux-kernel@vger.kernel.org;
> > akpm@osdl.org;
> > > Domsch, Matt; ranty@debian.org
> > > Subject: Re: [patch 2.6.12-rc3] modifications in firmware_class.c to
> > > support nohotplug
> > >
> > > On Wed, Jun 08, 2005 at 11:04:09AM -0500, Abhay_Salunke@Dell.com
> > wrote:
> > > > > I think it would be better if you just have request_firmware and
> > > > > request_firmware_nowait accept timeout parameter that would
> > override
> > > > > default timeout in firmware_class. 0 would mean use default,
> > > > > MAX_SCHED_TIMEOUT - wait indefinitely.
> > > >
> > > > But we still need to avoid hotplug being invoked as we need it be a
> > > > manual process.
> > >
> > > No, hotplug can happen just fine (it happens loads of times today for
> > > things that people don't care about.)
> > >
> > If hotplug happens the complete function is called which makes the
> > request_firmware return with a failure.
> 
> If this was true, then the current code would not work at all.
> 

What Abhay is trying to say is that default firmware.agent when it
does not find requested firmware file writes -1 (abort) to "loading"
attribute causing firmware_request to fail.

I think it should be fixed in firmware.agent though, not in kernel -
the agent shoudl just recognoze that sometimes not having firmware
file is ok.

-- 
Dmitry
