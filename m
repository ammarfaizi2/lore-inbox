Return-Path: <linux-kernel-owner+w=401wt.eu-S965354AbXATT7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965354AbXATT7O (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 14:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965361AbXATT7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 14:59:14 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:7659 "EHLO
	pd3mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965354AbXATT7N (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 14:59:13 -0500
Date: Sat, 20 Jan 2007 13:59:07 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA exceptions with 2.6.20-rc5
In-reply-to: <1169305408.4199.3.camel@pi.pomac.com>
To: pomac@vapor.com
Cc: Linux-kernel@vger.kernel.org, jeff@garzik.org, B.Steinbrink@gmx.de,
       s0348365@sms.ed.ac.uk, chunkeey@web.de
Message-id: <45B2748B.4060106@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <1169305408.4199.3.camel@pi.pomac.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kumlien wrote:
> Hi,
> 
> I went from 2.6.19+sata_nv-adma-ncq-v7.patch, with no problems and adama
> enabled, to 2.6.20-rc5, which gave me problems almost instantly.
> 
> I just thought that it might be interesting to know that it DID work
> nicely.
> 
> CC since i'm not on the ml
> 

(I'm ccing more of the people who reported this)

Well that's interesting.. The only significant change that went into 
2.6.20-rc5 in that driver that wasn't in that version you mentioned was 
this one:

http://www2.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=2dec7555e6bf2772749113ea0ad454fcdb8cf861

Could you (or anyone else) test what happens if you take the 2.6.20-rc5 
version of sata_nv.c and try it on 2.6.19? That would tell us whether 
it's this change or whether it's something else (i.e. in libata core).

Assuming that still doesn't work, can you then try removing these lines 
from nv_host_intr in 2.6.20-rc5 sata_nv.c and see what that does?

	/* bail out if not our interrupt */
	if (!(irq_stat & NV_INT_DEV))
		return 0;

as that's the difference I'm most suspicious of causing the problem.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

