Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbWDBR7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWDBR7r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 13:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWDBR7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 13:59:47 -0400
Received: from wproxy.gmail.com ([64.233.184.228]:24739 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932401AbWDBR7q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 13:59:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l4Iu+bi+DZyPNJxPHYITcs6RDGil7IeVTc3rv3QgUBTnie9bTBUNVZbW1BdKtKy5K+rB8EUwajvY+O8Ty+Uyte16CiMSN7AgIwN4NhSjNpBp3RuAfpAc8XSpU/jpNZS7ltwoTXCj48FvfuwuLFoFrSr+TVBSR+SzMHZp2rh4Cco=
Message-ID: <311601c90604021059jcdf56e4ja35e3507ab291179@mail.gmail.com>
Date: Sun, 2 Apr 2006 11:59:45 -0600
From: "Eric D. Mudama" <edmudama@gmail.com>
To: "Dan Aloni" <da-x@monatomic.org>
Subject: Re: sata_mv: module reloading doesn't work
Cc: "Linux Kernel List" <linux-kernel@vger.kernel.org>,
       "Jeff Garzik" <jgarzik@pobox.com>, "Mark Lord" <lkml@rtr.ca>,
       "IDE/ATA development list" <linux-ide@vger.kernel.org>
In-Reply-To: <20060402155647.GB20270@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060402155647.GB20270@localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/06, Dan Aloni <da-x@monatomic.org> wrote:
> Hello,
>
> I'm testing the sata_mv driver to see whether reloading (rmmod
> - insmod) works, and it seems something is broken there. The
> first insmod goes okay - however all the insmods that follow
> emit error=0x01 { AddrMarkNotFound } and status=0x50 { DriveReady
> SeekComplete } from all the drives.

More to Jeff/Mark etc... wouldn't this be expected?  0x50/0x01 is the
contents of a reset signature FIS.  If the module was removed, and
upon insmod the bus came back up, the drive would complete ASR or
COMRESET processing and post a signature FIS.  Is the phy disabled
when sata_mv is removed?
