Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272882AbRITQzo>; Thu, 20 Sep 2001 12:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274565AbRITQzf>; Thu, 20 Sep 2001 12:55:35 -0400
Received: from [208.129.208.52] ([208.129.208.52]:48908 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S272882AbRITQzU>;
	Thu, 20 Sep 2001 12:55:20 -0400
Message-ID: <XFMail.20010920095851.davidel@xmailserver.org>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3BA95C87.5272E764@kegel.com>
Date: Thu, 20 Sep 2001 09:58:51 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Dan Kegel <dank@kegel.com>
Subject: Re: [PATCH] /dev/epoll update ...
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20-Sep-2001 Dan Kegel wrote:
> One more question: if I guess wrong initially about how many
> file descriptors I'll be monitoring with /dev/epoll, and I need
> to increase the size of the area inside /dev/epoll in the middle of
> my scan through the results, what is the proper sequence of calls?
> 
> Some possibilities:
> 
> 1)  EP_ALLOC, and continue scanning through the results
> 
> 2)  EP_FREE, EP_ALLOC, EP_POLL because old results are now invalid
> 
> 3)  EP_FREE, EP_ALLOC, write new copies of all the old fds to /dev/epoll, 
>     EP_POLL, and start new scan
> 
> I bet it's #3.  Am I right?

I'm coding a solution that try to minimize the reallocation cost even if it's better
to preallocate the number of fds without changing it.
If you think to handle 200000 fds in your system the memory cost of the epoll
allocation is nothing compared to the file*, socket buffer, etc...




- Davide

