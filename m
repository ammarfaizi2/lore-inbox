Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266210AbTBQDPQ>; Sun, 16 Feb 2003 22:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266298AbTBQDPQ>; Sun, 16 Feb 2003 22:15:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18448 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266210AbTBQDO4>;
	Sun, 16 Feb 2003 22:14:56 -0500
Message-ID: <3E5055EA.7080507@pobox.com>
Date: Sun, 16 Feb 2003 22:24:26 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Mark J Roberts <mjr@znex.org>
CC: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
Subject: Re: Annoying /proc/net/dev rollovers.
References: <20030216221616.GA246@znex> <20030217014111.GA2244@f00f.org> <20030217024605.GB246@znex>
In-Reply-To: <20030217024605.GB246@znex>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark J Roberts wrote:
> Chris Wedgwood:
>>>total_rx_bytes += rx_bytes;
>>
>>if lval is 64-bit, then this cannot be done reliably on all
>>architectures
> 
> 
> I'm not sure why. I realize that x86 can't do atomic 64-bit
> operations, but what I propose is to leave the 32-bit rx_bytes code
> the way it is, and just have some heuristic for updating the 64-bit
> value every so often, which can be done under a lock, so there would
> be no opportunity for races to corrupt the counter. (This is also an
> optimization since there needn't be any locks in the actual packet
> handling code.)


I was one of the ones who was interested in making the statistics 
64-bit, and adding locking to do it right.  The solution finally 
appeared, many months ago:

The counters don't need to be 64-bit, because it is trivially possible 
for userspace to track the statistics, and to simply use the difference 
between two samples as the increment used in calculating whatever 
numbers you wish -- 64-bit SNMP MIB statistics were what I was 
interested in.  Wrapping is trivially handled by standard unsigned int 
arithmetic, among other methods.

If you really want the raw data, then use ethtool's NIC-specific stats 
facility, to retrieve raw statistics directly from the NIC.  [this of 
course requires driver modifications, but they are easy on modern NICs]

	Jeff


