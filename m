Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263274AbTJQBTn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 21:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263275AbTJQBTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 21:19:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41946 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263274AbTJQBTl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 21:19:41 -0400
Message-ID: <3F8F439F.2010200@pobox.com>
Date: Thu, 16 Oct 2003 21:19:27 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jw schultz <jw@pegasys.ws>
CC: linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <20031016172930.GA5653@work.bitmover.com> <20031016174927.GB25836@speare5-1-14> <20031016230448.GA29279@pegasys.ws> <3F8F2A32.90101@pobox.com> <20031016235811.GE29279@pegasys.ws>
In-Reply-To: <20031016235811.GE29279@pegasys.ws>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz wrote:
>>Consider a simple key-value map, where "$hash $n" is the key and the 
>>value is the block of data.  Only three operations need occur:
>>* if hash exists (highly unlikely!), read and compare w/ raw data
>>* write new block to disk
>>* add single datum to key-value index
> 
> 
> Nicely described, but each block now needs a reference count
> which is incrmented if the raw compare yields a positive and
> decremented when a reference to it receives a write.

Yep.  I'm pondering a sort of a closely-interconnected distributed cache 
for archival storage, so I have to care about refcounts on remote 
servers, too.


> It may help to also have a reverse reference somewhere
> from the block to the hash.

I think I can avoid this...


>>Inode block lists would need to be updated regardless of any collision; 
>>that would be a standard and required part of any VFS interaction. And 
> 
> 
> Under current schemes if i overwrite an already allocated
> block of a file the block list need not be updated unless
> the block is relocated.  But that is a nit.

Yep.  For a networked filesystem, this is less annoying and clients will 
not normally notice any slowdown from this.

	Jeff



