Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751520AbWCJO7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbWCJO7F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 09:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbWCJO7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 09:59:05 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:46772 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751336AbWCJO7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 09:59:03 -0500
Message-ID: <441193FD.50901@us.ibm.com>
Date: Fri, 10 Mar 2006 06:58:05 -0800
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Arjan van de Ven <arjan@infradead.org>, sct@redhat.com, jack@suse.cz,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Ext2-devel@lists.sourceforge.net
Subject: Re: [RFC PATCH] ext3 writepage() journal avoidance
References: <1141929562.21442.4.camel@dyn9047017100.beaverton.ibm.com>	<20060309152254.743f4b52.akpm@osdl.org>	<1141977557.2876.20.camel@laptopd505.fenrus.org>	<20060310002337.489265a3.akpm@osdl.org>	<1141980238.2876.27.camel@laptopd505.fenrus.org> <20060310005306.428b13ee.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Arjan van de Ven <arjan@infradead.org> wrote:
>
>>On Fri, 2006-03-10 at 00:23 -0800, Andrew Morton wrote:
>> > Arjan van de Ven <arjan@infradead.org> wrote:
>> > >
>> > > 
>> > > > I'm not sure that PageMappedToDisk() gets set in all the right places
>> > > > though - it's mainly for the `nobh' handling and block_prepare_write()
>> > > > would need to be taught to set it.  I guess that'd be a net win, even if
>> > > > only ext3 uses it..
>> > > 
>> > > btw is nobh mature enough yet to become the default, or to just go away
>> > > entirely as option ?
>> > 
>> > I don't know how much usage it's had, sorry.  It's only allowed in
>> > data=writeback mode and not many people seem to use even that.
>>
>> would you be prepared to turn it on by default in -mm for a bit to see
>> how it holds up?
>>
>
>spose so.  One would have to test it a bit first, make sure that it still
>works.  Performance testing with PAGE_SIZE much-greater-than blocksize
>would be needed.
>
I did nobh option only for writeback mode + only if PAGE_SIZE == 
blocksize case :(
I guess I could enhance it for PAGE_SIZE > blocksize case also.

Doing it for ordered mode, journal mode is hard - due to transactions & 
ordering.
As you suggested while ago, we need a new mode. I hate to add new modes 
since
no one will be using it (unless we decide to make it default). Thats the 
reason why
I spent little time doing nobh option for writeback mode.

>
>Unfortunately there's no `-o bh' (nonobh?) to turn it back on again if it
>causes problems..
>

Can be added easily. I will send out a patch for this.

Thanks,
Badari

>



