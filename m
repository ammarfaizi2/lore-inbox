Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264716AbTBETcZ>; Wed, 5 Feb 2003 14:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264730AbTBETcZ>; Wed, 5 Feb 2003 14:32:25 -0500
Received: from terminus.zytor.com ([63.209.29.3]:39400 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S264716AbTBETcY>; Wed, 5 Feb 2003 14:32:24 -0500
Message-ID: <3E4168F6.4000309@zytor.com>
Date: Wed, 05 Feb 2003 11:41:42 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Kasper Dupont <kasperd@daimi.au.dk>
CC: linux-kernel@vger.kernel.org
Subject: Re: isofs hardlink bug (inode numbers different)
References: <20030126235556.GA5560@paradise.net.nz> <b1nd5m$rhp$1@cesium.transmeta.com> <3E40F5DC.275FFE9D@daimi.au.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Dupont wrote:
>> 
>>Second: If there are files on the CD-ROM *without* RockRidge
>>attributes, you can get collisions with the synthesized inode numbers
>>for non-RR files.
>  
> That can easily be solved. RockRidge inode numbers are multiplied
> by two, and synthesized inode numbers are all odd. Of course if
> the multiplication overflows a fallback to synthesized inode
> numbers would be necesarry. Does any software produce inode
> numbers large enough to make this a problem?
> 

We have no idea, and we will never be able to know.  They certainly 
*CAN*... they are just anonymous 32-bit values.

> 
>>Third: If you actually rely on inode numbers to be able to find your
>>files, like most versions of Unix including old (but not current)
>>versions of Linux, then they are completely meaningless.
> 
> Agreed.
> 
>>There is another way to generate consistent inodes for hard links,
>>which is to use the data block pointer as the "inode number."  This,
>>however, has the problem that *ALL* zero-lenght files become "hard
>>links" to each other.
> 
> That problem can easily be solved. Simply use different methods
> for zero-length files and all other files. But there might be
> other problems with such an approach:
> 
> 1) Could two different files have same data block pointer?
>    (different sizes perhaps?)

Theoretically yes.

> 2) Do we need a way to find metadata from the inode number?

Currently we do, but we could rewrite the code not to.

	-hpa


