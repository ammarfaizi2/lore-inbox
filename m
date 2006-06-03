Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWFCJMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWFCJMm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 05:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932597AbWFCJMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 05:12:42 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:33360 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932157AbWFCJMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 05:12:41 -0400
Message-ID: <44815283.7080306@tls.msk.ru>
Date: Sat, 03 Jun 2006 13:12:35 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
CC: Chris Wright <chrisw@sous-sol.org>, Jody McIntyre <scjody@modernduck.com>,
       Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [stable] [PATCH] sbp2: fix check of return value of	hpsb_allocate_and_register_addrspace
References: <tkrat.f195e45ae32b9c02@s5r6.in-berlin.de> <20060603013515.GV18769@moss.sous-sol.org> <44814A63.1080707@s5r6.in-berlin.de>
In-Reply-To: <44814A63.1080707@s5r6.in-berlin.de>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter wrote:
> Chris Wright wrote:
>> * Stefan Richter (stefanr@s5r6.in-berlin.de) wrote:
> ....
>>> +++ linux-2.6.17-rc5/drivers/ieee1394/sbp2.c    2006-06-03
>>> 01:54:23.000000000 +0200
>>> @@ -845,7 +845,7 @@ static struct scsi_id_instance_data *sbp
>>>             &sbp2_highlevel, ud->ne->host, &sbp2_ops,
>>>             sizeof(struct sbp2_status_block), sizeof(quadlet_t),
>>>             0x010000000000ULL, CSR1212_ALL_SPACE_END);
>>> -    if (!scsi_id->status_fifo_addr) {
>>> +    if (scsi_id->status_fifo_addr == ~0ULL) {

Umm.  Can this ~0ULL constant be #define'd to something?
It's way too simple to mis-read it as NULL (or ~NULL whatever).

I mean.. I looked at this change for quite some time, trying to
figure a difference (!x vs x==NULL), and thinking what's '-0'
(~ turned out to be quite similar to - in the font my thunderbird
uses).

/mjt
