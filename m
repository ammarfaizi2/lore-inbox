Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965059AbWDNAJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbWDNAJL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 20:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbWDNAJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 20:09:10 -0400
Received: from ns2.suse.de ([195.135.220.15]:5591 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965059AbWDNAJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 20:09:09 -0400
Message-ID: <443EE817.5000404@suse.com>
Date: Thu, 13 Apr 2006 20:08:55 -0400
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 01/08] idr: add idr_replace method for replacing pointers
References: <20060413203546.GA3170@locomotive.unixthugs.org> <20060413150527.0028bc88.akpm@osdl.org>
In-Reply-To: <20060413150527.0028bc88.akpm@osdl.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton wrote:
> Jeff Mahoney <jeffm@suse.com> wrote:
>> +/**
>> + * idr_replace - replace pointer for given id
>> + * @idp: idr handle
>> + * @ptr: pointer you want associated with the ide
>> + * @id: lookup key
>> + *
>> + * Replace the pointer registered with the id.  A -ENOENT
>> + * return indicates that @id was not found.
>> + *
>> + * The caller must serialize vs idr_find(), idr_get_new(), and idr_remove().
>> + */
>> +int idr_replace(struct idr *idp, void *ptr, int id)
> 
> I'd have thought it would be more flexible were this to return the old
> pointer.
> 
> If there was no old item, we could return NULL and "succeed".  But that gets
> a bit ill-defined, because lack of an old pointer can occur if either a)
> there was a layer, but the slot was empty or b) there wasn't a layer for
> this new item.  So perhaps it's best to continue considering lack of an old
> pointer as an error, with ERR_PTR(-ENOENT).

Sure, I'll make those changes now.

- -Jeff


- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFEPugXLPWxlyuTD7IRAswwAJ0XVEBu/kRp4RNcW3JNeNRTqCYEowCfR01q
0hPOY5g0V8WEaOU8lWBfG/U=
=iJrK
-----END PGP SIGNATURE-----
