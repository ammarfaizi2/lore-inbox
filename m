Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWD3CGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWD3CGM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 22:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWD3CGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 22:06:12 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:664 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750862AbWD3CGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 22:06:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=nKFc+aD/7+R4dfQ9uocOwYUDTDHe3Dex9IbKjyi87SO0etkP7v+Sx62zuhwM3YquOfCZ3CQTfQx+ardLgOXlFDsx/VyjsVQLvc68r+Q+isXMy5qFShyrDD/cAfYMkDTVq+mXkomj7m5iSzovc7dlzq25hhBoVlDOMK2c2ErQ5kI=  ;
Message-ID: <44541B91.3060104@yahoo.com.au>
Date: Sun, 30 Apr 2006 12:06:09 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Greaves <david@dgreaves.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com
Subject: Re: Bad page state in process 'nfsd' with xfs
References: <4452797F.70700@dgreaves.com>
In-Reply-To: <4452797F.70700@dgreaves.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Greaves wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> This was with 2.6.16.9
> 
> There's an nfs export from an xfs on an lvm on a raid5 on some
> libata/sata disks.
> (cc'ing xfs since I recall rumoured(?) badness in old nfs/xfs/md/lvm
> setups and xfs_sendfile is mentioned)
> 
> dmesg had:
> 
> Bad page state in process 'nfsd'
> page:b1602060 flags:0x80000008 mapping:00000000 mapcount:0 count:16777216
> Trying to fix it up, but a reboot is needed
> Backtrace:
>  [<b013bda2>] bad_page+0x62/0x90
>  [<b013c1c8>] prep_new_page+0x78/0x80

Looks like you have a bit flipped in 'count', which was not flipped
when the page was last freed. Probably buggy RAM.

Running memtest overnight might confirm that.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
