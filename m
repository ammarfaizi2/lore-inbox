Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbTDLJnK (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 05:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263220AbTDLJnK (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 05:43:10 -0400
Received: from siaag2ae.compuserve.com ([149.174.40.135]:15539 "EHLO
	siaag2ae.compuserve.com") by vger.kernel.org with ESMTP
	id S263219AbTDLJnI (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 05:43:08 -0400
Date: Sat, 12 Apr 2003 05:52:43 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Completely new idea to virtual memory
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304120554_MC3-1-341A-4160@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Why not also write pages out to swap before it's really necessary?
>> If they were left mapped but marked as having up-to-date copies
>> on swap, they could be discarded immediately if the system needed
>> memory.  (Of course if they got written to they would have to be
>> paged out again.)
>
>Hmmm, interesting...


  The gains from this might be largely illusion but you could get some
theoretical benefits:

  o could write out lots of pages to swap without having to flush TLBs
    like you would if doing normal swap, since page remains present

  o if swsusp does not need to write already-backed pages it could
    reduce suspend time

  Maybe something like this?

   if about_to_spin_down_disks || swap_disk_idle
       if lots_of_memory_free
           page_in
       if little_memory_free
           copy_pages_to_swap
                  
 
--
 "Let's fight till six, and then have dinner," said Tweedledum.
  --Lewis Carroll, _Through the Looking Glass_
