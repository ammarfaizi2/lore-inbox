Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263197AbTJPXbP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 19:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263221AbTJPXbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 19:31:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20694 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263197AbTJPXbN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 19:31:13 -0400
Message-ID: <3F8F2A32.90101@pobox.com>
Date: Thu, 16 Oct 2003 19:30:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jw schultz <jw@pegasys.ws>
CC: linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <20031016172930.GA5653@work.bitmover.com> <20031016174927.GB25836@speare5-1-14> <20031016230448.GA29279@pegasys.ws>
In-Reply-To: <20031016230448.GA29279@pegasys.ws>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz wrote:
> Because each hash algorithm has different pathologies
> multiple hashes are generally better than one but their
> effective aggregate bit count is less than the sum of the
> separate bit counts.

I was coming to this conclusion too...  still, it's safer simply to 
handle collisions.


> The idea of this sort of block level hashing to allow
> sharing of identical blocks seems attractive but i wouldn't
> trust any design that did not accept as given that there
> would be false positives.  This means that a write would
> have to not only hash the block but then if there is a
> collision do a compare of the raw data.  Then you have to

yep


> add the overhead of having lists of blocks that match a hash
> value and reference counts for each block itself.  Further,
> every block write would then need to include, at minimum,
> relinking facilities on the hash lists and hash entry
> allocations plus the inode block list being updated. Finally

Consider a simple key-value map, where "$hash $n" is the key and the 
value is the block of data.  Only three operations need occur:
* if hash exists (highly unlikely!), read and compare w/ raw data
* write new block to disk
* add single datum to key-value index

Inode block lists would need to be updated regardless of any collision; 
that would be a standard and required part of any VFS interaction. And 
the internal workings of the key-value index (think Berkeley DB) are 
static, regardless of any collision.

	Jeff



