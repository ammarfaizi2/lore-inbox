Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316434AbSGXPMK>; Wed, 24 Jul 2002 11:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317037AbSGXPMK>; Wed, 24 Jul 2002 11:12:10 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:27068 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S316434AbSGXPMJ>; Wed, 24 Jul 2002 11:12:09 -0400
Message-ID: <3D3EC483.4000805@namesys.com>
Date: Wed, 24 Jul 2002 19:15:15 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joshua MacDonald <jmacd@namesys.com>
CC: Jakob Oestergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org
Subject: Re: type safe lists (was Re: PATCH: type safe(r) list_entry repacement:
 generic_out_cast)
References: <15677.33040.579042.645371@laputa.namesys.com> <20020723220745.GD2090@reload.namesys.com> <20020724122232.GT11081@unthought.net> <20020724124054.GO11106@reload.namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua MacDonald wrote:

>On Wed, Jul 24, 2002 at 02:22:32PM +0200, Jakob Oestergaard wrote:
>  
>
>>On Wed, Jul 24, 2002 at 02:07:45AM +0400, Joshua MacDonald wrote:
>>...
>>    
>>
>>>This may interest you.  We have written a type-safe doubly-linked list
>>>template which is used extensively in reiser4.  This is the kind of thing that
>>>some people like very much and some people hate, so I'll spare you the
>>>advocacy.
>>>      
>>>
>>Ok, here's my comments:
>>
>>*) Using macros like that is ugly as hell, but as I see it it is the
>>only way to achieve type safety in such generic code.  If the ugliness
>>is confined to one header file, and possibly one .c file containing the
>>needed instantiations, I would argue that the ugliness is bearable.  In
>>other words, I think your solution is the prettiest one possible.
>>
>>Since all list routines right now are extremely simple, it's probably ok
>>to just have it all in a header. If larger routines are added later on,
>>it may be desirable to create a .c file holding the needed (macro
>>instantiated) routines. In that case, the following applies:
>>
>>*) I would suggest making one list_instances.c which holds all the
>>INSTANTIATE... definitions of the list types needed in the kernel. This
>>way we will avoid having two list codes generated for the same type (an
>>easy accident to make with the macro approach)
>>*) You would have to somehow separate the "simple" routines which should
>>be inlined, and the larger ones which should remain function calls. This
>>would mean that a .c file using the list header would have the inline
>>functions declared in the list header (using static inline so unused
>>routines won't bloat the .o), and find it's larger out-of-line routines
>>in the global list .o.
>>
>>The reason I'm suggesting doing the above instead of simply
>>instantiating a list implementation for each type needed, whenever it is
>>needed, is simply to avoid code bloat.
>>
>>My only comment for the code would be to require that the link from the
>>element into the list would always be called "rx_list_backlink" or
>>whatever (if the list name is "rx_list") - the freedom you have in
>>specifying what the LINK_NAME is, is useless as I see it, and only adds
>>to the confusion.
>>    
>>
>
>Jakob,
>
>These are fine suggestions.  The debug-only list invariants, the splice
>function, and possibly others are definetly candidates for non-static-inline
>inclusion.  A single list_instances.c file makes a lot of sense (except for
>modules--maybe?), and you are right that LINK_NAME is basically useless.
>
>Since this code is already part of reiser4, it is likely to be crititically
>reviewed again when Hans begins his push.  I will fix the LINK_NAME issue and
>change the reiser4-specific assert() calls to generic ones.  We welcome
>feedback.
>
>-josh
>
>
>  
>
>>-- 
>>................................................................
>>:   jakob@unthought.net   : And I see the elder races,         :
>>:.........................: putrid forms of man                :
>>:   Jakob Østergaard      : See him rise and claim the earth,  :
>>:        OZ9ABN           : his downfall is at hand.           :
>>:.........................:............{Konkhra}...............:
>>    
>>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
Linus prefers his patches in digestible bytes, so things that are also 
valuable to persons not coding reiser4, and are working/stable should be 
sent in earlier than reiser4 (as you have done with this list code).

Unfortunately the other things of value to others (transactions API, 
reiser4 syscall) are the least stable parts of our code at the moment, 
or we would send them in.

-- 
Hans



