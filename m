Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265229AbUGISoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265229AbUGISoQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 14:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265230AbUGISoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 14:44:16 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:21482 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265229AbUGISoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 14:44:05 -0400
Message-ID: <40EEE778.5000506@namesys.com>
Date: Fri, 09 Jul 2004 11:44:08 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jmerkey@comcast.net
CC: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: Ext3 File System "Too many files" with snort
References: <070920041830.21850.40EEE455000BE22E0000555A2200735446970A059D0A0306@comcast.net>
In-Reply-To: <070920041830.21850.40EEE455000BE22E0000555A2200735446970A059D0A0306@comcast.net>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jmerkey@comcast.net wrote:

>>jmerkey@comcast.net writes:
>>
>>    
>>
>>>I may alter the on disk structures to increase this to something larger, say 
>>>      
>>>
>>16,000,000,
>>    
>>
>>>which would break ext3 on other systems.  I will look at the code for this 
>>>      
>>>
>to 
>  
>
>>see if this is 
>>    
>>
>>>even possible without the FS meta data growing so huge, it renders 
>>>      
>>>
>performance 
>  
>
>>poor.
>>    
>>
>>>These types of limits should probably be done away with with an 
>>>      
>>>
>architectural 
>  
>
>>change, 
>>
>>It's not only ext3 - one reason this limit is there because
>>in the old stat st_nlink was 16bit only. Now that stat64 is there
>>and glibc uses it by default it could be increased to 32bit, 
>>but you would need to think what to do with old applications that 
>>stat the directory. For files >2GB old stat returns an errno, 
>>maybe this would need to be done for such directories too.
>>
>>    
>>
>
>Andi,  
>
>Sounds like this is correct.    I will look at statfs().  I am very familiar 
>with this section of linux 
>with the VFS.  We should make this value 32 bit.  One solution would be to 
>instrument a 
>versioning field in the superblock so we can write the smarts into ext3/2/reiser  
>to handle
>different on-disk structures.  when a supoerblock gets read, it could detect 
>waht type of 
>on disk structures are instrumented.  
>  
>
Just use reiser4 which has disk format plugins.  reiserfs v3 should stay 
stable and undisturbed.

>Jeff  
>  
>
>>-Andi
>>
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

