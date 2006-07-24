Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWGXWGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWGXWGn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 18:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWGXWGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 18:06:42 -0400
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:13487 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932275AbWGXWGl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 18:06:41 -0400
Date: Mon, 24 Jul 2006 15:06:41 -0700 (PDT)
From: Trent Piepho <xyzzy@speakeasy.org>
X-X-Sender: xyzzy@shell2.speakeasy.net
To: Mauro Carvalho Chehab <mchehab@infradead.org>
cc: v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [v4l-dvb-maintainer] Re: [PATCH] V4L: struct video_device
 corruption
In-Reply-To: <1153744484.22089.56.camel@praia>
Message-ID: <Pine.LNX.4.58.0607241428070.8650@shell2.speakeasy.net>
References: <200607130047_MC3-1-C4D3-43D6@compuserve.com> 
 <20060713050541.GA31257@kroah.com>  <20060712222407.d737129c.rdunlap@xenotime.net>
  <20060712224453.5faeea4a.akpm@osdl.org> <20060715230849.GA3385@localhost>
  <1153013464.4755.35.camel@praia>  <Pine.LNX.4.58.0607171650510.18488@shell3.speakeasy.net>
  <1153310092.27276.9.camel@praia>  <Pine.LNX.4.58.0607201425060.18071@shell2.speakeasy.net>
  <1153484805.16225.12.camel@praia>  <Pine.LNX.4.58.0607211226430.26854@shell2.speakeasy.net>
  <1153513837.32625.71.camel@praia>  <Pine.LNX.4.58.0607211536190.26854@shell2.speakeasy.net>
  <1153647324.22089.32.camel@praia>  <Pine.LNX.4.58.0607231828430.16282@shell3.speakeasy.net>
 <1153744484.22089.56.camel@praia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2006, Mauro Carvalho Chehab wrote:
> Em Dom, 2006-07-23 às 19:16 -0700, Trent Piepho escreveu:
> > Second, the fix for class_device_create_file() doesn't roll-back properly
> > on failure.  I already posted a patch which does this correctly.  Attached
> > is the patch against the current Hg, go ahead and import it.
> On your hg, there are 4 patches to be applied:
>
> 1) Fix bug where struct video_device was not defined consistently
> This one seems to conflict with some previous changes I did. Please
> remove it from your tree (you need to re-clone it - you may use hg-menu
> to help on this stuff);

My Hg tree was outdated by your patches.  If you look at the time, I made
that fix on Jul 20th, then your comprehensive patch on Jul 23rd
incorporated that part of the fix.

> 3) Handle class_device_create_file in V4L2 drivers
> The patch didn't applied well at current tree.

I know, that's why I attached a version to my email that would.  I have now
re-done my tree to take into account the current code.

> 4) bttv: clean up some pre-2.6.0 class device compat stuff
> the removal of class_device_create_file on compat.h won't break
> compilation against kernel versions 2.4? Yes, I know that current

There was a check in bttv-driver.c that would skip
class_device_create_file() for older kernels (it got the version wrong, but
same idea).  I just moved this check into compat.h so that the bttv code
wouldn't be as cluttered.  My change shouldn't make any difference at all
for bttv under 2.4.  It is just to clean up the code; put compat stuff in
compat.h and not in the drivers when possible.

Other code which called c_d_c_f() will now skip it the same way bttv did
under old kernels.  All the class_device stuff doesn't exist under 2.4, and
there will be a hundred class_device related breakages.  So maybe this
patch fixes one of those hundred breakages.
