Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265435AbSJSA7Z>; Fri, 18 Oct 2002 20:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265436AbSJSA7Y>; Fri, 18 Oct 2002 20:59:24 -0400
Received: from r2d2.aoltw.net ([64.236.137.26]:50869 "EHLO netscape.com")
	by vger.kernel.org with ESMTP id <S265435AbSJSA7X>;
	Fri, 18 Oct 2002 20:59:23 -0400
Message-ID: <3DB0AFCE.5030205@netscape.com>
Date: Fri, 18 Oct 2002 18:05:18 -0700
From: jgmyers@netscape.com (John Myers)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Charles 'Buck' Krasic" <krasic@acm.org>
CC: Davide Libenzi <davidel@xmailserver.org>,
       Benjamin LaHaise <bcrl@redhat.com>, Dan Kegel <dank@kegel.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
References: <Pine.LNX.4.44.0210171121390.1631-100000@blue1.dev.mcafeelabs.com> <3DB05AB2.3010907@netscape.com> <xu465vzo417.fsf@brittany.cse.ogi.edu>
In-Reply-To: <Pine.LNX.4.44.0210171121390.1631-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles 'Buck' Krasic wrote:

>Or we could have (to make John happier?):
>
>1 for(;;) {
>2      fd = event_wait(...);
>3      if(fd == my_listen_fd) {
>4           /* new connections */
>5           while((new_fd = my_accept(my_listen_fd, ...) != EAGAIN)) {
>6*                  epoll_addf(new_fd, &pfd, ...);
>7*                  if(pfd.revents & POLLIN) {
>7*                      while(do_io(new_fd) != EAGAIN);
>8*                  } 
>8           }
>9       } else {
>10           /* established connections */
>11           while(do_io(fd) != EAGAIN)
>12      }
>13 }
>  
>
Close.  What we would have is a modification of the epoll_addf() 
semantics such that it would have an additional postcondition that if 
the new_fd is in the ready state (has data available) then at least one 
notification has been generated.  In the code above, the three lines 
comprising the if statement labeled "7*" would be removed.


