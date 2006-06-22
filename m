Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030619AbWFVGgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030619AbWFVGgx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 02:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030620AbWFVGgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 02:36:53 -0400
Received: from dvhart.com ([64.146.134.43]:50337 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1030619AbWFVGgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 02:36:52 -0400
Message-ID: <449A3A70.5000906@mbligh.org>
Date: Wed, 21 Jun 2006 23:36:32 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kmannth@us.ibm.com
Cc: Dave Jones <davej@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] patch [1/1]  convert i386 summit subarch to use SRAT	data
 for apicid_to_node
References: <1150941296.10001.25.camel@keithlap>	 <20060622022414.GB4449@redhat.com> <1150948551.10001.62.camel@keithlap>
In-Reply-To: <1150948551.10001.62.camel@keithlap>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

keith mannthey wrote:
> On Wed, 2006-06-21 at 22:24 -0400, Dave Jones wrote:
> 
>>On Wed, Jun 21, 2006 at 06:54:55PM -0700, keith mannthey wrote:
>> > Hello All,
>> >   This patch converts the i386 summit subarch apicid_to_node to use node
>> > information provided by the SRAT.  The current way of obtaining the
>> > nodeid 
>> > 
>> >  static inline int apicid_to_node(int logical_apicid)
>> >  { 
>> >    return logical_apicid >> 5;
>> >  }
>> > 
>> > is just not correct for all summit systems/bios.  Assuming the apicid
>> > matches the Linux node number require a leap of faith that the bios lay-
>> > ed out the apicids a set way.  Modern summit HW does not layout its bios
>> > in the manner for various reasons and is unable to boot i386 numa.
>> > 
>> >   The best way to get the correct apicid to node information is from the
>> > SRAT table. 
>>
>>Do all summit's have SRAT tables ?
>>I was under the impression the early ones were around before
>>the invention of SRAT.
> 
> 
> That is a good point.  Let me check into the x440 (1st gen).  x445 x460
> (2nd,3rd gen) uses SRAT for sure (these patches have been tested on
> these systems).  
> 
> The x440 lists an srat but maybe it is using some special bios area.  I
> will build a test kernel give it a whirl.  

I'm pretty sure they all had SRAT tables - the test machine we use 
regularly for test.kernel.org (elm3b67) does. The NUMA-Q (x430) doesn't,
but that's a separate subarch.

M.
