Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWGQSiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWGQSiE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 14:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWGQSiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 14:38:03 -0400
Received: from ns2.suse.de ([195.135.220.15]:39604 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751142AbWGQSiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 14:38:02 -0400
Message-ID: <44BBD942.3080908@suse.com>
Date: Mon, 17 Jul 2006 14:38:58 -0400
From: Jeff Mahoney <jeffm@suse.com>
Organization: SUSE Labs, Novell, Inc
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
Cc: 7eggert@gmx.de, Eric Dumazet <dada1@cosmosbay.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] reiserfs: fix handling of device names with /'s in them
References: <6xQ4C-6NB-43@gated-at.bofh.it> <6xQea-6ZX-13@gated-at.bofh.it> <E1G1QFx-0001IO-K6@be1.lrz> <44B7D97B.20708@suse.com> <44B9E6D5.2040704@namesys.com> <44BA61A2.5090404@suse.com> <44BA8214.7040005@namesys.com> <44BABB14.6070906@suse.com> <44BAE619.9010307@namesys.com> <44BAECE2.8070301@suse.com> <44BAFDC3.7020301@namesys.com> <44BB0146.7080702@suse.com> <44BB3C42.1060309@namesys.com> <44BBA4CF.8020901@suse.com> <44BBD4B6.5020801@namesys.com>
In-Reply-To: <44BBD4B6.5020801@namesys.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hans Reiser wrote:
> Jeff Mahoney wrote:
> 
>> Hans Reiser wrote:
>>
>>> I don't understand your patch and cannot support it as it is written.  
>>> Perhaps you can call me and explain it on the phone.
>>
>> I seriously can't tell if you're deliberately trying to be difficult or
>> not. It's a simple "replace / with ! before sending the name to procfs."
>>
>> Reiserfs requests that a procfs directory called
>> /proc/fs/reiserfs/<blockdev> be created. Some block devices contain
>> slashes, so with cciss/c123 it attempts to create a directory called
>> /proc/fs/reiserfs/cciss/c123, but cciss/ doesn't exist, shouldn't, and
>> never will.
> 
> Why not check to see if it does not exist, and create it if not,  as
> needed,  and skip the !'s....?

1) Because then the behavior of /proc/fs/reiserfs/ would be
inconsistent. Devices that contain slashes end up being one level deeper
than other devices, which is silly and a userspace visible change. Tools
that wish to parse the information would then need added complexity to
traverse into the next level to reach that information.

2) The block-device-as-path-name-component behavior is already defined
by sysfs (/sys/block), and it should be consistent.

- -Jeff

- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEu9lCLPWxlyuTD7IRAjeSAJ43f0SU1g4oivcUaFHQnnIPS89VMQCgkYu/
8S3Qi0cM7mKuwhp9W51JjsY=
=EXCL
-----END PGP SIGNATURE-----
