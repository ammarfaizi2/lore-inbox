Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbUB0W4D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 17:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbUB0Wxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 17:53:38 -0500
Received: from gate.crashing.org ([63.228.1.57]:55995 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263178AbUB0Wwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 17:52:35 -0500
Subject: Re: Radeon Framebuffer Driver in 2.6.3?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: arief# <arief_m_utama@telkomsel.co.id>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0402271755090.2216-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0402271755090.2216-100000@phoenix.infradead.org>
Content-Type: text/plain
Message-Id: <1077921806.22962.43.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 28 Feb 2004 09:43:27 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-02-28 at 05:00, James Simmons wrote:
> > Can you test the patch below ? :
> 
> Just a couple of things. The idea of adding another field to 
> con_blank bothers me. I think the better approach is to add more flags.

Linus proposed the additional parameter approach ;

> > -	if (memcmp(&info->var, var, sizeof(struct fb_var_screeninfo))) {
> > +	if ((var->activate & FB_ACTIVATE_FORCE) ||
> > +	    memcmp(&info->var, var, sizeof(struct fb_var_screeninfo))) {
> >  		if (!info->fbops->fb_check_var) {
> >  			*var = info->var;
> >  			return 0;
> 
> Ug!!! Another flag. How about instead in fbcon.c we call set_par directly 
> instead of messing with fb_set_var. 

Because fb_set_par is the proper interface, I want to get rid of all
the direct calls to the fbdev made by fbcon in the end. Calling
set_par directly will also skip the notification of the clients,
which may be just what we want for fbcon and harmful the day some
other client relies on that mecanism (and I already have one example
on ppc).

> Let me play with some ideas. I can have a another patch ready over the 
> weekend. 

Well... I was about to submit this one...

Ben.


