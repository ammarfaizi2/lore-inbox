Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWFTOtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWFTOtV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 10:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWFTOtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 10:49:20 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:13350 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751166AbWFTOtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 10:49:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CsTHIN4W4wiuCljlEdU85jiCqaLVHpCtFRVd4i/eoZa1i4vV6B55/ply6G6+zsHNH10UIZmK9K6m2YSurD15Z4zsKqxSP9uHF8lC+/R+oq+1nuIpdSdGxWdshTnaqi8MKMFMksrTj9Nn9OkPqviIK03utzJ9/RcemycCUUMNUOE=
Message-ID: <9e4733910606200749uea65b6cs65d0975cde21ba73@mail.gmail.com>
Date: Tue, 20 Jun 2006 10:49:17 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 3/9] VT binding: Make VT binding a Kconfig option
Cc: "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>
In-Reply-To: <449806B6.7060309@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44957026.2020405@gmail.com>
	 <9e4733910606191718n74d0bf40na7b0cc3902d80172@mail.gmail.com>
	 <44974AC7.4060708@gmail.com>
	 <9e4733910606191916i1994d4d1i2ea661e015431750@mail.gmail.com>
	 <4497B2B5.4040001@gmail.com>
	 <9e4733910606200704n19da7833s6873eb3270fe299e@mail.gmail.com>
	 <449806B6.7060309@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Jon Smirl wrote:
> > On 6/20/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> >> No it can't.  Once the card is in graphics mode, vgacon cannot go to
> >> text mode on its own.  It has to know how to write to other VGA
> >> registers which are unique per hardware.
> >
> > Might be a good place for a little call_usermodehelper example. VGAcon
> > could try calling vbetool to save it's state and restore it. GregKH
> > told me that the class firmware loader code was the place to start.
> >
>
> Yes, that's part of the plan. I'm still looking for the best inteface
> to do that. It must be a 2-way inteface, ie, kernel->user and user->kernel.
> Does the firmware loader code satisfy the above condition?

Currently the firmware loader  uses call_userhelper on a fixed helper
app. The code would need to be generalized so that you can call an
arbitrary app with your own parameters. Two communication while
running can be achieved via sysfs. Request firmware currently does two
way communication.

This thread should help.
http://marc.theaimsgroup.com/?l=linux-hotplug-devel&m=111129164916712&w=2

My thoughts are that it would be better to generalize the firmware
loader code that to build another version of it in the graphics code.

There are several later threads on the subject. Add me to the cc if
you start discussing this on hotplug-devel.

If I remember the discussions right request firmware is kind of broken
right now since it loads all of the firmware through a single place in
sysfs. Instead it should load the firmware by creating attributes on
the specific devices instead of having one attribute for everything.
Fixing it to allow parameters on the user space call is needed to tell
the user space script where to look for the device.

Request firmware is a very small amount of code and easy to modify.

-- 
Jon Smirl
jonsmirl@gmail.com
