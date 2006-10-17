Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWJQSOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWJQSOY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWJQSOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:14:24 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:43440 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1750755AbWJQSOX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:14:23 -0400
From: Ismail Donmez <ismail@pardus.org.tr>
Organization: TUBITAK/UEKAE
To: Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: Linux ISO-9660 Rock Ridge bug needs fix
Date: Tue, 17 Oct 2006 21:14:29 +0300
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org,
       Joerg Schilling <schilling@fokus.fraunhofer.de>
References: <20061017180210.GA20287@dreamland.darkstar.lan>
In-Reply-To: <20061017180210.GA20287@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610172114.30268.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

17 Eki 2006 Sal 21:02 tarihinde, Luca Tettamanti şunları yazmıştı: 
> Ismail Donmez <ismail@pardus.org.tr> ha scritto:
> >> while working on better ISO-9660 support for the Solaris Kernel,
> >> I recently enhanced mkisofs to support the Rock Ridge Standard version
> >> 1.12 from 1994.
> >>
> >> The difference bewteen version 1.12 and 1.10 (this is what previous
> >> mkisofs versions did implement) is that the "PX" field is now 8 Byte
> >> bigger than before (44 instead of 36 bytes).
> >
> > Is there a test iso file somewhere? I think the attached *untested* patch
> > will fix it.
>
> I was also looking at this ;) I cannot reproduce the failure even with
> images generated with the new version of mkisofs (I actually _see_ that
> PX record size is changed, but isofs doesn't seem to care...).
>
> > diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
> > index f3a1db3..061a633 100644
> > --- a/fs/isofs/rock.c
> > +++ b/fs/isofs/rock.c
> > @@ -349,6 +349,7 @@ #endif
> >                         inode->i_nlink = isonum_733(rr->u.PX.n_links);
> >                         inode->i_uid = isonum_733(rr->u.PX.uid);
> >                         inode->i_gid = isonum_733(rr->u.PX.gid);
> > +                       inode->i_ino = isonum_733(rr->u.PX.ino);
> >                         break;
>
> I don't think it's correct. When reading disk with old format i_ino will
> be filled with garbage.
> Now, who is in charge of isofs?

I was just trying a fast hack to see it works ;-) but iso files produced by 
latest mkisofs works fine even without patching.

Regards,
ismail
