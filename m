Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWDZEuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWDZEuK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 00:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbWDZEuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 00:50:10 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:47472 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932359AbWDZEuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 00:50:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=HZvhD9x5vEBo5x7IBPOn1k851RN1Y4kpgYOuf8v5GR/n59cPCsPzLrn7E9O4Bltluu11+rs25bC+POaAm8i/qOVtInkXD+rWc7YecefSVjvs8trr5sQ0TStH1UXgBzvOqJo9bmZ8OvPV6cxKjPyg638i717AhFvwR1pG7PcUOMk=  ;
Message-ID: <444EF2CF.1020100@yahoo.com.au>
Date: Wed, 26 Apr 2006 14:10:55 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Peterson <dsp@llnl.gov>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org, riel@surriel.com,
       akpm@osdl.org
Subject: Re: [PATCH 1/2] mm: serialize OOM kill operations
References: <200604251701.31899.dsp@llnl.gov>
In-Reply-To: <200604251701.31899.dsp@llnl.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Peterson wrote:

>The patch below modifies the behavior of the OOM killer so that only
>one OOM kill operation can be in progress at a time.  When running a
>test program that eats lots of memory, I was observing behavior where
>the OOM killer gets impatient and shoots one or more system daemons
>in addition to the program that is eating lots of memory.  This fixes
>the problematic behavior.
>

Hi Dave,

Firstly why not use a semaphore and trylocks instead of your homebrew
lock?

Second, can you arrange it without using the extra field in mm_struct
and operation in the mmput fast path?

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
