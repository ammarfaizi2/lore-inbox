Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269557AbUJWEpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269557AbUJWEpL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 00:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269324AbUJWEcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 00:32:42 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:31596 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268268AbUJWE1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:27:24 -0400
Message-ID: <4179DDA3.1020405@yahoo.com.au>
Date: Sat, 23 Oct 2004 14:27:15 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: John Hawkes <hawkes@sgi.com>
CC: John Hawkes <hawkes@google.engr.sgi.com>, John Hawkes <hawkes@oss.sgi.com>,
       Ingo Molnar <mingo@elte.hu>, jbarnes@sgi.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH, 2.6.9] improved load_balance() tolerance for pinned tasks
References: <200410201936.i9KJa4FF026174@oss.sgi.com> <200410221938.MAA52152@google.engr.sgi.com> <00ee01c4b870$030b80f0$6700a8c0@comcast.net>
In-Reply-To: <00ee01c4b870$030b80f0$6700a8c0@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Hawkes wrote:
> From: "John Hawkes" <hawkes@google.engr.sgi.com>
> 
>>No, your variation doesn't solve the problem.  This variation of your
>>patch does, however, solve the problem.  The difference is in
>>move_tasks():
> 
> 
> Actually, there is another related problem that arises in
> active_load_balance() with a runqueue that holds hundreds of pinned processes.
> I'm seeing a migration_thread perpetually consuming 70% of its CPU.
> 

That's what I was worried about, but in your most recent
patch you just sent, the all_pinned path should skip over
the active load balance completely... basically it shouldn't
be running at all, and if it is then it is a bug I think?
