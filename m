Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270063AbUJEPvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270063AbUJEPvc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 11:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269998AbUJEPu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 11:50:59 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:5818 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S269454AbUJEPsV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 11:48:21 -0400
Message-ID: <4162C1DA.5000808@rtr.ca>
Date: Tue, 05 Oct 2004 11:46:34 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Mark Lord <lsml@rtr.ca>, Anton Blanchard <anton@samba.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Core scsi layer crashes in 2.6.8.1
References: <1096401785.13936.5.camel@localhost.localdomain>	<1096467125.2028.11.camel@m	ulgrave> 	<20041005114951.GD22396@krispykreme.ozlabs.ibm.com>	<1096984590.1765.2.camel@mulgrave>  <4162B345.9000806@rtr.ca> <1096988167.2064.7.camel@mulgrave>
In-Reply-To: <1096988167.2064.7.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
>
> This is expected behaviour.  For orderly removal an cache sync command
> must be sent to drives with a writeback cache before they're powered
> down.  For forced ejection, the driver has to error the command.

Yup, that's how it has to be done at present.

Another weirdness I ran into at one point, was that the mid-layer
could be made to segfault if a LLD asked it to remove a drive that
had previously been set "offline" -- it complains about an illegal
state transition during the removal, and then dies.  This sequence
no longer occurs in the QStor driver, but it might resurface soon
as more drivers begin to support hot insertion/removal.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
