Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283245AbRLQX5f>; Mon, 17 Dec 2001 18:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283223AbRLQX5Z>; Mon, 17 Dec 2001 18:57:25 -0500
Received: from ns.ithnet.com ([217.64.64.10]:41745 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S283204AbRLQX5N>;
	Mon, 17 Dec 2001 18:57:13 -0500
Message-Id: <200112172357.AAA17058@webserver.ithnet.com>
Date: Tue, 18 Dec 2001 00:57:01 +0100
Subject: Re: [patch] mempool-2.5.1-D2
In-Reply-To: <Pine.LNX.4.33.0112172140430.17088-100000@localhost.localdomain>
To: <mingo@elte.hu>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
Cc: bcrl <bcrl@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>
From: Stephan von Krawczynski <skraw@ithnet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>                                                                     
> On Mon, 17 Dec 2001, Stephan von Krawczynski wrote:                 
>                                                                     
> > [...] You will obviously _not_ shoot down allocated and still used
> > bios, no matter how long they are going to take. So your fixed    
size                                                                  
> > pool will run out in certain (maybe weird) conditions. If you     
cannot                                                                
> > resize (alloc additional mem from standard VM) you are just dead. 
>                                                                     
> sure, the pool will run out under heavy VM load. Will it stay empty 
> forever? Nope, because all mempool users are *required* to          
deallocate the                                                        
> buffer after some (reasonable) timeout. (such as IO latency.) This  
is                                                                    
> pretty much by definition. (Sure there might be weird cases like IO 
> failure timeouts, but sooner or later the buffer will be returned,  
and it                                                                
> will be reused.)                                                    
                                                                      
Hm, and where is the real-world-difference to standard VM? I mean     
today your bad-ass application gets shot down by L's oom-killer and   
your VM will "refill". So you're not going to die for long in the     
current situation either.                                             
I have yet to see the brilliance in mempools. I mean, for sure I can  
imagine systems that are going to like it (e.g. embedded) a _lot_. But
these are far off the "standard" system profile.                      
I asked this several times now, and I will continue to, where is the  
VM _design_ guru that explains the designed short path to drop page   
caches when in need of allocable mem, regarding a system with         
aggressive caching like 2.4? This _must_ exist. If it does not, the   
whole issue is broken, and it is obvious that nobody will ever find an
acceptable implementation.                                            
I turned this problem about a hundred times round now, and as far as I
can see everything comes down to the simple fact, that VM has to      
_know_ the difference between a only-cached page and a _really-used_  
one. And I do agree with Rik, that the only-cached pages need an aging
algorithm, probably a most-simple approach (could be list-ordering).  
This should answer the question: who's dropped next?                  
On the other hand you have aging in the used-pages for finding out    
who's swapped out next. BUT I would say that swapping should only     
happen when only-cached pages are down to a minimum level (like 5% of 
memtotal).                                                            
Forgive my simplistic approach, where are the guys to shoot me?       
And where the hell is the need for mempool in this rough design idea? 
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
