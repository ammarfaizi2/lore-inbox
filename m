Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWDWRG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWDWRG6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 13:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWDWRG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 13:06:58 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:6070 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751430AbWDWRG6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 13:06:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L5/yKxOSaBxZ19ZAhwZgGzbgHGVNAny7YPHO6A5z3dfsQCVqKm+l3tiAB1cLJl1mjliwL4pFSyZ+U0+PX3eF5Up8Q6crVSMfXf8a6eWxJT5wgKr8Dy4OimR2LvXJstf/TsoXuSmmJyxTCPl+ifJqZ9kMQHtRs8V0EIjZowY9ap8=
Message-ID: <cda58cb80604231006x4911598bg6c1e3d62f07d80e7@mail.gmail.com>
Date: Sun, 23 Apr 2006 19:06:57 +0200
From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
To: "Nicolas Pitre" <nico@cam.org>
Subject: Re: How can I prevent MTD to access the end of a flash device ?
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0511221042560.6022@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <cda58cb80511070248o6d7a18bex@mail.gmail.com>
	 <cda58cb80511220658n671bc070v@mail.gmail.com>
	 <Pine.LNX.4.64.0511221042560.6022@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas,

2005/11/22, Nicolas Pitre <nico@cam.org>:
> On Tue, 22 Nov 2005, Franck wrote:
>
> > Hi,
> >
> > I have two questions that I can't answer by my own. I tried to look at
> > FAQ and documentation on MTD website but found no answer.
>
> Please consider using the MTD mailing list next time (you certainly read
> about it on the MTD web site).
>
> > First question is about size of flash. I have a Intel strataflash
> > whose size is 32MB but because of a buggy platform hardware I can't
> > access to the last 64KB of the flash. How can I make MTD module aware
> > of this new size. The restricted map size is initialized by my driver
> > but it doesn't seem to be used by MTD.
>
> The easiest thing to do is to define MTD partitions, the last one being
> the excluded flash area.
>

I hope you don't mind if I continue this thread 5 months later...I put
this issue in my TODO list and now I really need to fix it.

Your advice seems fine, but it brings some restrictions on flash
concatenations: for example, if I have 2 flashes of 32Mbytes, I need
to create 2 partitions whose sizes are 32M - 64K bytes but then I
can't concatenate these two partitions anymore since concatenation
works with mtd devices, not partitions, does it ?

It seems easier to simply probe the flash, then check for its size and
eventually restrict the end of it if needed:

        *mtd = do_map_probe("xxx_probe", map);
        while (mtd->size > 32Mb - 64Kb)
                (*mtd)->size -= (*mtd)->erasesize;

But I don't know if the MTD layer allows this kind of operation, do you ?

Thanks
--
               Franck
