Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWCWJlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWCWJlX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 04:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWCWJlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 04:41:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:16520 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751186AbWCWJlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 04:41:23 -0500
Subject: Re: [RFC PATCH 35/35] Add Xen virtual block device driver.
From: Arjan van de Ven <arjan@infradead.org>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       xen-devel@lists.xensource.com, ian.pratt@cl.cam.ac.uk,
       linux-kernel@vger.kernel.org, Ian Pratt <m+Ian.Pratt@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>
In-Reply-To: <a15cee148267ad7406a077c28c0c97ac@cl.cam.ac.uk>
References: <A95E2296287EAD4EB592B5DEEFCE0E9D4B9E8A@liverpoolst.ad.cl.cam.ac.uk>
	 <1143101972.3147.11.camel@laptopd505.fenrus.org>
	 <a15cee148267ad7406a077c28c0c97ac@cl.cam.ac.uk>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 10:41:12 +0100
Message-Id: <1143106872.3147.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well, that's plausible. We probably don't need IDE *and* SCSI faking. 
> We'd like to at least keep SCSI faking,

that's still unacceptable. Unless you start using the scsi layer and
really ARE scsi. 
but faking to be something you're not is not how you do things in linux.
Putting junk in the kernel because otherwise an open source installer
needs 3 extra lines... No Thanks(tm)

I would also recommend against going the full scsi-over-the-virtual-wire
mode. Xen is Xen *because* you don't need to go to a hardware level and
back on the other side. That's one of the reasons it's faster than full
virtualization. Don't throw away your advantages because you think it's
hard to add 3 lines to an open source project.

And the other consideration is this: SCSI is a complex spec. Doing a
half-emulation of that is actually worse than doing something fully on
your own. But if you want to go all the way.. that's imo way too much
overhead. You are not scsi. 

(And if someone really wants scsi in Xen, they already can use iSCSI as
protocol, no need to reinvent that wheel)


