Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbTHXRkh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 13:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbTHXRkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 13:40:36 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:736 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261273AbTHXRkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 13:40:35 -0400
Message-ID: <3F48F77D.7040907@namesys.com>
Date: Sun, 24 Aug 2003 21:35:57 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: Stephan von Krawczynski <skraw@ithnet.com>, linux-kernel@vger.kernel.org,
       Reiserfs List <reiserfs-list@namesys.com>,
       Nikita Danilov <god@laputa.namesys.com>
Subject: Re: FS: hardlinks on directories
References: <20030804141548.5060b9db.skraw@ithnet.com> <03080409334500.03650@tabby> <20030804170506.11426617.skraw@ithnet.com> <03080416092800.04444@tabby> <20030805003210.2c7f75f6.skraw@ithnet.com> <3F2FA862.2070401@aitel.hist.no> <20030805150351.5b81adfe.skraw@ithnet.com> <20030805220831.GA893@hh.idb.hist.no>
In-Reply-To: <20030805220831.GA893@hh.idb.hist.no>
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:

>On Tue, Aug 05, 2003 at 03:03:51PM +0200, Stephan von Krawczynski wrote:
>  
>
>>On Tue, 05 Aug 2003 14:51:46 +0200
>>Helge Hafting <helgehaf@aitel.hist.no> wrote:
>>
>>    
>>
>>>Even more fun is when you have a directory loop like this:
>>>
>>>mkdir A
>>>cd A
>>>mkdir B
>>>cd B
>>>make hard link C back to A
>>>
>>>cd ../..
>>>rmdir A
>>>
>>>You now removed A from your home directory, but the
>>>directory itself did not disappear because it had
>>>another hard link from C in B.
>>>      
>>>
>>How about a truly simple idea: 
>>
>>rmdir A says "directory in use" and is rejected
>>
>>    
>>
>Then anybody can prevent you from removing your obsolete directories
>by creating links to them.  Existing hard link don't have
>such problems.
>  
>
So, he needs links that count as references, links that don't count as 
references but disappear if the object disappears (without dangling like 
symlinks), and unlinkall(), which removes an object and all of its 
links.  He needs for the first reference to a directory to be removable 
only by removing all links to the object, or designating another link to 
be the "first" reference.

Sounds clean to me.  This is not to say that I am funded to write 
it.;-)  I'd look at a patch though.....;-)

I need to write up a taxonomy of links..... after reiser4 ships.....

-- 
Hans


