Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVCaPEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVCaPEs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 10:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVCaPDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 10:03:42 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:60478 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261498AbVCaPCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 10:02:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=cqDCSEoqgd0fVF5fjO+OqVtovSwE/dj6Z+1iT/2Vjxx+QadzQElXze/uzqBWSEW8+uBLdECA0OAJokF5U3nVt9XW0PfJUr1qM/4THIyvtIajUcl/wMsGY+aFSWZaB+T7YytZSNXDxv3Eg2/1DGipKHx+lp7w9onECSVsWxLXT+g=
Message-ID: <d120d50005033107024b4c2f96@mail.gmail.com>
Date: Thu, 31 Mar 2005 10:02:37 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Stefan Seyfried <seife@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Isaacson <adi@hexapodia.org>
In-Reply-To: <20050331083909.GA1387@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050329181831.GB8125@elf.ucw.cz>
	 <1112135477.29392.16.camel@desktop.cunningham.myip.net.au>
	 <20050329223519.GI8125@elf.ucw.cz>
	 <200503310226.03495.dtor_core@ameritech.net>
	 <20050331083909.GA1387@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2005 10:39:10 +0200, Pavel Machek <pavel@suse.cz> wrote:
> >  int swsusp_write(void)
> >  {
> >       int error;
> > -     device_resume();
> >       lock_swapdevices();
> >       error = write_suspend_image();
> >       /* This will unlock ignored swap devices since writing is
> 
> Looks good, except... why move code around? Could you just call
> usermodehelper_disable from swsusp_write?

That's because I don't think that swsusp_write is a proper place for
it ;) It looks like a lean and mean function that does just write and
manipulating usermodehelper state _and_ system (device) state is
wrong. Let it do one thing, don't overload with actions that I think
belong to the upper level. Do you agree?

I think I need to stick in usermodehelper_enable call in case
swsusp_write fails though.

-- 
Dmitry
