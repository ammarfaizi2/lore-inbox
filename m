Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbTEQIlg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 04:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbTEQIlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 04:41:36 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:6293 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S261185AbTEQIle
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 04:41:34 -0400
Date: Sat, 17 May 2003 10:54:24 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: David Gibson <david@gibson.dropbear.id.au>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>
Subject: Re: request_firmware() hotplug interface, third round.
Message-ID: <20030517085424.GD3808@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <20030516233751.GA2045@ranty.ddts.net> <20030516235958.GA17439@kroah.com> <20030517044744.GC13827@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030517044744.GC13827@zax>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 17, 2003 at 02:47:44PM +1000, David Gibson wrote:
> On Fri, May 16, 2003 at 04:59:58PM -0700, Greg Kroah-Hartman wrote:
> > On Sat, May 17, 2003 at 01:37:52AM +0200, Manuel Estrada Sainz wrote:
> > > > > 	- Driver calls request_firmware()
> > > > 
> > > > Yeah, I agree with your comment in the code, I think a struct device *
> > > > should be passed here.  Or at least somewhere...
> > > 
> > >  To make compatibility with 2.4 kernel easier, I think that I'll add a
> > >  new 'struct device *' parameter to request_firmware(). On 2.4 kernels
> > >  it can be an unused 'void *'. Does that sound too ugly?
> > 
> > Yeah, don't use void * if you can ever help it.  As there will be two
> > different versions for two different kernels, just don't have that
> > paramater, or make it a char * like you have now for 2.4.  That seems to
> > make sense for 2.4 where you don't have a struct device.
> > 
> > > > > 	- 'hotplug firmware' gets called with ACCTION=add
> > > > 
> > > > I don't see why you need to add a new environment variable in your
> > > > firmware_class_hotplug() call.  What is the FIRMWARE variable for, if we
> > > > already have a device symlink back to the device that is asking for the
> > > > firmware?  Oh, you don't have that :)
> > > 
> > >  The same device can ask for different firmware images.
> > 
> > Ah, that makes more sense now.  Ok, I have no problem with it.
> 
> Given this, would it be better to make the sysfs node name depend on
> which firmware we're loading - rather than "data" always. 

> I realise we could just require firmware requests for a particular
> device instance to be serialised, 

 I think that is a pretty good assumption.

 It won't be me how loads two different firmwares concurrently to the
 same device :)
 

> however my instinct says using different nodes would be more robust:

 It would also complicate both kernel and userspace code.

> it will be easier to figure out what's gone wrong if a script error 

 For this matter, I could add a readonly 'name' which gives you the same
 string as $FIRMWARE. That way if something goes wrong you can easily
 find out which firmware image the kernel is expecting.

> or a kernel bug has resulted in attempting to load two images at once.

 This will get caught, because sysfs won't allow two entries with the
 same name.

 Thanks

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
