Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161025AbWBYQLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161025AbWBYQLt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 11:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161017AbWBYQLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 11:11:48 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:63699 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964774AbWBYQLr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 11:11:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GL2qh/Fh52IFKRHbeseXCvgJKsuRD9BgW/vXG6DV4BRVVgL5lV6kILlxBZrrxZOhIz2Wi/Lrx9aS//Tg3rEma0Xkhw5902a9mFaHmAFDO8iVOXLKXneBLqBH0DcBcLkGTSNjrQEfdY6MS7T88ZMM9Jt06qYZBW7m5MLqzTNaP00=
Message-ID: <9a8748490602250811t42629a73o7abbc2cb60a6c8f8@mail.gmail.com>
Date: Sat, 25 Feb 2006 17:11:46 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Justin Piszcz" <jpiszcz@lucidpixels.com>
Subject: Re: LibPATA code issues / 2.6.15.4
Cc: "Mark Lord" <lkml@rtr.ca>, "David Greaves" <david@dgreaves.com>,
       "Jeff Garzik" <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       "IDE/ATA development list" <linux-ide@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0602251058110.30688@p34>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0602140439580.3567@p34>
	 <43F2050B.8020006@dgreaves.com>
	 <Pine.LNX.4.64.0602141211350.10793@p34>
	 <200602141300.37118.lkml@rtr.ca>
	 <Pine.LNX.4.64.0602231838420.3374@p34> <44007892.9090002@rtr.ca>
	 <Pine.LNX.4.64.0602251058110.30688@p34>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/06, Justin Piszcz <jpiszcz@lucidpixels.com> wrote:

Please don't top-post.

> The kernel is patched, if you did not get what you wanted maybe the patch
> does not work in some instances or there is a bug?
>

You may have patched a kernel source with Mark's patch, but you are
very clearly not running a kernel build from that patched source.

As can be seen from (for example) this bit from Mark's patch

 translate_done:
-       printk(KERN_ERR "ata%u: translated ATA stat/err 0x%02x/%02x to "
-              "SCSI SK/ASC/ASCQ 0x%x/%02x/%02x\n", id, drv_stat, drv_err,
+       printk(KERN_ERR "ata%u: translated op=0x%02x ATA stat/err
0x%02x/%02x to "
+              "SCSI SK/ASC/ASCQ 0x%x/%02x/%02x\n", id, opcode,
drv_stat, drv_err,
              *sk, *asc, *ascq);

the patch changes the text being printed. In this case the text
"ata%u: translated ATA stat/err ..." is changed into "ata%u:
translated ATA stat/err ..."

And if we look at the output you posted :

> >> Here it is:
> >>
> >> [263864.109854] ata3: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ
> >> 0xb/00/00

That string is clearly from an un-patched kernel as Mark also pointed
out in his reply to you.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
