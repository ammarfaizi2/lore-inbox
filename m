Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262603AbVAVABG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbVAVABG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 19:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbVAUX7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 18:59:50 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:27610 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262624AbVAUX6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:58:31 -0500
Subject: RE: How to add/drop SCSI drives from within the driver?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Mukker, Atul" <Atulm@lsil.com>
Cc: Matt Domsch <Matt_Domsch@Dell.com>,
       "'Salyzyn, Mark'" <mark_salyzyn@adaptec.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'brking@us.ibm.com'" <brking@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       "Ju, Seokmann" <sju@lsil.com>, "Doelfel, Hardy" <hdoelfel@lsil.com>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E5705A70B74@exa-atlanta>
References: <0E3FA95632D6D047BA649F95DAB60E5705A70B74@exa-atlanta>
Content-Type: text/plain
Date: Fri, 21 Jan 2005 15:58:14 -0800
Message-Id: <1106351894.5932.12.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-21 at 17:11 -0500, Mukker, Atul wrote:
> All right! The implementation is complete for this and the driver has
> thoroughly gone through testing. Everything looks good except for a minor
> glitch.

That's good news.

> After the new logical drives are created with "- - -" written to the
> scsi_host scan attribute, there is a highly noticeable delay before device
> names (e.g., sda) appears in the /dev directory. If the management
> application tried to access the device immediately after creating new, the
> access fails. Putting a 1 second delay helped, but of course this is not a
> deterministic solution.
> 
> What are the other possibilities?

Well, how about hotplug.  The device addition actually triggers a hot
plug event already (there's no need to add anything, it's done by the
mid-layer), so if you just listen for that, you'll know when the scan
has detected a device.

James


