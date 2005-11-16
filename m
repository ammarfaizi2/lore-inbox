Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965185AbVKPCZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbVKPCZV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 21:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbVKPCZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 21:25:21 -0500
Received: from mailfe07.tele2.fr ([212.247.154.204]:1968 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S965185AbVKPCZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 21:25:18 -0500
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Wed, 16 Nov 2005 03:25:08 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Jason Dravet <dravet@hotmail.com>
Cc: 7eggert@gmx.de, adaplas@gmail.com, torvalds@osdl.org, akpm@osdl.org,
       davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vgacon: Workaround for resize bug in some chipsets
Message-ID: <20051116022507.GJ5080@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Jason Dravet <dravet@hotmail.com>, 7eggert@gmx.de,
	adaplas@gmail.com, torvalds@osdl.org, akpm@osdl.org,
	davej@redhat.com, linux-kernel@vger.kernel.org
References: <20051116000549.GC5080@bouh.residence.ens-lyon.fr> <BAY103-F149222EE61B1B5CD0FBE86DF5C0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BAY103-F149222EE61B1B5CD0FBE86DF5C0@phx.gbl>
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Jason Dravet, le Tue 15 Nov 2005 19:50:39 -0600, a écrit :
> Here are the results:
> y=25   fonth=16   deffh=16   vidfh=16   scanl=400
> overflow=ff
> vsync_end=8f
> vdisp_end=1f

Ah, this is odd indeed: your hardware uses 800 scanlines
(overflow:(512+256)+vdisp_end:0x1f), while the actual needed lines
should be y:25*fonth:16 ... Maybe it is actually using a 32 lines font.

Just to make sure about every VGA bits, could you install the
svgatextmode package, which holds a getVGAreg command, and run twice

for i in `seq 0 24` ; do getVGAreg CRTC $i ; done

The first time while having a correct full text screen rendering, and
the second time after vgacon_doresize() has blanked the bottom half of
the screen.

Regards,
Samuel
