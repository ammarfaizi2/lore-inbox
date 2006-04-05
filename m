Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWDEBp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWDEBp1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 21:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWDEBp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 21:45:27 -0400
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:40876 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750759AbWDEBp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 21:45:26 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch added to gregkh-2.6 tree
Date: Tue, 4 Apr 2006 21:45:24 -0400
User-Agent: KMail/1.9.1
Cc: Greg KH <gregkh@suse.de>, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de,
       Andrew Morton <akpm@osdl.org>
References: <44238489.8090402@keyaccess.nl> <4432EF58.1060502@keyaccess.nl> <44330DFA.4080106@keyaccess.nl>
In-Reply-To: <44330DFA.4080106@keyaccess.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604042145.24685.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 April 2006 20:23, Rene Herman wrote:
> Rene Herman wrote:
> 
> > As said before, if the behaviour makes sense for other busses, maybe 
> > propagating errors up should be dependent on a flags value somewhere 
> > that a platform-driver sets?
> > 
> > If platform_device_register_simple() never returns an IS_ERR() when the 
> > device is not found that means it's not a useful interface for hardware 
> > that needs to be probed for at the very least. ALSA would need to do 
> > something like, just before returning a succesfull return from the 
> > probe() method, set a global flag that the platform_device that is about 
> > to be registered is actually representing something, and freeing all 
> > platform_devices for which the flag is _not_ set again after this.
> > 
> > Which ofcourse means this is not at all useful. It's just working around 
> > the driver model then...
> 
> Well, we could in fact hang an unregister off device->private_data as 
> per attached example. Wouldn't be _excessively_ ugly. Still sucks 
> though.

Plus it broke all the drivers that create platform devices before
registering drivers or the ones simply not using private data. Given
that some arches have a means to separate device creation from driver
probing (see pcspkr on PPC for exaple) I don;t think this is acceptable.

-- 
Dmitry
