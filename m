Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272886AbRIPW3f>; Sun, 16 Sep 2001 18:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272898AbRIPW3Z>; Sun, 16 Sep 2001 18:29:25 -0400
Received: from ns.ithnet.com ([217.64.64.10]:43789 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S272886AbRIPW3R>;
	Sun, 16 Sep 2001 18:29:17 -0400
Message-Id: <200109162229.AAA12262@webserver.ithnet.com>
From: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
        Andreas Steinmetz <ast@domdv.de>, <linux-kernel@vger.kernel.org>
Date: Mon, 17 Sep 2001 00:29:27 +0100
Content-Transfer-Encoding: 7BIT
Subject: Re: broken VM in 2.4.10-pre9
To: Linus Torvalds <torvalds@transmeta.com>
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.33.0109161509300.915-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>                                                                     
                                                                      
>>> (The new code is a simple state machine:                          
>>>                                                                   
>>> - touch non-referenced page: set the reference bit                
>>>                                                                   
>>> - touch already referenced page: move it to next list "upwards"   
(ie the                                                               
>>>    active list)                                                   
>>>                                                                   
>>> - age a non-referenced page on a list: move to "next" list        
downwards (ie                                                         
>>>   free if already inactive, move to inactive if currently active) 
>>>                                                                   
>>> - age a referenced page on a list: clear ref bit and move to      
beginning of                                                          
>>>    same list.                                                     
                                                                      
> > Are you sure about the _beginning_? You are aging out _all_       
non-ref                                                               
> > pages in the next step?                                           
>                                                                     
> Well, it depends on what your definition of "is" is..               
>                                                                     
> Or rather, what the "beginning" is. The way things work now, is that
all                                                                   
> pages are added to the "beginning", and the aging is done from the  
end,                                                                  
> moving pages at the end to other lists (or, in the case of a        
referenced                                                            
> page, back to the beginning).                                       
                                                                      
Wait a minute: if you age a page in active by clearing ref-bit and    
moving it to beginning of the list, and your next aging cycle starts  
from the end, that reads like you have to walk the whole list to find 
all the ageable pages for moving "downwards". In fact I expected your 
aging to start the list from the beginning, as there should be "most" 
of the non-ref entries, and you could stop age-walking hitting the    
first ref-page in that list.                                          
This was my guess when aging is used to find possible free pages      
_fast_.                                                               
Am I wrong or is this idea generally not useable?                     
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
                                                                      
