Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbWEPBWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbWEPBWE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 21:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWEPBWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 21:22:04 -0400
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:5263 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750983AbWEPBWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 21:22:02 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: unknown io writes in 2.6.16
Date: Tue, 16 May 2006 11:21:50 +1000
User-Agent: KMail/1.9.1
Cc: Mark Hedges <hedges@ucsd.edu>, dean gaudet <dean@arctic.org>
References: <20060510135100.F26270@network.ucsd.edu> <Pine.LNX.4.64.0605121012230.7292@twinlark.arctic.org> <20060515170943.P3338@network.ucsd.edu>
In-Reply-To: <20060515170943.P3338@network.ucsd.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605161121.50981.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 May 2006 10:12, Mark Hedges wrote:
> Cool, thanks, I'll check this out.  It's actually about 12k
> every 5 seconds, not 12 bytes. Seems excessive for atime
> updates.

That just sounds like the journal updating... the default journal time is 5 
seconds. Try transiently disabling the journal to see if that's it:

mount -o remount,noload /mountpoint

Don't forget to re-enable it afterwards.

You could set laptop mode if the writeouts are too frequent for your liking:

echo 1 > /proc/sys/vm/laptop_mode

-- 
-ck
