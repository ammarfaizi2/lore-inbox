Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263022AbTDRLRu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 07:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbTDRLRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 07:17:50 -0400
Received: from siaag2ad.compuserve.com ([149.174.40.134]:43480 "EHLO
	siaag2ad.compuserve.com") by vger.kernel.org with ESMTP
	id S263022AbTDRLRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 07:17:49 -0400
Date: Fri, 18 Apr 2003 07:25:46 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: DMA transfers in 2.5.67
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304180729_MC3-1-34EE-CBE8@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:


> > Chuck Ebbert <76306.1226@compuserve.com> wrote:
> > >
> > > # mount /ext3_fs
> > > # time dd if=/ext3_fs/100MiB_file of=/dev/null bs=32k
> > > 
> > >   2.4.20aa1 : 3.3 sec (exactly what I expect to see)
> > >   2.5.66    : 6.6 sec
> > 
> > With this test 2.4 will leave a lot more unwritten dirty data in memory.
> > 
> > You should include a `sync' in the timings.
> 
> Well you should include the sync if you're writing to disk ;)


  :)

  All is not beer and skittles here with Andrea's kernel, though.
Sometimes instead of 31MB/sec I get this with 1 sequential stream:


 1  0  0      0   1232   1120  47988   0   0 14928     0 3834  7534   1  44  55
 1  0  0      0   1372   1120  47848   0   0 14704     0 3778  7446   0  32  68
 1  0  0      0   1464   1064  47816   0   0 14880     0 3822  7501   1  43  56
 1  0  0      0   1336   1064  47944   0   0 14844     0 3813  7493   0  29  71
 1  0  0      0   1432   1064  47848   0   0 14748    32 3800  7467   0  41  59
 1  0  0      0   1532   1064  47748   0   0 13976     0 3596  7045   1  33  66
 


  Pretty high context switch and interrupt rates for a PPro 200, huh?

  And I can't reliably reproduce it (so far...)

------
 Chuck
