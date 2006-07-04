Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWGDK06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWGDK06 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 06:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWGDK06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 06:26:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:64093 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751261AbWGDK05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 06:26:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nLzo1TfHY4ZzBb5cQRfWuae6I3D8ilo8WeqrHB8V5WE9AKJCnG4Tb4mxnPb1BKpI4+N72Er0jJEhiT7uQXIxoSQxo9kNMgIhtCHyo9aShZHAuUI0rBKtorOnaQlGDnD1dHa14YnH0/ZfZ9yMgHeKE1nhxNEVMwCKQce/6STZQUg=
Message-ID: <41840b750607040326y7bfe92dy21c6845ab034ce30@mail.gmail.com>
Date: Tue, 4 Jul 2006 13:26:56 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: [Hdaps-devel] Generic interface for accelerometers (AMS, HDAPS, ...)
Cc: "Henrique de Moraes Holschuh" <hmh@debian.org>,
       "Stelian Pop" <stelian@popies.net>,
       "Michael Hanselmann" <linux-kernel@hansmi.ch>,
       hdaps-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
In-Reply-To: <20060704075950.GA13073@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060703124823.GA18821@khazad-dum.debian.net>
	 <20060704075950.GA13073@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/06, Pavel Machek <pavel@ucw.cz> wrote:
> Just use input infrastructure and be done with that? You can do
> parking from userspace.

Will moving the hdapsd userspace daemon from sysfs polling to the
input infrastructure cause a noticable latency increase compared to
polling sysfs? This functionality is highly time-critical.

Also, there's a small issue with polling frequency. hdapsd needs a
fairly high frequency (say, 50Hz) to gather statistics and keep
response latency low, whereas the hdaps driver's internal polling
(routing to the input infrastructure) is currently done at only 20Hz.
We'll need to increase the latter, thereby slightly increasing system
load when hdaps isn't running.

In terms of magnitude, an hdaps readout takes ~70usec on average and
(very rarely) up to ~1msec. This is with the tp_smapi [1] patches to
hdaps, which add the checks and retries needed to ensure the readout
is valid.

BTW, can the driver tell when nothing is accessing its input device,
and avoid polling in that case?

  Shem

[1] http://thinkwiki.org/wiki/tp_smapi
