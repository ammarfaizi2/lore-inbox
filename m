Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751730AbVLAW4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbVLAW4T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 17:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbVLAW4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 17:56:19 -0500
Received: from mail29.messagelabs.com ([140.174.2.227]:13732 "HELO
	mail29.messagelabs.com") by vger.kernel.org with SMTP
	id S1751709AbVLAW4S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 17:56:18 -0500
X-VirusChecked: Checked
X-Env-Sender: Scott_Kilau@digi.com
X-Msg-Ref: server-31.tower-29.messagelabs.com!1133477763!9705347!1
X-StarScan-Version: 5.5.9.1; banners=-,-,-
X-Originating-IP: [66.77.174.21]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Re: 2.6.15-rc3-mm1
Date: Thu, 1 Dec 2005 16:59:28 -0600
Message-ID: <335DD0B75189FB428E5C32680089FB9F36B343@mtk-sms-mail01.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: 2.6.15-rc3-mm1
Thread-Index: AcX2yuG9aCL9sPLCRu+guw7G9nsBOQ==
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Christoph Hellwig" <hch@infradead.org>, <benh@kernel.crashing.org>,
       "Ananda K Venkataraman" <avenkat@us.ibm.com>
X-OriginalArrivalTime: 01 Dec 2005 22:59:28.0923 (UTC) FILETIME=[E23A5EB0:01C5F6CA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Fri, Dec 02, 2005 at 08:10:59AM +1100, Benjamin Herrenschmidt
wrote:
> > On Thu, 2005-12-01 at 11:31 +0000, Christoph Hellwig wrote:
> > On Thu, Dec 01, 2005 at 10:18:25AM +1100, Benjamin Herrenschmidt
wrote:

> > Hrm... ok, well, we have a board here based on Exar chips that can
be
> > driven by the "jsm" driver but it also works fine with 8250...

> ok, then there's probably a dumb mode aswell :)

Hi Christoph, all,

This is true.

There is a 8250 "legacy" mode with this Exar chip, but they have
also tossed in a bunch of extra UART "features" to make the product
almost quasi-intelligent.

The JSM driver attempts to use these features as much as possible,
which does happen to "abuse" the tty interface in an attempt to get
serial throughput to 921K against all 8 ports bidirectionally.

Using the old flip buffers (not the *new* Alan Cox stuff!) would
Limit throughput to about 460K against all 8 ports bidirectionally.

The "abuse" was to avoid using flip buffers if the driver can do
so, and calling the ld's receive_buf function directly, rather
than having the flip buffers do it.

This method was (and still is) being used by other serial drivers
in the kernel, under a long-ago made comment by Theodore Tso that
it was valid to do so.

I agree that all this confusing and "abusive" logic can go away
now, now that Alan has changed the old tty flip stuff.
(Thanks Alan! It was VERY much needed!)

IBM is working on a patch to yank all this unneeded logic out
as we speak.

BTW,
Is there any timeframe when the Alan Cox flip buffer/tty change will
make it from mm into the stock kernel?

Thanks!
Scott Kilau
