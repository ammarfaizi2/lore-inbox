Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279468AbRJXFbW>; Wed, 24 Oct 2001 01:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279469AbRJXFbN>; Wed, 24 Oct 2001 01:31:13 -0400
Received: from james.kalifornia.com ([208.179.59.2]:6779 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S279468AbRJXFbB>; Wed, 24 Oct 2001 01:31:01 -0400
Message-ID: <3BD65188.1060203@blue-labs.org>
Date: Wed, 24 Oct 2001 01:28:40 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011019
X-Accept-Language: en-us
MIME-Version: 1.0
To: Julian Anastasov <ja@ssi.bg>
CC: Tim Hockin <thockin@sun.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: issue: deleting one IP alias deletes all
In-Reply-To: <Pine.LNX.4.33.0110240042570.1210-100000@u.domain.uli>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually it is quite sane.  The tool is not.

Switch to 'ip' instead of 'ifconfig', several large distros now include 
it.  Addresses can be added and removed completely indiscriminately on 
interfaces.

The "ethN:X" is a legacy design that is now deprecated.

David

Julian Anastasov wrote:

>	Hello,
>
>Tim Hockin wrote:
>
>>If you have several IP aliases on an interface (eth0:0, eth0:1, eth0:2) you
>>get inconsistent behavior when downing them.
>>
>>* if I 'ifconfig down' eth0:1, I am left with eth0:0 and eth0:2
>>* if I 'ifconfig down' eth0:0, eth0:1 and eth0:2 go away, too
>>
>>I assert that this should not happen.  I have a simple patch to fix this
>>behavior, but I want to know a few things.
>>
>>* Is this supposed to happen? Why?
>>* Is it correct that both the real interface and the first alias are marked
>>as primary (! IFA_F_SECONDARY), while all other aliases are secondary?  It
>>
>
>	If you look again into the sources you can see that
>secondary addresses are those that are attached when there is
>already IP address from the same subnet. The aliases don't play
>here nor their number. The analyze points that the semantic
>covers the selection of source addresses (probably when you don't
>use preferred source address in your routes) and in some way they
>look as an IP address lookup and kernel routes handling
>optimizations. The other thing that I don't know is that may be
>there is some compatibility reasons for such secondary flag.
>
>>seems to me that ALL ALIASES should be secondary.  Is this wrong? Why?
>>
>
>	IMO, to keep the semantic of "attaching or detaching an IP
>address" clear and independent, all addresses should be primary
>because it is hard to keep correct setup when it is dynamicaly
>changed. There is already mechanism (the scope) to make one address
>"secondary" in the source address selection mechanism or even there
>is a preferred source to make it primary. This is my opinion but
>may be I'm missing some other usage. At least, the current handling
>looks very dangerous.
>
>Regards
>
>--
>Julian Anastasov <ja@ssi.bg>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


