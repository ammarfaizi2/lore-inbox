Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbWIVOJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbWIVOJl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 10:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbWIVOJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 10:09:41 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:33494 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932511AbWIVOJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 10:09:40 -0400
Date: Fri, 22 Sep 2006 16:09:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Scott E. Preece" <preece@motorola.com>
Cc: eugeny.mints@gmail.com, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
Message-ID: <20060922140937.GL3478@elf.ucw.cz>
References: <200609191946.k8JJkJmx028840@olwen.urbana.css.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609191946.k8JJkJmx028840@olwen.urbana.css.mot.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> | > >>+struct powerop_driver {
> | > >>+	char *name;
> | > >>+	void *(*create_point) (const char *pwr_params, va_list args);
> | > >>+	int (*set_point) (void *md_opt);
> | > >>+	int (*get_point) (void *md_opt, const char *pwr_params, va_list 
> | > >>args);
> | > >>+};
> | > >
> | > >We can certainly get better interface than va_list, right?
> | > 
> | > Please elaborate.
> | 
> | va_list does not provide adequate type checking. I do not think it
> | suitable in driver<->core interface.
> ---
> 
> Well, in this particular case the typing probably has to be weak, one
> way or another. The meaning of the parameters is arguably opaque at

Why not have struct powerop_parameters, defined in machine-specific
header somewhere, but used everywhere?

> the interface - the attributes may be meaningful to specific components
> of the system, but are not defined in the standardized interface (which
> would otherwise have to know about all possible kinds of power
> attributes and be changed every time a new one is added).
> 
> So, if you'd rather have an array of char* or void* values, that would
> probably also meet the need, but my guess is that the typing is
> intentionally opaque.

Actually array of integers would be better than this.

> | > >How is it going to work on 8cpu box? will
> | > >you have states like cpu1_800MHz_cpu2_1600MHz_cpu3_800MHz_... ?
> | > 
> | > i do not operate with term 'state' so I don't understand what it means here.
> | 
> | Okay, state here means "operating point". How will operating points
> | look on 8cpu box? That's 256 states if cpus only support "low" and
> | "high". How do you name them?
> 
> I don't think you would name the compounded states. Each CPU would need
> to have its own defined set of operating points (since the capabilities
> of the CPUs can reasonably be different).

Well, having few "powerop domains" per system would likely solve that
problem... and problem of 20 devices on my PC. Can we get that?

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
