Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292684AbSCDSmR>; Mon, 4 Mar 2002 13:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292674AbSCDSmJ>; Mon, 4 Mar 2002 13:42:09 -0500
Received: from 216-42-72-143.ppp.netsville.net ([216.42.72.143]:48549 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S292669AbSCDSl4>; Mon, 4 Mar 2002 13:41:56 -0500
Date: Mon, 04 Mar 2002 13:41:21 -0500
From: Chris Mason <mason@suse.com>
To: James Bottomley <James.Bottomley@steeleye.com>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3) 
Message-ID: <1269210000.1015267281@tiny>
In-Reply-To: <200203041811.g24IBRQ09280@localhost.localdomain>
In-Reply-To: <200203041811.g24IBRQ09280@localhost.localdomain>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, March 04, 2002 12:11:27 PM -0600 James Bottomley <James.Bottomley@steeleye.com> wrote:

> mason@suse.com said:
>> Sorry, what do you mean by multi-threaded back end completion of the
>> transaction?  
> 
> It's an old idea from databases with fine grained row level locking.  To alter 
> data in a single row, you reserve space in the rollback log, take the row 
> lock, write the transaction description, write the data, undo the transaction 
> description and release the rollback log space and row lock.  These actions 
> are sequential, but there may be many such transactions going on in the table 
> simultaneously.  The way I've seen a database do this is to set up the actions 
> as linked threads which are run as part of the completion routine of the 
> previous thread.  Thus, you don't need to wait for the update to complete, you 
> just kick off the transaction.

Ok, then, like sct said, we try really hard to have external threads
do log io for us.  It also helps that an atomic unit usually isn't
as small as 'mkdir p'.  Many operations get batched together to
reduce log overhead.

-chris

