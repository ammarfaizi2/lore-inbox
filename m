Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVCYOT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVCYOT2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 09:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVCYOT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 09:19:28 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:8370 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261627AbVCYOTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 09:19:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=g3vmCkGJ6wQdy86KlWReF4ChM0qL1OAfnBijAkIpEi23DvNDvuVFKxcdX86py+RcMB2yRvTP45GivlydHmpIp4fKh0WLIjujZ27wmjq4cwhSdySOoNMa1vs4s/u7wZFKsMDr+1w1xBJvtQqqA6bDk1ntC/UsEa1XcPuDe4iUfo0=
Message-ID: <d120d500050325061963fb13db@mail.gmail.com>
Date: Fri, 25 Mar 2005 09:19:20 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Cc: Stefan Seyfried <seife@suse.de>, Andy Isaacson <adi@hexapodia.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <20050325101344.GA1297@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050323184919.GA23486@hexapodia.org> <4242CE43.1020806@suse.de>
	 <20050324181059.GA18490@hexapodia.org> <4243252D.6090206@suse.de>
	 <20050324235439.GA27902@hexapodia.org> <4243D854.2010506@suse.de>
	 <20050325101344.GA1297@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 25 Mar 2005 11:13:44 +0100, Pavel Machek <pavel@suse.cz> wrote:
> Hi!
> 
> > > OK, anything else I should try?
> >
> > not really, i just wait for Vojtech and Pavel :-)
> 
> Try commenting out "call_usermodehelper". If that helps, Stefan's
> theory is confirmed, and this waits for Vojtech to fix it.
> 

This is more of a general swsusp problem I believe - the second phase
when it blindly resumes entire system. Resume of a device can fail
(any reason whatsoever) and it will attempt to clean up after itself,
but userspace is dead and hotplug never completes. While I am
interested to know why ALPS does not want to resume on ANdy's laptop
the issue will never be completely resolved from within the input
system.

Pavel, is it possible for swsusp to disable hotplug (probably just do
hotplug_path[0] = 0) before resuming in suspend phase?

A bit on tangent - you need to resume system so you can write the
image, right? I wonder if we could add a flag to struct device that
would mark device as "on_resume_path". The flag would be set when you
select resume partition and propagated to the root of the system. Then
when resume after making the image you could skip all devices that are
not on resume path.

-- 
Dmitry
