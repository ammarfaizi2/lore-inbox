Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965247AbVINRO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965247AbVINRO5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 13:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbVINRO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 13:14:56 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:21355 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965247AbVINRO4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 13:14:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PJfeapUsEIC9z9OcLWQTwD7/IqdPuaZnJwmxyLPbxRROc31tREPa1uOglqfmZXve0STvpEsbKzvFscNGLCdhGbu0EJPXiD0AuriMPTmsEPoE4MJPYJ4jPoOz9hKMKk0jXq/W7k9lXbnFB+MBE7HfPVfTdigT2ksQ95A9W4ZY4hU=
Message-ID: <d120d500050914101436201a71@mail.gmail.com>
Date: Wed, 14 Sep 2005 12:14:55 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Robert Love <rml@novell.com>
Subject: Re: [patch] hdaps driver update.
Cc: Greg KH <greg@kroah.com>, Mr Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1126715517.5738.35.camel@molly>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1126713453.5738.7.camel@molly> <20050914160527.GA22352@kroah.com>
	 <1126714175.5738.21.camel@molly> <20050914161622.GA22875@kroah.com>
	 <1126715517.5738.35.camel@molly>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/05, Robert Love <rml@novell.com> wrote:
> On Wed, 2005-09-14 at 09:16 -0700, Greg KH wrote:
> 
> > But you are reference counting a static object, right?  Which
> > isn't the nicest thing to have done.
> 
> I would not say it is not "the nicest thing", it is just not necessary
> to do the reference counting.  But we want the ref counting for other
> reasons, so it seems sensible.
> 
> > Why not just dynamically create it?
> 
> Seems silly to dynamically create something that we know a priori we
> only have one of.  E.g., why dynamically create something that is not
> dynamic.
> 
> But it is not a big deal.  If this is some rule of yours, I can
> kmalloc() the device_driver structure and kfree() it in my release()
> function.  Is that what you want?
> 

Just use platform_device_register_simple, it will allocate a platform
device for you and it has a release function.

> > No, if you have that .owner field in your driver, you get a symlink in
> > sysfs that points from your driver to the module that controls it.  You
> > just removed that symlink, which is not what I think you wanted to have
> > happen :(
> 
> But device release == module unload.
> 

For now. But I could see one changing device structure to create some
attribute that could keep the object pinned in memory even after
module is unloaded. It seems that we have settled on the rule that
driver_unregister waits for the last refrence to drop off but devices
can live longer.

-- 
Dmitry
