Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262245AbSJOAtA>; Mon, 14 Oct 2002 20:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbSJOAtA>; Mon, 14 Oct 2002 20:49:00 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:42642 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262245AbSJOAs7>; Mon, 14 Oct 2002 20:48:59 -0400
Message-ID: <3DAB669B.3000801@us.ibm.com>
Date: Mon, 14 Oct 2002 17:51:39 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       LSE <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@zip.com.au>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [rfc][patch] Memory Binding API v0.3 2.5.41
References: <3DAB6385.9000207@us.ibm.com> <2005946728.1034617377@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>>>>4) An ordered zone list is probably the more natural mapping.
>>>>
>>>>See my comments above about per zone/memblk.  And you reemphasize my point, how do we order the zone lists in such a way that a user of the API can easily know/find out what zone #5 is?
>>>
>>>Could you explain how that problem is different from finding out
>>>what memblk #5 is ... I don't see the difference?
>>
>>Errm...  __memblk_to_node(5)
> 
> As opposed to creating __zone_to_node(5) ?
>  
>>I"m not saying that we couldn't add a similar interface for zones... something along the lines of:
>>	__memblk_and_zone_to_flat_zone_number(5, DMA)
>>or some such.  It just isn't there now...
> 
> Surely this would dispose of the need for memblks? If not, then
> I'd agree it's probably just adding more complication.
Well, since each node's memory (or memblk in the parlance of my head ;) 
has several 'zones' in it (DMA, HIGHMEM, etc), this conversion function 
will need 2 parameters.  It may well be called 
__node_and_zone_type_to_flat_zone_number(node, DMA|NORMAL|HIGHMEM).

Or, we could have:
__zone_to_node(5) = node #
and
__zone_to_zone_type(5) = DMA|NORMAL|HIGHMEM.

But either way, we would need to specify both pieces.

Cheers!

-Matt

