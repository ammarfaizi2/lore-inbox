Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbTFIQw6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 12:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbTFIQw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 12:52:58 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:26048 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264536AbTFIQwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 12:52:33 -0400
Message-ID: <3EE4BD08.6040601@us.ibm.com>
Date: Mon, 09 Jun 2003 09:59:52 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Trivial Patch Monkey <trivial@rustcorp.com.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] use valid value when unmapping cpus
References: <3EDE63FE.1010603@us.ibm.com> <20030609052008.GB31216@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Wed, Jun 04, 2003 at 02:26:22PM -0700, Matthew Dobson wrote:
> 
>>For some unknown reason, we stick a -1 in cpu_2_node when we unmap a cpu 
>>on i386.  We're better off sticking a 0 in there, because at least 0 is 
>>a valid value if something references it.  -1 is only going to cause 
>>problems at some point down the line.
> 
> 
> Problems down the line help you find the bogus dereference. Even
> better to stick a poison value in there.

Well, it's not really a dereference issue.  The function, cpu_to_node() 
just returns an integer which is the node that particular CPU is on. 
This should always return a valid value.  This is used in many places, 
often as a direct index into an array, and we shouldn't have to check 
its return value everywhere.  The default behavior is to just return 0, 
because 0 is a valid node, even for UP/SMP.  The array of CPU -> node 
mappings is initialized to 0's on i386 already, so unmapping a CPU 
should return this mapping to its uninitialized state.

Cheers!

-Matt

