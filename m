Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965210AbWBHWfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965210AbWBHWfg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 17:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965213AbWBHWfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 17:35:36 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:44969 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S965210AbWBHWfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 17:35:36 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43EA7226.60306@s5r6.in-berlin.de>
Date: Wed, 08 Feb 2006 23:35:18 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 7/8] don't mangle INQUIRY if cmddt or evpd bits are set
References: <E1F6vyJ-00009k-3Z@ZenIV.linux.org.uk>
In-Reply-To: <E1F6vyJ-00009k-3Z@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.742) AWL,BAYES_05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> Date: 1139425740 -0500
> 
> sbp2.c mangles INQUIRY response in a way that only applies to standard
> inquiry data (i.e. when both cmddt and evpd bits are 0).  Leave other cases
> alone; e.g. when asking for VPD the length of reply is in byte 3, not 4
> and byte 4 is the first byte of device serial number.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> ---
> 

I tested the patch with 8 different SBP-2 bridges, based on 6 or 7 
different bridge chips. Works for me.

In fact, not a single one of these bridges is affected by the code 
change since the additional expression which was added always evaluates 
true.

...
> -	switch (SCpnt->cmnd[0]) {
> -
> -	case INQUIRY:
> +	if (SCpnt->cmnd[0] == INQUIRY && (SCpnt->cmnd[1] & 3) == 0) {
>  		/*
>  		 * Make sure data length is ok. Minimum length is 36 bytes
>  		 */
...

-- 
Stefan Richter
-=====-=-==- --=- -=---
http://arcgraph.de/sr/
