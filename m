Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263810AbTKFVIV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 16:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263822AbTKFVIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 16:08:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:19094 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263810AbTKFVIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 16:08:19 -0500
X-Authenticated: #4512188
Message-ID: <3FAAB8B5.6060901@gmx.de>
Date: Thu, 06 Nov 2003 22:10:13 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031102
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: bill davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
References: <3FA69CDF.5070908@gmx.de> <3FA8C916.3060702@gmx.de> <20031105095457.GG1477@suse.de> <3FA8CA87.2070201@gmx.de> <boe68a$f3g$1@gatekeeper.tmr.com>
In-Reply-To: <boe68a$f3g$1@gatekeeper.tmr.com>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bill davidsen wrote:
> In article <3FA8CA87.2070201@gmx.de>,
> Prakash K. Cheemplavam <prakashkc@gmx.de> wrote:
> 
> | Sorry, I wasn't precise: The data is on the disc, as my DVD-ROM restores 
> | the full image (md5sum matches), but the CD-RW does not.
> 
> There is a problem with ide-scsi in 2.6, and rather than fix it someone
> came up with a patch to cdrecord to allow that application to work

I *didn't* use ide-scsi. I used ATAPI and I have to agree with Linus, 
that it is sane to use ATAPI, instead of wrapping things up. 
Nevertheless, there are some issues left, which need further investigation.

a) The as scheduler in 2.6-test9-mm2 behaves not as nicely as in mm1. 
(see other messeages in thread)

b) The writing or reading issue mentioned above. It is a bit hard to 
find out, whether cdrecord actually *writes* an incomplete image 
(without using -pad), ie. throwing away the last 4096 bytes, which 
*only* happens in non-TAO mode. The programme CDRDAO shows the same 
behaviour. Strange enough reading this DAO written image out with my 
DVD-ROM makes this (missing?) 4096 bytes reappear... Well, maybe I 
should patch the image and put some other bytes instead of the 00s at 
the end to see, whether it is a write issue, a read issue of the writer 
or a read issue of the reader. Anyway, it doesn't sound right to me, 
what is happening at the moment...

c) That scsi gets selected when using usbfs seams to be some sort of 
wrapper being used...(just guessing without actually knowing the code). 
WOuld be nice if a note in the kernel menuconfig or alike would be left 
so that one doesn't have to wonder... But IIRC usbfs will be dropped anyway.


Prakash

