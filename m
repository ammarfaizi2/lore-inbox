Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVEKI4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVEKI4q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 04:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVEKI4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 04:56:46 -0400
Received: from smtpout.azz.ru ([81.176.69.27]:21688 "HELO smtpout.azz.ru")
	by vger.kernel.org with SMTP id S261940AbVEKIyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 04:54:55 -0400
Message-ID: <4281C8A3.20804@vlnb.net>
Date: Wed, 11 May 2005 12:56:03 +0400
From: Vladislav Bolkhovitin <vst@vlnb.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
CC: Sander <sander@humilis.net>, David Hollis <dhollis@davehollis.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ata over ethernet question
References: <1416215015.20050504193114@dns.toxicfilms.tv> <1115236116.7761.19.camel@dhollis-lnx.sunera.com> <1104082357.20050504231722@dns.toxicfilms.tv> <1115305794.3071.5.camel@dhollis-lnx.sunera.com> <20050507150538.GA800@favonius> <Pine.LNX.4.60.0505102352430.9008@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0505102352430.9008@poirot.grange>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski wrote:
> Hi
> 
> On Sat, 7 May 2005, Sander wrote:
> 
> 
>>David Hollis wrote (ao):
>>
>>>There seem to be a few iSCSI implementations floating around for
>>>Linux, hopefully one will be added to mainline soon. Most of those
>>>implementations are for the client side though there is at least one
>>>target implementation that allows you to provide local storage to
>>>iSCSI clients. I don't remember the name of it or if it's still
>>>maintained or not.
>>
>>Quite active even:
>>
>>http://sourceforge.net/projects/iscsitarget/
>>
>>The "Quick Guide to iSCSI on Linux" is a good starting point btw.
>>
>>Also check out http://www.open-iscsi.org/ (the client, aka 'initiator').
> 
> 
> A follow up question - I recently used nbd to access a CD-ROM. It worked 
> nice, but, I had to read in 7 CDs, so, each time I had to replace a CD, I 
> had to stop the client, the server, then replace the CD, re-start the 
> server, re-start the client... I thought about extending NBD to (better) 
> support removable media, but then you start thinking about all those 
> features that your local block device has that don't get exported over 
> NBD...
> 
> Now, my understanding (sorry, without looking at any docs - yet) is, that 
> iSCSI is (or at least should be) free from these limitations. So, does it 
> make any sense at all extending NBD or just switch to iSCSI? Should NBD be 
> just kept simple as it is or would it be completely superseeded by iSCSI, 
> or is there still something that NBD does that iSCSI wouldn't (easily) do?
> 
> Or am I completely misunderstanding what iSCSI target does?

Actually, this is property not of iSCSI target itself, but of any SCSI 
target. So, we implemented it as part of our SCSI target mid-level 
(SCST, http://scst.sourceforge.net), therefore any target driver working 
over it will automatically benefit from this feature. Unfortunately, 
currently available only target drivers for Qlogic 2x00 cards and for 
poor UNH iSCSI target (that works not too reliable and only with very 
specific initiators). The published version supports only real SCSI 
CDROMs. CDROM FILEIO module, which allows exporting ISO images as SCSI 
CDROM devices, going to be available not later end of May.

Vlad

> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

