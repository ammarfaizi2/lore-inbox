Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbUB2Gg2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 01:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbUB2Ge4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 01:34:56 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:45479 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261988AbUB2Gen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 01:34:43 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Manuel Estrada Sainz <ranty@ranty.pantax.net>
Subject: Re: [PATCH] request_firmware(): fixes and polishing.
Date: Sun, 29 Feb 2004 01:30:47 -0500
User-Agent: KMail/1.6
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       jt@hpl.hp.com, Simon Kelley <simon@thekelleys.org.uk>
References: <10776728882704@kroah.com>
In-Reply-To: <10776728882704@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402290130.47960.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 February 2004 08:34 pm, Manuel Estrada Sainz wrote:
> 
>  Hi,
> 
>  Please apply.
> 
>  Dmitry Torokhov has been criticizing my code for some days (Thanks Dmitry),
>  and here is the result. It should be ready for -mm tree.
>  
>  Simon Kelly tested the patch series and reported improvement with some
>  problems he was having.
> 

I have couple more fixes to the firmware loader class:

firmware-pin_module.patch:
  - we need to pin the firmware module if we successfully registered firmware
    class device and "put" it in device re4lease function otherwise the
    module could be unloaded too early. Consider:
    - some module requests firmware
    - firmware loader registers class device and calls hotplug
    - userspace hangs keeping 
    - firmware loader times out
    - the calls module is unloaded. Now firmware loader has 0 refcount and
      cazn be unloaded as well leaving device class behind.
    Am I seeing things?

firmware-hotplug.patch
  - I stll think that we sould not call userspace until we registered all
    necessary attributes. Now that Greg put my changes to kobject in mainline
    ist very easy -  just inhibit hotplug handler until we are ready and call
    kobject_hitplug by ourselves.

Please comment.

-- 
Dmitry
