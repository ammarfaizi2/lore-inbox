Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266793AbUIPCsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266793AbUIPCsE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 22:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266910AbUIPCsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 22:48:03 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:56510 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266793AbUIPCrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 22:47:55 -0400
Message-ID: <4148FED6.100@yahoo.com.au>
Date: Thu, 16 Sep 2004 12:47:50 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Albert Cahalan <albert@users.sf.net>, Jakub Jelinek <jakub@redhat.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>, ak@muc.de
Subject: Re: get_current is __pure__, maybe __const__ even
References: <1095288600.1174.5968.camel@cube> <20040915231518.GB31909@devserv.devel.redhat.com> <20040915232956.GE9106@holomorphy.com> <1095300619.2191.6392.camel@cube> <20040916023604.GH9106@holomorphy.com>
In-Reply-To: <20040916023604.GH9106@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

> On Wed, Sep 15, 2004 at 10:10:20PM -0400, Albert Cahalan wrote:
> 
>>I don't think even barrier() is needed.
>>Suppose gcc were to cache the value of
>>current over a schedule. Who cares? It'll
>>be the same after schedule() as it was
>>before.
> 
> 
> Not over a call to schedule(). In the midst of schedule().
> 

In a way, it is. Because after context_switch, the stack
and registers have been replaced by the new task. So if
current was cached somewhere before that task had scheduled
off, then it still would be correct now that it is scheduled
back on.

At points *within* context_switch, current won't be right,
but AFAIKS current is never used in there.
