Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbUKDQ6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbUKDQ6Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 11:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262295AbUKDQ6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 11:58:25 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:31506 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262294AbUKDQ6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 11:58:23 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Germano <germano.barreiro@cyclades.com>, greg@kroah.com,
       Scott_Kilau@digi.com, linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <1099487348.1428.16.camel@tsthost>
	<20041104102505.GA8379@logos.cnet>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 04 Nov 2004 08:58:21 -0800
In-Reply-To: <20041104102505.GA8379@logos.cnet> (Marcelo Tosatti's message
 of "Thu, 4 Nov 2004 08:25:05 -0200")
Message-ID: <52fz3po8k2.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: patch for sysfs in the cyclades driver
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 04 Nov 2004 16:58:21.0558 (UTC) FILETIME=[7D8AD960:01C4C28F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Marcelo> The problem was class_simple only contains the "dev"
    Marcelo> attribute. You can't add other attributes to it.

I believe, based on the comment in class_simple.c:

  Any further sysfs files that might be required can be created using this pointer.

and the implementation in in drivers/scsi/st.c, that there's no
problem adding attributes to a device in a simple class.  You can just
use class_set_devdata() on your class_device to set whatever context
you need to get back to your internal structures, and then use
class_device_create_file() to add the attributes.

I assume this is OK (since there is already one in-kernel driver doing
it), but Greg, can you confirm that it's definitely OK for a driver to
use class_set_devdata() on a class_device from class_simple_device_add()?

Thanks,
  Roland
