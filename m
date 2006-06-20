Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWFTOEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWFTOEJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 10:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWFTOEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 10:04:08 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:56983 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751000AbWFTOEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 10:04:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VRpALCmKM2XnK1GQydHkhMNHjrxCYNs5LAXZh8eifqQu5EtdHFtjbqR9kpg1/RSBO4+rgE/WpakNPG/vs1o/yw3hlQ4dXIMx2qzMsZlfUtC1hdIF8VcDa7urc06yS/x4XdkxQUHgk9KcjaEP7qVlThOa5h9xfWREhIacEZDVvcg=
Message-ID: <9e4733910606200704n19da7833s6873eb3270fe299e@mail.gmail.com>
Date: Tue, 20 Jun 2006 10:04:06 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 3/9] VT binding: Make VT binding a Kconfig option
Cc: "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>
In-Reply-To: <4497B2B5.4040001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44957026.2020405@gmail.com>
	 <9e4733910606191718n74d0bf40na7b0cc3902d80172@mail.gmail.com>
	 <44974AC7.4060708@gmail.com>
	 <9e4733910606191916i1994d4d1i2ea661e015431750@mail.gmail.com>
	 <4497B2B5.4040001@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> All fbdev drivers have a startup mode that should always be valid. All
> fbcon does is enable that mode.
>
> You can load nvidiafb like this instead:
>
> modprobe nvidiafb mode_option=1024x768@60

Good idea, it didn't occur to me to use the module parameters. Doing
it that way I can see what I am doing instead of typing blind.

> > How does vbetool save state?
>
> vbetool basically calls an int10 function that saves the state.  This
> function is unique per video BIOS, ie you cannot use the state file in
> another machine even if the graphics chipset is the same.
>
> > Could VGAcon do whatever vbetool is doing?
>
> No it can't.  Once the card is in graphics mode, vgacon cannot go to
> text mode on its own.  It has to know how to write to other VGA
> registers which are unique per hardware.

Might be a good place for a little call_usermodehelper example. VGAcon
could try calling vbetool to save it's state and restore it. GregKH
told me that the class firmware loader code was the place to start.

-- 
Jon Smirl
jonsmirl@gmail.com
