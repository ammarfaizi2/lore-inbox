Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932694AbVJ0XjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694AbVJ0XjT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 19:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbVJ0XjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 19:39:19 -0400
Received: from hulk.vianw.pt ([195.22.31.43]:37079 "EHLO hulk.vianw.pt")
	by vger.kernel.org with ESMTP id S932694AbVJ0XjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 19:39:19 -0400
Message-ID: <43616512.7010704@esoterica.pt>
Date: Fri, 28 Oct 2005 00:38:58 +0100
From: Paulo da Silva <psdasilva@esoterica.pt>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fawad Lateef <fawadlateef@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Learning ext2 fs
References: <436116DC.6030104@esoterica.pt> <1e62d1370510271126i73cd94ebwc66f8d7583fa75c2@mail.gmail.com>
In-Reply-To: <1e62d1370510271126i73cd94ebwc66f8d7583fa75c2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fawad Lateef wrote:

>On 10/27/05, Paulo da Silva <psdasilva@esoterica.pt> wrote:
>  
>
>>I am reading the ext2 fs code. One of my purposes
>>is to save the original data of a file to another file
>>just before it is changed by write/mmap/whatever.
>>Because of mmap (any other reasons?) I thought
>>of doing this at "ext2-writepage" or/and
>>"ext2-writepages".
>>
>>Is this the right place?
>>    
>>
>
>ya, AFAIK ext2-writepage/s and ext2-readpage/s are the functions
>actually dealing with the file data and you can also see
>generic_file_write/read assigned to the fields in ext2_file_operations
>variable because they also deals with the file data ...
>  
>
Yes, I thought to hook generic_file_write/read for my purpose
until I found mmap does not use them! Then I went down to
writepage(s). 

>  
>
>>Is there a lower level where I can read/write blocks
>>of data from/to hd instead of full pages?
>>
>>    
>>
>
>I think at the lower-level you can deal with the block-layer but at
>this layer AFAIK you won't be able to distinguish between file data
>and file system data/structures because you will be dealing with just
>the blocks/chunks of data for block devices.
>  
>
Yes, but it could be useful for another purpose I have
in mind.
So far, I have found sb_read that allows for blocks
reading using a buffer_head. Does all block readings
use it? What about writes?

>  
>
>>How do I tell the really file data from other data?
>>
>>    
>>
>
>the functions readpage/writepage deals with the file data only not
>with the file-system data/structures. Here I am considering by saying
>other data you mean file-system data/structures
>
>
>  
>
May I conclude that all pages refer to data from/to the file?
I am not sure here, because I noticed that writepages
gets called when I unmounted the device!

>>I traced these functions but I only got
>>"ext2-writepages" to be called. "ext2-writepage"
>>was never called using the programs
>>I wrote to test this. When is "ext2-writepage" called?
>>
>>    
>>
>
>I think it doesn't matter that writepage or writepages are called
>because both almost do the same thing and the writepages version deals
>with more data and in your case the data may be big enough to handle
>by the writepages.
>
>  
>
Not at all. I just used a python program to create a file
with less than 1kb and then I wrote a few bytes mixing
"write" and "mmap". That's why I found strange
writepage not being called. Only writepages.

>>Thanks for any help.
>>Any readings advice is also welcome.
>>
>>    
>>
>
>I think you can first get some detailed understanding of VFS layer and
>then you can easily understand the code of the file-system like EXT2 !
>
>  
>
Well, so far I have only a superficial understanding of VFS,
but I feel relatively comfortable with it.
The problems I found are more related to the lower levels.
How to "say" to write the data to the storage, how to
handle the file data structures. For example, in this
case, I have to reread the original data from the file,
write it to another file, and then commit the pages
to disc as requested to the writepage(s) functions.
But to reread them, I have to save the  "about to
be written pages".
There is no literature that I know of, about this ...
and understanding the code is a hard work.

It would be nice if someone could write information about FSs.
I could find lots of information about VFS level, even a
small fs example with only 1 file. Unfortunately it works
in memory and makes no access to the disc. So,
the lower level remains obscure ...

Thank you.
Paulo

