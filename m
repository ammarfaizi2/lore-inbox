Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVFFWFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVFFWFr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 18:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVFFWFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 18:05:47 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:5106 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261696AbVFFWF2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 18:05:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l61/0noLUoxHxK7n5a7VsJhPB9E5fh2wG1WlSxsoNKVwfQ34zxE/ZAu1Blu0Q6xZOnRP/ncV4z+SCgFy5oY9MGb5gVh0zZaLgOKQjbNksKmickkhCkQw5yghxdCXpxmpTh7jwXSNxXqdd1xDKywmvbpclmxoFNIx77u4Wf9Yj7g=
Message-ID: <4789af9e05060614585b319b1@mail.gmail.com>
Date: Mon, 6 Jun 2005 15:58:48 -0600
From: Jim Ramsay <jim.ramsay@gmail.com>
Reply-To: Jim Ramsay <jim.ramsay@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sata_promise driver and 2.6.11 on a MIPS board
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42A4B6D1.9010402@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4789af9e05060613394b1809c3@mail.gmail.com>
	 <42A4B6D1.9010402@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> Jim Ramsay wrote:
> > The driver then waits via a wait_for_completion apparently waiting for
> > the PCI card to throw an interrupt so it can continue.  However, I
> > never see this interrupt generated, and the driver code waits forever.
> 
> 
> This is a known bug that definitely needs fixing:
> 
> (to ATA developers)
> Any time an ATA command is issued outside of the SCSI layer, we need to
> employ a timer to time out commands.
> 
> Since most commands are done within the SCSI layer, which provides a lot
> of error handling apparatus, most commands properly time out.  The ones
> during probe - IDENTIFY DEVICE, set xfer mode, etc. - do not have such a
> timer.

So is this an issue with the sata_promise.c driver, or the
libata-core.c?  Which one should implement the timeout?

What would you suggest as a workaround or a proper fix?

-- 
Jim Ramsay
"Me fail English?  That's unpossible!"
