Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280532AbRKBCzg>; Thu, 1 Nov 2001 21:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280529AbRKBCzZ>; Thu, 1 Nov 2001 21:55:25 -0500
Received: from ns.ithnet.com ([217.64.64.10]:41732 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S280531AbRKBCzO>;
	Thu, 1 Nov 2001 21:55:14 -0500
Message-Id: <200111020255.DAA30651@webserver.ithnet.com>
Date: Fri, 02 Nov 2001 03:55:05 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Lorenzo Allegrucci <lenstra@tiscalinet.it>, <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <andrea@suse.de>
Content-Transfer-Encoding: 7BIT
Subject: Re: new OOM heuristic failure  (was: Re: VM: qsbench)
To: Stephan von Krawczynski <skraw@ithnet.com>
In-Reply-To: <200111020230.DAA30535@webserver.ithnet.com>
MIME-Version: 1.0
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok. I re-checked the code and found out this approach cannot stand. 
                                                                      
> the list scan _is_ already exited early when priority is low:       
                                                                      
                                                                      
Sorry for followup on my own mail, but there is another thing that    
comes to my mind:                                                     
                                                                      
swap_out is currently in no way priority-dependant. But it could be   
(the parameter is there). How about swapping more pages in tighter    
memory situation? The basic idea is that if there is a rising need for
mem it cannot be wrong to do a bit more than under normal             
circumstances. One could achieve this simply by:                      
                                                                      
        int counter, nr_pages = SWAP_CLUSTER_MAX;                     
                                                                      
to                                                                    
                                                                      
        int counter, nr_pages = SWAP_CLUSTER_MAX * DEF_PRIORITY /     
priority;                                                             
                                                                      
in swap_out.                                                          
The idea behind is to reduce the overhead in finding out if swapping  
is needed by simply swapping more everytime we already gone "the long 
way to knowing".                                                      
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
                                                                      
                                                                      
