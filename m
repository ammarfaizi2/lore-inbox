Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVDYWG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVDYWG6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 18:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVDYWGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 18:06:45 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:7943 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S261257AbVDYWGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 18:06:09 -0400
Date: Tue, 26 Apr 2005 00:06:03 +0200
From: Olivier Galibert <galibert@pobox.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Avi Kivity <avi@argo.co.il>, linux-kernel@vger.kernel.org
Subject: Re: tcp_sendpage and page allocation lifetime vs. iscsi
Message-ID: <20050425220603.GA64842@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"David S. Miller" <davem@davemloft.net>,
	Avi Kivity <avi@argo.co.il>, linux-kernel@vger.kernel.org
References: <20050425170259.GA36024@dspnet.fr.eu.org> <426D40D4.8050900@argo.co.il> <20050425121953.6b5c3278.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425121953.6b5c3278.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 12:19:53PM -0700, David S. Miller wrote:
> Or, he could simply not try to reuse the private buffer he is
> giving to TCP.

'cept the buffer is managed by scsi/st.c, not the iscsi driver.  So
it's either changing the read/write buffer control rules scsi uses, or
systematically copying the data before sending.  Not that good
performance-wise, especially since most of the time tcp_sendpage does
not want to grab the page.

Do you think possible to extent the sendpage api to add some kind of
"don't get the pages, copy them if you need them" flag?

  OG.
