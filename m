Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbVIAB7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbVIAB7J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 21:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbVIAB7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 21:59:09 -0400
Received: from mail25.sea5.speakeasy.net ([69.17.117.27]:33957 "EHLO
	mail25.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S965012AbVIAB7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 21:59:08 -0400
Date: Wed, 31 Aug 2005 18:58:59 -0700
From: Allen Akin <akin@pobox.com>
To: Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: State of Linux graphics
Message-ID: <20050901015859.GA11367@tuolumne.arden.org>
Mail-Followup-To: Discuss issues related to the xorg tree <xorg@lists.freedesktop.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <9e47339105083009037c24f6de@mail.gmail.com> <1125422813.20488.43.camel@localhost> <20050831063355.GE27940@tuolumne.arden.org> <1125512970.4798.180.camel@evo.keithp.com> <20050831200641.GH27940@tuolumne.arden.org> <1125522414.4798.222.camel@evo.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125522414.4798.222.camel@evo.keithp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 02:06:54PM -0700, Keith Packard wrote:
| On Wed, 2005-08-31 at 13:06 -0700, Allen Akin wrote:
| > ...
| 
| Right, the goal is to have only one driver for the hardware, whether an
| X server for simple 2D only environments or a GL driver for 2D/3D
| environments. ...

I count two drivers there; I was hoping the goal was for one. :-)

|           ... I think the only questions here are about the road from
| where we are to that final goal.

Well there are other questions, including whether it's correct to
partition the world into "2D only" and "2D/3D" environments.  There are
many disadvantages and few advantages (that I can see) for doing so.

[I'm going to reorder your comments just a bit to clarify my replies; I
hope that's OK]

|                                            ... However, at the
| application level, GL is not a very friendly 2D application-level API.

The point of OpenGL is to expose what the vast majority of current
display hardware does well, and not a lot more.  So if a class of apps
isn't "happy" with the functionality that OpenGL provides, it won't be
happy with the functionality that any other low-level API provides.  The
problem lies with the hardware.

Conversely, if the apps aren't taking advantage of the functionality
OpenGL provides, they're not exploiting the opportunities the hardware
offers.  Of course I'm not saying all apps *must* use all of OpenGL;
simply that their developers should be aware of exactly what they're
leaving on the table.  It can make the difference between an app that's
run-of-the-mill and one that's outstanding.

"Friendliness" is another matter, and it makes a ton of sense to package
common functionality in an easier-to-use higher-level library that a lot
of apps can share.  In this discussion my concern isn't with Cairo, but
with the number and type of back-end APIs we (driver developers and
library developers and application developers) have to support.

|                                                         ... GL provides
| far more functionality than we need for 2D applications being designed
| and implemented today...

When I look at OpenGL, I see ways to:

	Create geometric primitives
	Specify how those primitives are transformed
	Apply lighting to objects made of those primitives
	Convert geometric primitives to images
	Create images
	Specify how those images are transformed
	Determine which portions of images should be visible
	Combine images
	Manage the physical resources for implementing this stuff

With the exception of lighting, it seems to me that pretty much all of
that applies to today's "2D" apps.  It's just a myth that there's "far
more" functionality in OpenGL than 2D apps can use.  (Especially for
OpenGL ES, which eliminates legacy cruft from full OpenGL.)

|                    ... picking the right subset and sticking to that is
| our current challenge.

That would be fine with me.  I'm more worried about what Render (plus
EXA?) represents -- a second development path with the actual costs and
opportunity costs I've mentioned before, and if apps become wedded to it
(rather than to a higher level like Cairo), a loss of opportunity to
exploit new features and better performance at the application level.

|                  ...The integration of 2D and 3D acceleration into a
| single GL-based system will take longer, largely as we wait for the GL
| drivers to catch up to the requirements of the Xgl implementation that
| we already have.

Like Jon, I'm concerned that the focus on Render and EXA will
simultaneously take resources away from and reduce the motivation for
those drivers.

| I'm not sure we have any significant new extensions to create here;
| we've got a pretty good handle on how X maps to GL and it seems to work
| well enough with suitable existing extensions.

I'm glad to hear it, though a bit surprised.

| This will be an interesting area of research; right now, 2D applications
| are fairly sketchy about the structure of their UIs, so attempting to
| wrap them into more structured models will take some effort.

Game developers have done a surprising amount of work in this area, and
I know of one company deploying this sort of UI on graphics-accelerated
cell phones.  So some practical experience exists, and we should find a
way to tap into it.

| Certainly ensuring that cairo on glitz can be used to paint into an
| arbitrary GL context will go some ways in this direction.

Yep, that's essential.

|         ...So far, 3D driver work has proceeded almost entirely on the
| newest documented hardware that people could get. Going back and
| spending months optimizing software 3D rendering code so that it works
| as fast as software 2D code seems like a thankless task.

Jon's right about this:  If you can accelerate a given simple function
(blending, say) for a 2D driver, you can accelerate that same function
in a Mesa driver for a comparable amount of effort, and deliver a
similar benefit to apps.  (More apps, in fact, since it helps
OpenGL-based apps as well as Cairo-based apps.)

So long as people are encouraged by word and deed to spend their time on
"2D" drivers, Mesa drivers will be further starved for resources and the
belief that OpenGL has nothing to offer "2D" apps will become
self-fulfilling.

| So, I believe applications will target the Render API for the
| foreseeable future. ...

See above. :-)

Allen
