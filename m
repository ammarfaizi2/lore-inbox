Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263577AbTJWNpF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 09:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263578AbTJWNpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 09:45:04 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:11155 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263577AbTJWNo7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 09:44:59 -0400
Date: Thu, 23 Oct 2003 19:20:30 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Daniel McNeil <daniel@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: Patch for Retry based AIO-DIO (Was AIO and DIO testing on 2.6.0-test7-mm1)
Message-ID: <20031023135030.GA11807@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1066432378.2133.40.camel@ibm-c.pdx.osdl.net> <20031020142727.GA4068@in.ibm.com> <1066693673.22983.10.camel@ibm-c.pdx.osdl.net> <20031021121113.GA4282@in.ibm.com> <1066869631.1963.46.camel@ibm-c.pdx.osdl.net> <20031023104923.GA11543@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031023104923.GA11543@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 23, 2003 at 04:19:23PM +0530, Suparna Bhattacharya wrote:
> On Wed, Oct 22, 2003 at 05:40:32PM -0700, Daniel McNeil wrote:
> > Suparna and Andrew,
> > 
> > I've been doing more testing using the test programs I wrote to 
> > try and hit the AIO verses buffered read race conditions.
> > 
> > I tested 2.6.0-test8, 2.6.0-test8-mm1+(your first incomplete fix) and
> > 2.6.0-test8-mm1+aio-dio-retry patch.  I used my test programs
> > (http://developer.osdl.org/daniel/AIO/TESTS/) by doing:
> > 
> > Run "dirty" program which allocates and writes 0xaa to a file and then
> > 	frees the space.
> > Run "dio_sparse" or "aiodio-sparse - which creates "file", truncates it
> > 	up to 64MB and then writes zeros into the holes (using DIO or
> > 	AIO+DIO).  At same time, a forked child is reading the file
> > 	looking for non-zero data.
> > rm "file"
> > 
> > On 2.6.0-test8
> > ==============
> > I hit the race condition and see uninitialized data:
> > ~/AIO/TESTS/dio_sparse
> > non zero buffer at buf[4] => 0xaaaaaaaa,aaaaaaaa,aaaaaaaa,aaaaaaaa
> > non-zero read at offset 24182785
> > 
> >  ~/AIO/TESTS/aiodio_sparse
> > non zero buffer at buf[4] -> 0xaaaaaaaa,aaaaaaaa,aaaaaaaa,aaaaaaaa
> > non-zero read at offset 8323062
> > 
> > 
> > On 2.6.0-test8-mm1+1st-direct-io-aio_complete patch and
> >    2.6.0-test8-mm1+aio-dio-retry patch
> > 
> > I never see uninitialized data.
> 
> That's good news.
> 
> You seem to be able to run test8-mm1 just fine; I have been
> running into strange oops on syscall return for io_getevents :(
> - haven't seen this before.
> What library and header files are you using for libaio ? Do you have
> 4G-4G turned on in your build ?

It turns out that backing out gcc-Os.patch (on RH 9) or switching 
to a system with an older compiler version made those errors go away.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

