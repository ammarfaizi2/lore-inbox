Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262283AbUKQLze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbUKQLze (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 06:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbUKQLze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 06:55:34 -0500
Received: from ip-svs-1.Informatik.Uni-Oldenburg.DE ([134.106.12.126]:6374
	"EHLO aechz.svs.informatik.uni-oldenburg.de") by vger.kernel.org
	with ESMTP id S262283AbUKQLz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 06:55:27 -0500
Date: Wed, 17 Nov 2004 12:55:05 +0100
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Linux 2.6.10-rc2 SAVAGEFB startup crash
Message-ID: <20041117115505.GA2216@titan.lahn.de>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"Antonino A. Daplas" <adaplas@hotpop.com>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <200411162043.23585.adaplas@hotpop.com> <20041116172748.GA2499@titan.lahn.de> <200411170543.04360.adaplas@hotpop.com> <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <200411162043.23585.adaplas@hotpop.com> <20041116172748.GA2499@titan.lahn.de> <200411170520.59576.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411170543.04360.adaplas@hotpop.com> <200411170520.59576.adaplas@hotpop.com>
Organization: UUCP-Freunde Lahn e.V.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Nov 17, 2004 at 05:20:58AM +0800, Antonino A. Daplas wrote:
> > That fixed the crash, but the screen looks very broken on my notebook
> > after boot. Switching between XFree86 and SavageFB also locked up the
> > kernel hard.
>
> Try booting at the native resolution of your notebook, for example:
>
> video=savagefb:1024x768@60

The "@60" did it. (Reading "man 4x savage" -> "UseBIOS" gives my the
impression, that this is important for some mobile chips.)

On Wed, Nov 17, 2004 at 05:43:02AM +0800, Antonino A. Daplas wrote:
> > after boot. Switching between XFree86 and SavageFB also locked up the
>
> As for the lockup between X and the console, can you try this patch?
...
> -		               FBINFO_HWACCEL_XPAN;
> +		               FBINFO_HWACCEL_XPAN |
> +	                       FBINFO_MISC_MODESWITCHLATE;

That (partly) solved the lockup: I was able start XFree86, switch back
to Console, but on return to X11, the X11 screen wasn't restored
correctly, the mouse left a trail behind and switching to console
again didn't work. (a remove "chvt 1" as root still worked). Exiting
and than restarting XFree86 sometimes didn't initialize the screen
correctly.

While writing this email, my notebook locked up again hard and I had to
powercycle it.

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
