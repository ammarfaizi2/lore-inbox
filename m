Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262664AbVCJPhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262664AbVCJPhP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 10:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVCJPhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 10:37:15 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:44469 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262664AbVCJPg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 10:36:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=rmRjtmdNOWfuX9bXizdt/uOQxvJP5klSOeXRoFQt9w3tHqhWGQXvj4TrmXJ45MpKBUkw0CLauu61HONFZMRZ6mZfk8QV5ScoeW3KqteDclN5cIRq+qDMHFxjV7LTRGLjFFzOKHsWpTzIOEEst8DnMzKXzCfphXuGSC6nKebHb2A=
Message-ID: <d120d5000503100736212a9c87@mail.gmail.com>
Date: Thu, 10 Mar 2005 10:36:57 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] OSS gameport fixes
Cc: Borislav Petkov <petkov@uni-muenster.de>, perex@suse.cz, vojtech@suse.cz,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, linux-input@atrey.karlin.mff.cuni.cz
In-Reply-To: <20050309113217.GB21688@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050304033215.1ffa8fec.akpm@osdl.org>
	 <200503070941.59365.petkov@uni-muenster.de>
	 <20050307215206.GH3170@stusta.de>
	 <d120d50005030714126e345fe2@mail.gmail.com>
	 <20050307230633.GJ3170@stusta.de> <20050309113217.GB21688@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2005 12:32:17 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> This patch adds dummy gameport_register_port, gameport_unregister_port
> and gameport_set_phys functions to gameport.h for the case when a driver
> can't use gameport.
> 
> This fixes the compilation of some OSS drivers with GAMEPORT=n without
> the need to #if inside every single driver.
> 
> This patch also removes the non-working and now obsolete SOUND_GAMEPORT.
> 
> This patch is also an alternative solution for ALSA drivers with similar
> problems (but #if's inside the drivers might have the advantage of
> saving some more bytes of gameport is not available).
> 
> The only user-visible change is that for GAMEPORT=m the affected OSS
> drivers are now allowed to be built statically (but they won't have
> gameport support).
> 

Hi Adrian,

I have somewhat mixed feeling about the patch. Some solutions is
definitely needed but I don't like allocating memory that will never
be used. I think I would perfer #ifdefing gameport support is OSS
modules, _if_ #ifdefs are out of line and not in the middle of code
path.

I'll let Vojtech decide which way he wants to go - he could probably
apply the patch and then we could convert drivers one by one and kill
the stubs later.

-- 
Dmitry
