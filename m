Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWDEB7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWDEB7Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 21:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWDEB7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 21:59:16 -0400
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:57251 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751071AbWDEB7P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 21:59:15 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <gregkh@suse.de>
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch added to gregkh-2.6 tree
Date: Tue, 4 Apr 2006 21:59:12 -0400
User-Agent: KMail/1.9.1
Cc: rene.herman@keyaccess.nl, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de
References: <44238489.8090402@keyaccess.nl> <d120d5000604041428h65931eb6qffe1af04d91e7f31@mail.gmail.com> <20060404214522.GA20390@suse.de>
In-Reply-To: <20060404214522.GA20390@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604042159.12479.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 April 2006 17:45, Greg KH wrote:
> > But why do we do that? probe() failing is driver's problem. The device
> > is still there and should still be presented in sysfs. I don't think
> > that we should stop if probe() fails - maybe next driver manages to
> > bind itself.
> 
> The device is still there.
> 
> Ah, I see what you are saying now.  Yeah, we should still add the
> default attributes for the bus and create the bus link even if some
> random driver had problems. 

Not only that, but device will be killed as well - if bus_add_device()
fails device_add() branches into BusError which leads to kobject_del().

-- 
Dmitry
