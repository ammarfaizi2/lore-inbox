Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263267AbTJQBQW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 21:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbTJQBQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 21:16:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39386 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263267AbTJQBQV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 21:16:21 -0400
Message-ID: <3F8F42D6.7080808@pobox.com>
Date: Thu, 16 Oct 2003 21:16:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christopher Li <lkml@chrisli.org>
CC: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <20031016172930.GA5653@work.bitmover.com> <20031016174927.GB25836@speare5-1-14> <20031016230448.GA29279@pegasys.ws> <20031017004514.GA6279@64m.dyndns.org>
In-Reply-To: <20031017004514.GA6279@64m.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Li wrote:
>>The idea of this sort of block level hashing to allow
>>sharing of identical blocks seems attractive but i wouldn't
>>trust any design that did not accept as given that there
>>would be false positives.  This means that a write would
>>have to not only hash the block but then if there is a
>>collision do a compare of the raw data.  Then you have to
>>add the overhead of having lists of blocks that match a hash
>>value and reference counts for each block itself.  Further,
> 
> 
> Then write every data block will need to dirty at least 2 blocks.
> And it also need to read back the original block if hash exist.
> There must be some performance hit. 


In my case at least, we're talking about archival storage.  Plan9 uses a 
"write buffer" of 1-2GB or so, to mitigate performance loss, which seems 
reasonable.  With archival storage and hash indexes and such, you're 
certainly going to be dirtying more disk blocks than a traditional local 
filesystem would.

	Jeff



