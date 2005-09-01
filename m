Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbVIAGLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbVIAGLo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 02:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbVIAGLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 02:11:44 -0400
Received: from mail28.sea5.speakeasy.net ([69.17.117.30]:50336 "EHLO
	mail28.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S964982AbVIAGLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 02:11:43 -0400
Date: Wed, 31 Aug 2005 23:11:39 -0700
From: Allen Akin <akin@pobox.com>
To: Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: State of Linux graphics
Message-ID: <20050901061139.GD11367@tuolumne.arden.org>
Mail-Followup-To: Discuss issues related to the xorg tree <xorg@lists.freedesktop.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <9e47339105083009037c24f6de@mail.gmail.com> <1125422813.20488.43.camel@localhost> <20050831063355.GE27940@tuolumne.arden.org> <1125512970.4798.180.camel@evo.keithp.com> <20050831200641.GH27940@tuolumne.arden.org> <1125522414.4798.222.camel@evo.keithp.com> <20050901015859.GA11367@tuolumne.arden.org> <43167150.1040808@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43167150.1040808@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 08:11:12PM -0700, Ian Romanick wrote:
| Allen Akin wrote:
| > Jon's right about this:  If you can accelerate a given simple function
| > (blending, say) for a 2D driver, you can accelerate that same function
| > in a Mesa driver for a comparable amount of effort, and deliver a
| > similar benefit to apps.  (More apps, in fact, since it helps
| > OpenGL-based apps as well as Cairo-based apps.)
| 
| The difference is that there is a much larger number of state
| combinations possible in OpenGL than in something stripped down for
| "just 2D".  That can make it more difficult to know where to spend the
| time tuning.  ...

I'd try solving the problem by copying what Render+EXA does, because we
already have some evidence that's sufficient.  We know what situations
Render+EXA accelerates, so in Mesa we accelerate just the OpenGL state
vectors that correspond to those situations.  The state analysis code
could be written once and shared.  You know more about that part of Mesa
than I do; do you think writing and documenting the analysis code would
be significantly more time-consuming than what's already gone into
defining and documenting the corresponding components for EXA?  The rest
is device setup, and likely to be roughly equivalent for the two
interfaces.

| The real route forward is to dig deeper into run-time code generation.

In theory, I agree (and I think it would be a really fun project).  In
practice, I've always turned away from it when tempted, because the
progress of the hardware folks is so overwhelming.  Have you seen what's
possible on cell phones that have been shipping since the beginning of
2005?  Amazing.  On low-cost power-constrained devices, a market where
it was sometimes claimed that acceleration wouldn't be practical.

| BTW, Alan, when are you going to start writing code again? >:)

Yeah, certain other IBM people have been on my case, too.  They're
largely to blame for the fact that I'm in this discussion at all.  :-)

Allen
