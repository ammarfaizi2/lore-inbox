Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbVJLVQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbVJLVQo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 17:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbVJLVQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 17:16:44 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:62575 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S932389AbVJLVQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 17:16:43 -0400
Message-ID: <434D7DD3.40706@suse.com>
Date: Wed, 12 Oct 2005 17:19:15 -0400
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
       Glauber de Oliveira Costa <glommer@br.ibm.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk, akpm@osdl.org
Subject: Re: [PATCH] Use of getblk differs between locations
References: <20051010204517.GA30867@br.ibm.com>  <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk>  <20051010214605.GA11427@br.ibm.com>  <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz>  <Pine.LNX.4.64.0510102319100.6247@hermes-1.csi.cam.ac.uk>  <Pine.LNX.4.62.0510110035110.19021@artax.karlin.mff.cuni.cz> <1129017155.12336.4.camel@imp.csi.cam.ac.uk> <434D6932.1040703@suse.com> <Pine.LNX.4.62.0510122155390.9881@artax.karlin.mff.cuni.cz> <434D6CFA.4080802@suse.com> <Pine.LNX.4.62.0510122208210.11573@artax.karlin.mff.cuni.cz> <Pine.LNX.4.64.0510122114140.9696@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.62.0510122221250.13771@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.62.0510122221250.13771@artax.karlin.mff.cuni.cz>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mikulas Patocka wrote:
>>> But discarding data sometimes on USB unplug is even worse than
>>> discarding data
>>> always --- users will by experimenting learn that linux doesn't discard
>>> write-cached data and reminds them to replug the device --- and one day,
>>> randomly, they lose their data because of some memory management
>>> condition...
>>
>> And how exactly is that worse than discarding the data every time?!?!?!?
> 
> Undeterministic behaviour is worse than deterministic. You can learn the
> system that behaves deterministically.
> 
> If you know that unplug damages filesystem on your USB disk, you replug
> it, recheck filesystem and copy the important data again --- you have 0%
> probability of data damage.
> However, if damage on unplug happens only with 1/100 probability, will
> you still check filesystem and copy all recently created files on it?
> You forget it (or you wouldn't even know that damage might occur) and
> you have 1% probability of data damage.

I agree that dependability is important, but so important that we keep
the absolute worst case scenario for all cases because it could happen
occasionally? We can warn the user that removing media without umounting
/ejecting it may cause data loss and prompt them to reinsert the media.
If they don't reinsert the media soon enough (for any reason, including
the availabilty of memory) we can inform them that data loss may have
occured and that they should attempt to recover the file system.

- -Jeff

- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDTX3TLPWxlyuTD7IRApliAJ4+8+OGhzKXlfkgx67lfDJioBeqngCgmF66
HOTsI39yyNUTL4H7KP9ZM38=
=WTcy
-----END PGP SIGNATURE-----
