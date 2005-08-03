Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbVHCRTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbVHCRTd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 13:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbVHCRTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 13:19:32 -0400
Received: from nproxy.gmail.com ([64.233.182.203]:34297 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262357AbVHCRTc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 13:19:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JXdGy7YdSy7pCJqb0ue/fX8lkC8DybG4HQx8MFTutOdoFM4mQDfctk9xOtQRhd/uVekQbsHA191CMBmPeeLpH+zuLbslW0jo7LyBtqHJLOUQ5U78ZXdnh80dBXw/O/wWTn4IFeeUZsyhrxx2cf+UafoBheC7v3X1VviVYSqp+iM=
Message-ID: <58cb370e05080310195c244f72@mail.gmail.com>
Date: Wed, 3 Aug 2005 19:19:30 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Andre Hedrick <andre@linux-ide.org>
Subject: Re: [PATCH] IDE disks show invalid geometries in /proc/ide/hd*/geometry
Cc: Mark Bellon <mbellon@mvista.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <Pine.LNX.4.10.10508030018390.21865-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42EFE547.3010206@mvista.com>
	 <Pine.LNX.4.10.10508030018390.21865-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The topic was discussed to death on linux-kernel.

Mark, you need to fix your applications and stop using /proc/ide/hd*/geometry
or/and HDIO_GET_GEO ioctl (which BTW your patch also affects).

Bartlomiej

On 8/3/05, Andre Hedrick <andre@linux-ide.org> wrote:
> 
> Did you read ATA-1 through ATA-7 to understand all the variations?
> 
> On Tue, 2 Aug 2005, Mark Bellon wrote:
> 
> > The ATA specification tells large disk drives to return C/H/S data of
> > 16383/16/63 regardless of their actual size (other variations on this
> > return include 15 heads and/or 4092 cylinders). Unfortunately these CHS
> > data confuse the existing IDE code and cause it to report invalid
> > geometries in /proc when the disk runs in LBA mode.
> >
> > The invalid geometries can cause failures in the partitioning tools;
> > partitioning may be impossible or illogical size limitations occur. This
> > also leads to various forms of human confusion.
> >
> > I attach a patch that fixes this problem while strongly attempting to
> > not break any existing side effects and await any comments.
> >
> > mark
> >
> > Signed-off-by: Mark Bellon <mbellon@mvista.com>
> >
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
