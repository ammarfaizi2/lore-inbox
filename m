Return-Path: <linux-kernel-owner+w=401wt.eu-S965019AbWLMQlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWLMQlj (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 11:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbWLMQlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 11:41:39 -0500
Received: from smtp-vbr7.xs4all.nl ([194.109.24.27]:1256 "EHLO
	smtp-vbr7.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965014AbWLMQli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 11:41:38 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: cfq performance gap
References: <457fce6a$0$334$e4fe514c@news.xs4all.nl> <000001c71ed2$a90019b0$2e81030a@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@n2o.xs4all.nl (Miquel van Smoorenburg)
Date: 13 Dec 2006 16:41:30 GMT
Message-ID: <45802d3a$0$325$e4fe514c@news.xs4all.nl>
X-Trace: 1166028090 news.xs4all.nl 325 [::ffff:194.109.0.112]:39433
X-Complaints-To: abuse@xs4all.nl
In-Reply-To: <000001c71ed2$a90019b0$2e81030a@amr.corp.intel.com>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <000001c71ed2$a90019b0$2e81030a@amr.corp.intel.com>,
Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:
>Miquel van Smoorenburg wrote on Wednesday, December 13, 2006 1:57 AM
>> Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:
>> >This rawio test plows through sequential I/O and modulo each small record
>> >over number of threads.  So each thread appears to be non-contiguous within
>> >its own process context, overall request hitting the device are sequential.
>> >I can't see how any application does that kind of I/O pattern.
>> 
>> A NNTP server that has many incoming connections, handled by
>> multiple threads, that stores the data in cylic buffers ?
>
>Then whichever the thread that dumps the buffer content to the storage
>will do one large contiguous I/O.

In this context, "cyclic buffer" means "large fixed-size file" or
"disk partition", and when the end of that file/partition is reached,
writing resumes at the start (wraps around, starts the next cycle).

Each thread writes an article to disk, which can differ in size
from 1K to 1M. The writes all together are sequential, but the writes
from one thread are definitely not.

This is a real-world example - I have written software that does
exactly this, multithreaded versions of INN exist that with CNFS
storage does exactly this, and Diablo does something comparable
(only it uses processes instead of threads).

Mike.
