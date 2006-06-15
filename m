Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbWFOMkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbWFOMkn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 08:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbWFOMkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 08:40:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:22947 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030345AbWFOMkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 08:40:42 -0400
From: Andreas Schwab <schwab@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] affs_fill_super() %s abuses
References: <20060615110355.GH27946@ftp.linux.org.uk>
	<Pine.LNX.4.64.0606151427290.17704@scrub.home>
X-Yow: My polyvinyl cowboy wallet was made in Hong Kong by Montgomery Clift!
Date: Thu, 15 Jun 2006 14:40:40 +0200
In-Reply-To: <Pine.LNX.4.64.0606151427290.17704@scrub.home> (Roman Zippel's
	message of "Thu, 15 Jun 2006 14:31:05 +0200 (CEST)")
Message-ID: <jer71qa8xj.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> writes:

> Hi,
>
> On Thu, 15 Jun 2006, Al Viro wrote:
>
>> @@ -420,11 +422,17 @@ got_root:
>>  	}
>>  
>>  	if (mount_flags & SF_VERBOSE) {
>> -		chksum = cpu_to_be32(chksum);
>> -		printk(KERN_NOTICE "AFFS: Mounting volume \"%*s\": Type=%.3s\\%c, Blocksize=%d\n",
>> -			AFFS_ROOT_TAIL(sb, root_bh)->disk_name[0],
>> -			AFFS_ROOT_TAIL(sb, root_bh)->disk_name + 1,
>> -			(char *)&chksum,((char *)&chksum)[3] + '0',blocksize);
>> +		int len = AFFS_ROOT_TAIL(sb, root_bh)->disk_name[0];
>> +		char name[32];
>> +
>> +		if (len > 31)
>> +			len = 31;
>
> You get the same effect by changing it above into "min(AFFS_ROOT_TAIL(sb, 
> root_bh)->disk_name[0], 31)" and makes the copying unnecessary.

And "%*s" needs to be changed to "%.*s" (the former still requires a
NUL-terminated string).

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
