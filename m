Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262811AbSJaU4m>; Thu, 31 Oct 2002 15:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262906AbSJaU4m>; Thu, 31 Oct 2002 15:56:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8714 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262811AbSJaU4l>;
	Thu, 31 Oct 2002 15:56:41 -0500
Message-ID: <3DC19A4C.40908@pobox.com>
Date: Thu, 31 Oct 2002 16:02:04 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: What's left over.
References: <Pine.LNX.4.44.0210310918260.1410-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>	In particular when it comes to this project, I'm told about
>	"netdump", which doesn't try to dump to a disk, but over the net.
>	And quite frankly, my immediate reaction is to say "Hell, I
>	_never_ want the dump touching my disk, but over the network
>	sounds like a great idea".
>  
>

[yes, I realize the LKCD merge debate is over, bear with me :)]

I'm sort of in the middle on this issue:  The existence of netdump does 
not imply that disk dumps are a bad thing.

netdumps require a net dump server, and it is simply not realistic at 
all to assume that users seeing crashes will always have a netdump 
server set up in advance, or even have multiple machines to make that 
possible.  Disk dumps are valuable because their requirements are very 
low, and because of all the user-support reasons that Andrew Morton 
mentioned in this thread.

That said, I used to be an LKCD cheerleader until a couple people made 
some good points to me:  it is not nearly low-level enough to truly be 
of use in crash situations.  netdump can work if your interrupts are 
hosed/screaming, and various mid-layers are dying.  For LKCD to be of 
any use, it needs to _skip_ the block layer and talk directly to 
low-level drivers.

So, I think the stock kernel does need some form of disk dumping, 
regardless of any presence/absence of netdump.  But LKCD isn't there yet...

    Jeff



