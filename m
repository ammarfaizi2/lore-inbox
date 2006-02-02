Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWBBVKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWBBVKf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWBBVKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:10:35 -0500
Received: from hummeroutlaws.com ([12.161.0.3]:19219 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S1750868AbWBBVKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:10:34 -0500
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Thu, 2 Feb 2006 16:09:50 -0500
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Albert Cahalan <acahalan@gmail.com>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>, mrmacman_g4@mac.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       James@superbug.co.uk, j@bitron.ch
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060202210949.GD10352@voodoo>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Albert Cahalan <acahalan@gmail.com>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>, mrmacman_g4@mac.com,
	matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
	James@superbug.co.uk, j@bitron.ch
References: <43DDFBFF.nail16Z3N3C0M@burner> <1138642683.7404.31.camel@juerg-pd.bitron.ch> <43DF3C3A.nail2RF112LAB@burner> <1138710764.17338.47.camel@juerg-t40p.bitron.ch> <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail> <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo> <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com> <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/06 09:39:02PM +0100, Jan Engelhardt wrote:
> >
> >I'm seeing even worse behavior. Since /dev/hda is a disk with mounted
> >filesystems, my kernel refuses access even for root. Thus, even root
> >is unable to scan the /dev/hd* devices!
> >
> What sort of kernel patch do you have turned on? I'd be scared if I could 
> not even do a (read-only!) hexdump of my drive while mounted.
> 

I see the same thing with, the only external kernel patch I have
applied is Suspend2. The ATA scanbus code tries to 
open("/dev/hda", O_RDWR|O_NONBLOCK|O_EXCL) and that fails, and since
the scanning code stops once one device fails to open the whole scan
aborts. Apparently O_EXCL was added by Ubuntu and Debian to stop
burns being corrupted by hald polling the device while a disc is
being burned. If you want to read the entire thread it's bug #262678
in Debian.

Jim.
