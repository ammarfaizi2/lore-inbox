Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWBCC1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWBCC1M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 21:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWBCC1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 21:27:12 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:23572 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932141AbWBCC1L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 21:27:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G0YVYVzLOB+WlAKZciIkdq9vFJ5ZPivD8KrClbyqWavNjEZvRkZf3QByYdQsgadQrfVlPK73WnOz/oY2qTeNA99W0Fttt42rzodaTm8vJv6Vce+8CZNxOYslruWMTHoov0nrC+ZcOCDAneHMKrDjJ/0yi0KO4mXRd4sH3LPV7JA=
Message-ID: <787b0d920602021827m4890fbf4j24d110dc656d2d3a@mail.gmail.com>
Date: Thu, 2 Feb 2006 21:27:11 -0500
From: Albert Cahalan <acahalan@gmail.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de, mrmacman_g4@mac.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       James@superbug.co.uk, j@bitron.ch
In-Reply-To: <43E27792.nail54V1B1B3Z@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43DDFBFF.nail16Z3N3C0M@burner>
	 <1138710764.17338.47.camel@juerg-t40p.bitron.ch>
	 <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail>
	 <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo>
	 <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com>
	 <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr>
	 <20060202210949.GD10352@voodoo> <43E27792.nail54V1B1B3Z@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> "Jim Crilly" <jim@why.dont.jablowme.net> wrote:
>
> > I see the same thing with, the only external kernel patch I have
> > applied is Suspend2. The ATA scanbus code tries to
> > open("/dev/hda", O_RDWR|O_NONBLOCK|O_EXCL) and that fails, and since
>
> This is not cdrecord but a bastardized version......

True enough, but it would work great if you'd fix that bug
that makes cdrecord give up while scanning. I guess
that's one more patch Debian will be applying.

Using O_EXCL is kind of broken, because you'll need to
retry any failures, but that's life. You hacked cdrecord to
properly interact with the Solaris volume manager. You
can do the same for HAL.

Giving up while scanning is a problem for other reasons.
Let me introduce you to SE Linux. One can have RAWIO
capability, RT capability, mlock() capability, and still not
have the right to access all devices. You might not even
be able to get stat() to succeed, but you could burn a CD
if you use the correct device file.
