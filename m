Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbVKVQlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbVKVQlB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 11:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbVKVQlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 11:41:00 -0500
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:34433 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S964995AbVKVQk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 11:40:59 -0500
Message-ID: <43834A16.4090408@austin.rr.com>
Date: Tue, 22 Nov 2005 10:40:54 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: CIFS improvements/wider testing needed
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VALETTE Eric RD-MAPS-REN wrote:

>Steve French wrote:
>  
>
>>VALETTE Eric RD-MAPS-REN wrote:
>>
>>    
>>
>>>Steve French wrote:
>>> 
>>>
>>>      
>>>
>>>>Eric,
>>>>  
>>>>        
>>>>
>>>Well I would be surprised the "cat >> titi" command does any of this
>>>byte range lock. If the "create and later rewrite the same file"
>>>sequence fails, with a simple cat command (cat > titi ... ^D; cat >>
>>>titi), how can it works with complicated applications?
>>>
>>> 
>>>
>>>      
>>>
>>Make sure that you let me know if your cat example works when mounted
>>with the relatively new "noperm" mount option on the client.   At least
>>then we will know whether we are looking at a problem with access
>>control on the server (ntfs acls) or client (unix mode bits and the
>>.permission entry point)
>>    
>>
>
>Works with the "noperm" mount option.
>
>--eric
>
>  
>
Could you run "stat titi" and/or "ls -l titi" between the
    "cat > titi"
and the
    "cat >> titi"

so I can see what cifs thinks the owner of the file is and the mode.   I 
also need to know the current user so I can see whether it matches what 
cifs has as the owner of the file.    Note that readdir (ls of a 
directory or ls with a wildcard) and lookup (ls of a specific file, or 
stat) hit different code paths in the cifs vfs but both cause default 
mode bits to be put in the inode metadata.

If this does not point out the problem, then I will give you a modified 
version of cifs_permission to trace what is happening.
