Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVC2VHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVC2VHV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 16:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVC2VHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 16:07:20 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:51523 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261433AbVC2VHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 16:07:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=SgWjeKh4Zr+rgkD3nOYBzQYCCWqS1KE3k+GQrOR6C2w3RY8T7EU54LbO09ulh5je0gXNoO9o52CL6jQeUUXwg2tPZOCTeQKqQKuvk39xJLXRVUn1YPdnrHmPxeYIwkUdYcqm7L4sZVufzz3RjvRKdpXpBlUO8ifNoHtCo/advn4=
Message-ID: <d120d500050329130714e1daaf@mail.gmail.com>
Date: Tue, 29 Mar 2005 16:07:01 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Cc: Stefan Seyfried <seife@suse.de>, Andy Isaacson <adi@hexapodia.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <20050329205225.GF8125@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <4242CE43.1020806@suse.de> <4243252D.6090206@suse.de>
	 <20050324235439.GA27902@hexapodia.org> <4243D854.2010506@suse.de>
	 <d120d50005032908183b2f622e@mail.gmail.com>
	 <20050329181831.GB8125@elf.ucw.cz>
	 <d120d50005032911114fd2ea32@mail.gmail.com>
	 <20050329192339.GE8125@elf.ucw.cz>
	 <d120d50005032912051fee6e91@mail.gmail.com>
	 <20050329205225.GF8125@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2005 22:52:25 +0200, Pavel Machek <pavel@suse.cz> wrote:
> I don't really want us to try execve during resume... Could we simply
> artifically fail that execve with something if (in_suspend()) return
> -EINVAL; [except that in_suspend() just is not there, but there were
> some proposals to add it].
> 
> Or just avoid calling hotplug at all in resume case? And then do
> coldplug-like scan when userspace is ready...
> 

I am leaning towards calling disable_usermodehelper (not writtent yet)
after swsusp completes snapshotting memory. We really don't care about
hotplug events in this case and this will allow keeping "normal"
resume in drivers as is. What do you think?

-- 
Dmitry
