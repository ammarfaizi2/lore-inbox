Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVCOTdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVCOTdm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbVCOTbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:31:33 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:7381 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261814AbVCOTaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:30:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=XttkfqPV9L+FqPnAkMIIIXtYfLIoaEcekRR94rWUdWfxYo1Y/u1WkvLQkDsh110y2pCK2DvS3FXu4Y2pZILL/YCsILUyA+vbxmWa3E8JRG9wSVOpRgra2XckfFrMAtl5OTxVqlVyeutrjQBTm3GheGk4/hUFROTbhlJ6//tfwBg=
Message-ID: <d120d5000503151130266fb235@mail.gmail.com>
Date: Tue, 15 Mar 2005 14:30:49 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Dominik Brodowski <linux@dominikbrodowski.net>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [linux-usb-devel] Re: [RFC] Changes to the driver model class code.
In-Reply-To: <20050315190847.GA1870@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050315170834.GA25475@kroah.com>
	 <20050315190847.GA1870@isilmar.linta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2005 20:08:47 +0100, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> On Tue, Mar 15, 2005 at 09:08:34AM -0800, Greg KH wrote:
> > Then I moved the USB host controller code to use this new interface.
> > That was a bit more complex as it used the struct class and struct
> > class_device code directly.  As you can see by the patch, the result is
> > pretty much identical, and actually a bit smaller in the end.
> >
> > So I'll be slowly converting the kernel over to using this new
> > interface, and when finished, I can get rid of the old class apis (or
> > actually, just make them static) so that no one can implement them
> > improperly again...
> >
> > Comments?
> 
> The "old" class api _forced_ you to think of reference counting of
> dynamically allocated objects, while it gets easier to get reference
> counting wrong using this "simple"/"new" interface: while struct class will
> always have fine reference counting, the "parent" struct [with struct class
> no longer being embedded] needs to be thought of individually; and the
> reference count cannot be shared any longer.
> 
> Also, it seems to me that you view the class subsystem to be too closely
> related to /dev entries -- and for these /dev entries class_simple was
> introduced, IIRC. However, /dev is not the reason the class subsystem was
> introduced for -- instead, it describes _types_ of devices which want to
> share (userspace and in-kernel) interfaces.

Exactly! I am working on input_dev class that lies between actual
devices and input class devices exported by evdev, tsdev, etc. It does
not have /dev entry, it is just a building block for the rest of the
subsystem. evdev and the rest will be interfaces (as per driver model)
for the input_dev class and will in turn continue exporting input
class devices that do have /dev entries.

-- 
Dmitry
