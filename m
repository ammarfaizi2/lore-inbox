Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946014AbWKJHqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946014AbWKJHqo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 02:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946015AbWKJHqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 02:46:44 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:49224 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1946014AbWKJHqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 02:46:43 -0500
In-Reply-To: <adaodrgb7uq.fsf@cisco.com>
Subject: Re: [openib-general] [PATCH 2.6.19 2/4] ehca: hcp_phyp.c: correct page
 mapping in 64k page mode
To: "Roland Dreier" <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openib-general@openib.org, openib-general-bounces@openib.org,
       "Paul Mackerras" <paulus@samba.org>
X-Mailer: Lotus Notes Release 7.0 HF277 June 21, 2006
Message-ID: <OF75FFAC00.E43450CA-ONC1257222.002A402A-C1257222.002AB9BD@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Fri, 10 Nov 2006 08:49:48 +0100
X-MIMETrack: Serialize by Router on D12ML067/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 10/11/2006 08:49:48
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Umm, so is this patch really needed?  Where did the patch come from --
> is it needed to fix something actually seen, or was it written just
> based on some theoretical understanding?
>
> I'm confused...
>
>  - R.
The patch is needed. We've seen it on the real system. We did fix it on the
real system.
...and it conforms to theory... although theory is a bit confusing here.

let me try to summarize:
ioremap checks for 64k boundary (actually page boundary)
nopage does H_ENTER in 4k granularity if it's configured like that for a
certain type of POWER processor.

so you have to adjust the ioremap to page boundary, and THEN access at the
offset within the 64k.

Took quite a while until we understood that code path.... ;-)

Christoph R.

