Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWIYUu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWIYUu5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 16:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWIYUu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 16:50:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:23146 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751054AbWIYUuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 16:50:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=reB4vJ5icU7zxjDxBgLy+zbOzDmU2QgD0h/bSTHUqsqeL7cXxuXGBb+DmsJZJ6026TJ7ahmdGjfvfYKt8AcZHz10vLojetRNIAKiu5FyzYbEJvvGnhsRpXpu+jr6HnkkStuvg3SD2RCQlVNj52/GWrFSjaOGNf5rPnJEwpOsNyE=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Muli Ben-Yehuda <muli@il.ibm.com>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: mainline aic94xx firmware woes
Date: Mon, 25 Sep 2006 22:49:39 +0200
User-Agent: KMail/1.8.2
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20060925101124.GH6374@rhun.haifa.ibm.com>
In-Reply-To: <20060925101124.GH6374@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609252249.39446.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 September 2006 12:11, Muli Ben-Yehuda wrote:
> Hi,
> 
> The recently merged aic94xx in mainline requires external firmware
> support. This, in turn, necessitates an initrd/initramfs environment
> that includes firmware support to load the firmware. Will a patch to
> optionally include the firmware inline in the kernel and thus not
> having to use an initramfs be acceptable?
> 
> Also, aic94xx does not compile unless FW_LOADER is set in .config due
> to missing 'request_firmware'. What's the right thing to do here -
> aic94xx selecting it, depending on it, or FW_LOADER providing empty
> request_firmware() in case it's compiled out (the last one violates
> the principle of least surprise IMHO).

While we're at it, already existing aicXXXX driver continues to be
insanely large due to excessive inlining of I/O routines:

# x86_64-pc-linux-gnu-size aic7xxx.o
   text    data     bss     dec     hex filename
 118978   22673     568  142219   22b8b aic7xxx.o

This is not even helping performance one iota.
Call overhead for these routines pales in comparison
to I/O instruction stalls, which is in turn pales in comparison to
disk seek delays.

Please do something with it.
--
vda
