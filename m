Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262374AbVFINdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbVFINdS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 09:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVFINdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 09:33:18 -0400
Received: from CPE00095b3131a0-CM0011ae8cd564.cpe.net.cable.rogers.com ([70.29.53.229]:2435
	"EHLO kenichi") by vger.kernel.org with ESMTP id S262374AbVFINdQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 09:33:16 -0400
From: Andrew James Wade 
	<ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: BUG in i2c_detach_client
Date: Thu, 9 Jun 2005 09:32:59 -0400
User-Agent: KMail/1.7.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, "Greg KH" <greg@kroah.com>,
       "Mark M. Hoffman" <mhoffman@lightlink.com>
References: <JctXv2LZ.1118303243.5186830.khali@localhost>
In-Reply-To: <JctXv2LZ.1118303243.5186830.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506090932.59679.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mystery solved.

ERROR3:
	i2c_detach_client(data->lm75[1]); <-- HERE
	i2c_detach_client(data->lm75[0]);
	kfree(data->lm75[1]);
	kfree(data->lm75[0]);

The missing i2c_detach_client call meant that data->lm75[1] was still on
the list of i2c devices when it was freed. This was corrupting the list.
The ERROR3 path now works on my kernel.

Thanks for your help.
Andrew
