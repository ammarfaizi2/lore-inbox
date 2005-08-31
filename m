Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbVHaUGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbVHaUGo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 16:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbVHaUGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 16:06:44 -0400
Received: from mail28.sea5.speakeasy.net ([69.17.117.30]:31691 "EHLO
	mail28.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S964926AbVHaUGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 16:06:43 -0400
Date: Wed, 31 Aug 2005 13:06:41 -0700
From: Allen Akin <akin@pobox.com>
To: Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: State of Linux graphics
Message-ID: <20050831200641.GH27940@tuolumne.arden.org>
Mail-Followup-To: Discuss issues related to the xorg tree <xorg@lists.freedesktop.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <9e47339105083009037c24f6de@mail.gmail.com> <1125422813.20488.43.camel@localhost> <20050831063355.GE27940@tuolumne.arden.org> <1125512970.4798.180.camel@evo.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125512970.4798.180.camel@evo.keithp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 11:29:30AM -0700, Keith Packard wrote:
| The real goal is to provide a good programming environment for 2D
| applications, not to push some particular low-level graphics library.

I think that's a reasonable goal.

My red flag goes up at the point where the 2D programming environment
pushes down into device drivers and becomes an OpenGL peer.  That's
where we risk redundancy of concepts, duplication of engineering effort,
and potential semantic conflicts.

For just one small example, we now have several ways of specifying the
format of a pixel and creating source and destination surfaces based on
a format.  Some of those formats and surfaces can't be used directly by
Render, and some can't be used directly by OpenGL.  Furthermore, the
physical resources have to be managed by some chunk of software that
must now resolve conflicts between two APIs.

The ARB took a heck of a long time getting consensus on the framebuffer
object extension in OpenGL because image resource management is a
difficult problem at the hardware level.  By adding a second low-level
software interface we've made it even harder.  We've also put artificial
barriers between "2D" clients and useful "3D" functionality, and between
"3D" clients and useful "2D" functionality.  I don't see that the nature
of computer graphics really justifies such a separation (and in fact the
OpenGL designers argued against it almost 15 years ago).

So I think better integration is also a reasonable goal.

I believe we're doing well with layered implementation strategies like
Xgl and Glitz.  Where we might do better is in (1) extending OpenGL to
provide missing functionality, rather than creating peer low-level APIs;
(2) expressing the output of higher-level services in terms of OpenGL
entities (vertex buffer objects, framebuffer objects including textures,
shader programs, etc.) so that apps can mix-and-match them and
scene-graph libraries can optimize their use; (3) finishing decent
OpenGL drivers for small and old hardware to address people's concerns
about running modern apps on those systems.

Allen
