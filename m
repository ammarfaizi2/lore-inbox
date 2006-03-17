Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752514AbWCQBdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbWCQBdV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 20:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752515AbWCQBdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 20:33:21 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:24397 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752514AbWCQBdV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 20:33:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Sgcy4c1mNUrfctJsDeMBLac/r7bvUrMjS5lYB9U29tWsHrUNxheAXisZH4JaJsalbhbTIwSM+ng3co3V4sG+ZrWeg8M5O4awXM9FEHawgtdUPpVENQ20oOOSMnQvQvAyySq6Q4DeMNCSD6QRVRZw19ENKtFTjaMvu7l0brJn8Lk=
Message-ID: <dda83e780603161733o10a3c330kddf96a726f162fa7@mail.gmail.com>
Date: Thu, 16 Mar 2006 17:33:17 -0800
From: "Bret Towe" <magnade@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: nfs udp 1000/100baseT issue
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0603162139450.11776@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <dda83e780603151424u1b3ea605vd6e8dea896fc276e@mail.gmail.com>
	 <Pine.LNX.4.61.0603162139450.11776@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >
> >a while ago i noticed a issue when one has a nfs server that has
> >gigabit connection
> >to a network and a client that connects to that network instead via 100baseT
> >that udp connection from client to server fails the client gets a
> >server not responding
> >message when trying to access a file, interesting bit is you can get a directory
> >listing without issue
> >work around i found for this is adding proto=tcp to the client side
> >and all works
> >without error
>
> UDP has its implications, like silently dropping packets when the link
> is full, by design. Try tcpdump on both systems and compare what packets
> are sent and which do arrive. The error message is then probably because
> the client is confused of not receiving some packets.

after compairing a working and not working client i found that
packets containing offset 19240, 20720, 22200 are missing
and the 100baseT client had an extra offset of 32560
on the working client it ends at 31080

the missing ones are mostly constantly missing 22200 appears every so often
on retransmission and 23680 also disappears every so often

i hope that isnt too confusing i dont use tcpdump type stuff much
(well i did give up on tcpdump and had to use ethereal...)

> >error message i see client side are as follows:
> >nfs: server vox.net not responding, still trying
> >nfs: server vox.net not responding, still trying
> >nfs: server vox.net not responding, still trying
>
>
> Jan Engelhardt
> --
>
