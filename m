Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbVJFRkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbVJFRkM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 13:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbVJFRkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 13:40:11 -0400
Received: from qproxy.gmail.com ([72.14.204.192]:52702 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751254AbVJFRkK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 13:40:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P79ofOkD4YfsWY+pkt2FEVhBPQh0HDws+hEZ1duKnhdeyMjEiB5Fv3qRK8vA8uRU+29cm/MfAFcRqqNZk/DenqZPOt9IdfQcIlWx72xHm/oVOuCmOZmwlvcMLkMlN3EOvTF+9U3Rrk25UebuWfjW7rYZV6RhXwnyEKvC9GbIB/Q=
Message-ID: <d120d5000510061040t760c127bpc37212f15c7981c2@mail.gmail.com>
Date: Thu, 6 Oct 2005 12:40:08 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH] nesting class_device in sysfs to solve world peace
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
In-Reply-To: <434511CE.5080004@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050928233114.GA27227@suse.de>
	 <200509300032.50408.dtor_core@ameritech.net>
	 <20051006000951.GA4411@suse.de>
	 <200510060129.28066.dtor_core@ameritech.net>
	 <434511CE.5080004@tls.msk.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/05, Michael Tokarev <mjt@tls.msk.ru> wrote:
> Dmitry Torokhov wrote:
> > On Wednesday 05 October 2005 19:09, Greg KH wrote:
> >
> >>On Fri, Sep 30, 2005 at 12:32:49AM -0500, Dmitry Torokhov wrote:
> >>
> >>>On Wednesday 28 September 2005 18:31, Greg KH wrote:
> >>>
> >>>>Alright, here's a patch that will add the ability to nest struct
> >>>>class_device structures in sysfs.  This should give everyone the ability
> >>>>to model what they need to in the class directory (input, video, etc.).
> >>>
> >>>I still do not believe it is the solution we want:
> >>>
> >>>1. It does not allow installing separate hotplug handlers for devices
> >>>   and their sub-devices. This will cause hotplug handlers to resort to
> >>>   having some flags or otherwise detect the king of class device hotplug
> >>>   hanlder is being called for and change behavior accordingly - YUCK!
> >>
> >>Huh?  I don't understand your complaint here.  Why would we ever want to
> >>have separate hotplug handlers for the same class?  If you do want that,
> >>then create separate classes.
> >>
> >
> >
> > Yes. I do want separate [sub]classes. I just want them grouped together
> > under some <subsystem> name. And I want separate hotplug handlers because
> > actions that are needed for these objects are different. When a new
> > input_dev appears you want to match its capabilities with one or more
> > input handlers and load appropriate handler module if it has not been
> > loaded yet. When a new input interface device appears you want to create
> > a new device node for it. The handlers should be diffrent if you want
> > clean implementation, do you see?
>
> How about using current classes, but name them to have common prefix,
> eg input_dev, input_interface etc class names - this way, if a program
> wants to enumerare all input <whatever>, it enumerates /sys/class,
> finds all directories matching input*, and looks inside...
>
> Maybe not that elegant, but may work.
>

We have it right now (see /sys/class/{ieee1394_*|scsi-*|usb_*}) and it
pretty much sucks IMHO. I would like to move from a flat class model
to a more tree-like structure.

--
Dmitry
