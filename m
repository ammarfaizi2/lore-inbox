Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317657AbSGOVmY>; Mon, 15 Jul 2002 17:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317662AbSGOVmX>; Mon, 15 Jul 2002 17:42:23 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:45047 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317657AbSGOVmW>; Mon, 15 Jul 2002 17:42:22 -0400
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020715205505.GC30630@merlin.emma.line.org>
References: <20020712162306$aa7d@traf.lcs.mit.edu>
	<s5gsn2lt3ro.fsf@egghead.curl.com> <20020715173337$acad@traf.lcs.mit.edu>
	<s5gsn2kst2j.fsf@egghead.curl.com> 
	<20020715205505.GC30630@merlin.emma.line.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 15 Jul 2002 23:55:12 +0100
Message-Id: <1026773712.31924.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-15 at 21:55, Matthias Andree wrote:
> I assume that most will just call close() or fclose() and exit() right
> away. Does fclose() imply fsync()? 

It doesn't.

> Some applications will not even check the [f]close() return value...

We are only interested in reliable code. Anything else is already
fatally broken.

-- quote --
       Not checking the return value of close  is  a  common  but
       nevertheless   serious  programming  error.   File  system
       implementations which use techniques  as  ``write-behind''
       to  increase  performance may lead to write(2) succeeding,
       although the data has not been  written  yet.   The  error
       status  may be reported at a later write operation, but it
       is guaranteed to be reported on  closing  the  file.   Not
       checking  the  return value when closing the file may lead
       to silent loss of data.  This can especially  be  observed
       with NFS and disk quotas.

