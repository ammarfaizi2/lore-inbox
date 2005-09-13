Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932637AbVIMMtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637AbVIMMtT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 08:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932642AbVIMMtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 08:49:19 -0400
Received: from magic.adaptec.com ([216.52.22.17]:23443 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932637AbVIMMtR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 08:49:17 -0400
Message-ID: <4326CAC6.3050202@adaptec.com>
Date: Tue, 13 Sep 2005 08:49:10 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: ltuikov@yahoo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
 (end devices)
References: <20050910024454.20602.qmail@web51613.mail.yahoo.com>	 <1126368081.4813.46.camel@mulgrave>  <4325997D.3050103@adaptec.com>	 <1126547565.4825.52.camel@mulgrave>  <4325E5AE.1080900@adaptec.com> <1126560191.4825.71.camel@mulgrave>
In-Reply-To: <1126560191.4825.71.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2005 12:49:16.0661 (UTC) FILETIME=[8CFC4A50:01C5B861]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/05 17:23, James Bottomley wrote:
> On Mon, 2005-09-12 at 16:31 -0400, Luben Tuikov wrote:
> 
>>On 09/12/05 13:52, James Bottomley wrote:
>>
>>>Well there is this in sas_discover.h:
>>>
>>>struct scsi_core_mapping {
>>>	int  channel;
>>>	int  id;
>>>};
>>>
>>>struct LU {
>>>[...]
>>>	struct scsi_core_mapping map;
>>>
>>>
>>>so if you use channel, id and scsilun_to_int() (or your SCSI_LUN
>>>reimplementation of that) on your LUN structure, you have everything
>>>necessary to interface to scsi_scan_target, yes.
>>>
>>>You have to have this, otherwise you wouldn't be able to use
>>>scsi_add_device in sas_scsi_host.c:sas_register_with_scsi().
>>>
>>>Based on this it does look like your refusal to use scsi_scan_target is
>>>based on ideological rather than technical objections.
>>
>>Hmm, no.
>>
>>Channel and id are assigned _after_ the device has been scanned for
>>LUs.  So I cannot just call scsi_scan_target() and say: "here is
>>this SCSI Domain device, I know nothing about, other than
>>the fact that it has a Target port, scan it".
> 
> 
> In your code channel corresponds to an index in the ports array of the
> host adapter and hence is known before you do any logical unit scanning.
> Id is assigned from a bitmap in the port.  You could do that assignment
> in sas_discover_end_dev() then you could use scsi_scan_target() in place
> of sas_do_lu_discovery().  It would also mitigate your bug below since
> now your id is one to one on the end devices rather than the logical
> units of the end devices, so each port would support up to 128 end
> devices rather than 128 logical units.

James, even Christoph understands this: no HCIL in SCSI Core is needed.
The whole problem is not what you *keep grinding about over and over above*,
but the fact that I have to _invent_ channel, id and emaciated LUN to give
to the broken, outdated and Parallel SCSI-centric SCSI Core.

Christoph understand this, why cannot you?

That bitmap was added in the last moment when I needed to register devices
with SCSI Core.  There is a lot of other problems which I've pointed out
int the scsi glue file, which do you not want to talk about or you do
not bring up.

Concentrate on SCSI Core, _not_ IDR.

I hope that by the time people start plugging in hardware with more
than one LU into a SAS domain, SCSI Core's new part would not need
HCIL.  Currently SAS hardware is scarce at best.

	Luben
