Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbUEDVxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbUEDVxZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 17:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUEDVxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 17:53:25 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:63480 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261197AbUEDVxX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 17:53:23 -0400
Subject: Re: Random file I/O regressions in 2.6
From: Ram Pai <linuxram@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, peter@mysql.com, alexeyk@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <1083700735.13688.69.camel@localhost.localdomain>
References: <200405022357.59415.alexeyk@mysql.com>
	 <409629A5.8070201@yahoo.com.au> <20040503110854.5abcdc7e.akpm@osdl.org>
	 <1083615727.7949.40.camel@localhost.localdomain>
	 <20040503135719.423ded06.akpm@osdl.org>
	 <1083620245.23042.107.camel@abyss.local>
	 <20040503145922.5a7dee73.akpm@osdl.org> <4096DC89.5020300@yahoo.com.au>
	 <20040503171005.1e63a745.akpm@osdl.org> <4096E1A6.2010506@yahoo.com.au>
	 <1083631804.4544.16.camel@localhost.localdomain>
	 <20040503232928.1b13037c.akpm@osdl.org>
	 <1083683034.13688.7.camel@localhost.localdomain>
	 <1083699554.13688.64.camel@localhost.localdomain>
	 <20040504124800.67e1c819.akpm@osdl.org>
	 <1083700735.13688.69.camel@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1083707518.13688.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 May 2004 14:51:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-04 at 12:58, Ram Pai wrote:
> On Tue, 2004-05-04 at 12:48, Andrew Morton wrote:
> > Ram Pai <linuxram@us.ibm.com> wrote:
> > >
> > > I ran the following command:
> > > 
> > >  /root/sysbench-0.2.5/sysbench/sysbench --num-threads=256 --test=fileio
> > >  --file-total-size=2800M --file-test-mode=rndrw run 
> > > 
> > 
> > Alexey and I have been using 16 threads.
> >
 /root/sysbench-0.2.5/sysbench/sysbench --num-threads=16 --test=fileio
--file-total-size=2800M --file-test-mode=rndrw run 

Without the patch:
------------------

Operations performed:  6002 Read, 3998 Write, 12800 Other = 22800 Total
Read 93Mb  Written 62Mb  Total Transferred 156Mb
   1.967Mb/sec  Transferred
  126.11 Requests/sec executed

Test execution Statistics summary:
Time spent for test:  79.2986s

no of times window reset because of hits: 0
no of times window reset because of misses: 119
no of times window was shrunk because of hits: 417
no of times the page request was non-contiguous: 3809
no of times the page request was contiguous : 12745

With the patch:
--------------
Operations performed:  6002 Read, 3999 Write, 12672 Other = 22673 Total
Read 93Mb  Written 62Mb  Total Transferred 156Mb
   2.927Mb/sec  Transferred
  187.65 Requests/sec executed

Test execution Statistics summary:
Time spent for test:  53.2949s

no of times window reset because of hits: 0
no of times window reset because of misses: 0
no of times window was shrunk because of hits: 360
no of times the page request was non-contiguous: 5860
no of times the page request was contiguous : 20378


Impressive results. WOuld be nice to get a confirmation from Alexey.
RP

