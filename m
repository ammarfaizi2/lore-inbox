Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269424AbUJWBYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269424AbUJWBYX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 21:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269340AbUJWBU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 21:20:56 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:64568 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269558AbUJWAec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:34:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=rqQ/zxxkfgK138+3q7SXwSTMJtLS+pzD0pqyEmkJ1DVdLoUPPBbKUnZ0tDWNhOZ+4axHokOffEnnV3MJC8hI4YcWAqMWZGGDtKyoAlZBqSoNxcSGFrPxVv/aKSEWqVbxA02aQeWqXmpLCxcX3sRo3YOjjqM6DKz+I/5UsoMEDTY=
Message-ID: <58cb370e041022173465c22894@mail.gmail.com>
Date: Sat, 23 Oct 2004 02:34:28 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: pdc202xx_old broke boot [was Re: 2.6.9-mm1]
Cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bartlomiej Zolnierkiewicz <b.zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <20041022172100.183f9fe1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041022032039.730eb226.akpm@osdl.org>
	 <1098490330l.28166l.0l@werewolf.able.es>
	 <20041022172100.183f9fe1.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004 17:21:00 -0700, Andrew Morton <akpm@osdl.org> wrote:
> "J.A. Magallon" <jamagallon@able.es> wrote:
> >
> > Hi all...
> >
> > On 2004.10.22, Andrew Morton wrote:
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9/2.6.9-mm1/
> > >
> >
> > I upgraded from 2.6.9-rc3-mm3 to 2.6.9-mm1 and the system coould not boot.
> > What was before hde now was hda (guess ? root is on hde1...)
> 
> yikes.  Perhaps the PCI scanning order was changed?

Fortunately, not. :)

What happened is that ide-dev-2.6 tree contains a patch which ignores
BIOS settings for Promise controllers but ide-dev-2.6 tree is not in
2.6.9-mm1 (due to syncing with -linus -> temporary breakage).

> > How can I restore the old behaviour ? Plain 2.6.9 booted. So reconfiguring
> > fstab to say / == hda1 will make impossible switch between kernels ...

In 2.6.9-mm1 CONFIG_PDC202XX_FORCE option can also be used
for pdc202xx_old but pdc202xx_new must be enabled (yes it a bug).

> > Better, can I force ide0=via, for any kernel I boot ?

"magic" kernel options is not an answer, initrd+udev is

Bartlomiej
