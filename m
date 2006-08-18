Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWHRPcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWHRPcE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 11:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWHRPcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 11:32:04 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:58694 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751401AbWHRPcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 11:32:02 -0400
In-Reply-To: <200608180144.19149.arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH 02/13] IB/ehca: includes
To: abergman@de.ibm.com
Cc: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, Marcus Eder <MEDER@de.ibm.com>,
       openib-general@openib.org, Roland Dreier <rolandd@cisco.com>
X-Mailer: Lotus Notes Release 7.0 HF242 April 21, 2006
Message-ID: <OFED0915E4.3CED6795-ONC12571CE.0053ECB8-C12571CE.0055546A@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Fri, 18 Aug 2006 17:35:54 +0200
X-MIMETrack: Serialize by Router on D12ML067/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 18/08/2006 17:35:54
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


abergman

> > +#define EDEB_P_GENERIC(level,idstring,format,args...) \
>
> These macros are responsible for 61% of the object code size of your
module.
> ...Please get rid of that crap entirely and replace
> it with dev_info/dev_dbg/dev_warn calls where appropriate!
>
>    Arnd <><

we'll change these EDEBs to a wrapper around dev_err, dev_dbg and dev_warn
as it's done in the mthca driver.
All EDEB_EN and EDEB_EX will be removed, that type of tracing can be done
if needed by kprobes.
There are a few cases where we won't get to a dev, for these few places
we'll use a simple wrapper around printk, as done in ipoib.

Hope that's the "official" way how to implement it in ib drivers.


Gruss / Regards . . . Christoph R

