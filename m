Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267720AbUJCDz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267720AbUJCDz6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 23:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267721AbUJCDz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 23:55:58 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:14569 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267720AbUJCDz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 23:55:56 -0400
Message-ID: <9e47339104100220553c57624a@mail.gmail.com>
Date: Sat, 2 Oct 2004 23:55:55 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: dri-devel@lists.sf.net, lkml <linux-kernel@vger.kernel.org>
Subject: Merging DRM and fbdev
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've started on a merged fbdev and DRM driver model. 
It doesn't work yet but here's what the modules look like:

Module                  Size  Used by
fbcon                  38080  0
radeon                123598  1
fb                     34344  2 fbcon,radeon
drm                    59044  1 radeon

fbcon and fb modules are almost unmodified from the kernel source.
radeonfb and radeondrm have been merged into a single driver. The
merged driver uses both the drm and fb modules as libraries. It wasn't
possible to build this model until drm supported drm-core.

The radeon and fb modules will get smaller, I'm just beginning to use
the delete key on them. There is still a lot of duplicated code inside
the radeon driver.

In this model a non-drm, fb only driver like cyber2000 could load only
the fb and fbcon modules. I need to do some work rearranging generic
library support functions to allow this.

This is the next phase in the work described in this email:
http://lkml.org/lkml/2004/8/2/111

-- 
Jon Smirl
jonsmirl@gmail.com
