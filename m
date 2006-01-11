Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWAKUaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWAKUaP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 15:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWAKUaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 15:30:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15284 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964820AbWAKUaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 15:30:13 -0500
Date: Wed, 11 Jan 2006 15:29:57 -0500
From: Dave Jones <davej@redhat.com>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: LKML <linux-kernel@vger.kernel.org>, airlied@linux.ie
Subject: Re: 2.6.15-mm2
Message-ID: <20060111202957.GA3688@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Brice Goglin <Brice.Goglin@ens-lyon.org>,
	LKML <linux-kernel@vger.kernel.org>, airlied@linux.ie
References: <20060107052221.61d0b600.akpm@osdl.org> <43C0172E.7040607@ens-lyon.org> <20060107210413.GL9402@redhat.com> <43C03214.5080201@ens-lyon.org> <43C55148.4010706@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C55148.4010706@ens-lyon.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 01:41:12PM -0500, Brice Goglin wrote:

 > I'm coming back on this topic since I managed to get DRI to work with
 > the open source driver on 2.6.15 (I mean drivers/char/drm/radeon).
 > And it does not work on -mm (actually I only tried -mm3) since
 > apparently radeon loads drm, and drm needs some agp symbols. Both radeon
 > and drm (and agpgart) and built as module here.
 > How are we supposed to get DRM to work on PCI Express cards if DRM needs
 > AGP and agpgart does not load when no AGP card is found ? :)
 > 
 > drm: Unknown symbol agp_bind_memory
 > ...
 > drm: Unknown symbol agp_backend_release
 > radeon: Unknown symbol drm_open
 > ...
 > radeon: Unknown symbol drm_release

That's puzzling. It should still be loadable. All the current agpgart tree
is doing is basically enforcing agp=off if there's no agp card present.
That shouldn't prevent the module from actually loading, or it's symbols being
referenced by other modules.

Hrmm, it's puzzling that you also are unable to resolve drm_open and drm_release.
That may be a follow-on failure from the first, but it seems unlikely.

DaveA, any clues ?

		Dave

