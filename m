Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbTJRUdD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 16:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTJRUdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 16:33:03 -0400
Received: from pf138.torun.sdi.tpnet.pl ([213.76.207.138]:275 "EHLO
	centaur.culm.net") by vger.kernel.org with ESMTP id S261817AbTJRUdA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 16:33:00 -0400
From: Witold Krecicki <adasi@kernel.pl>
To: viro@parcelfarce.linux.theplanet.co.uk,
       Svetoslav Slavtchev <svetljo@gmx.de>
Subject: Re: initrd and 2.6.0-test8
Date: Sat, 18 Oct 2003 22:32:55 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org
References: <22900.1066504204@www30.gmx.net> <20031018192517.GD7665@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20031018192517.GD7665@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200310182232.55091.adasi@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia sob 18. pa¼dziernika 2003 21:25, viro@parcelfarce.linux.theplanet.co.uk 
napisa³:
> On Sat, Oct 18, 2003 at 09:10:04PM +0200, Svetoslav Slavtchev wrote:
> > me had  the same problems,
> > with devfs enabled
> >
> > could it be this (from Documentation/initrd)
> >
> > Note that changing the root directory does not involve unmounting it.
> >     the "normal" root file system is mounted. initrd data can be read
> >   root=/dev/ram0   (without devfs)
> >   root=/dev/rd/0   (with devfs)
> >     initrd is mounted as root, and the normal boot procedure is followed,
> >     with the RAM disk still mounted as root.
> >
> > the patch doesn't mention anything about /dev/rd/0 , but does for
> > /dev/ram0
>
> *Arrgh*
>
> Presense of devfs is, indeed, the problem.  /dev/rd/0 vs. /dev/ram0 is not
> an issue; visibility of /dev/initrd, OTOH, is - we have /dev of rootfs
> overmounted by devfs, so the thing becomes inaccessible.
>
> OK, that's trivially fixable.  We need to put the sucker outside of /dev,
> that's all.  Patch in a few...
What about situation when devfs is not mounted and even not used at all, and 
it is still not working?
-- 
Witold Krêcicki (adasi) adasi [at] culm.net
GPG key: 7AE20871
http://www.culm.net
