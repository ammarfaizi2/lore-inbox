Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268199AbTBSBOr>; Tue, 18 Feb 2003 20:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268200AbTBSBOr>; Tue, 18 Feb 2003 20:14:47 -0500
Received: from pop017pub.verizon.net ([206.46.170.210]:22181 "EHLO
	pop017.verizon.net") by vger.kernel.org with ESMTP
	id <S268199AbTBSBOp>; Tue, 18 Feb 2003 20:14:45 -0500
Message-ID: <3E52DCE6.5090403@verizon.net>
Date: Tue, 18 Feb 2003 20:24:54 -0500
From: Stephen Wille Padnos <stephen.willepadnos@verizon.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: a really annoying feature of the config menu structure
References: <Pine.LNX.4.44.0302181955260.24383-100000@dell>
In-Reply-To: <Pine.LNX.4.44.0302181955260.24383-100000@dell>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at pop017.verizon.net from [64.223.82.122] at Tue, 18 Feb 2003 19:24:41 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:

>On Tue, 18 Feb 2003, Stephen Wille Padnos wrote:
>
>  
>
>>[snip]
>>
>>    
>>
>>> as i see it, this can only get worse.  the current
>>>erratic and disorganized structure of the config menus
>>>is proof of that.
>>>
>>> comments?
>>>
>>>      
>>>
>>I think the problem with the "Multimedia" menu is that it's misnamed.  
>>It should actually be the "tuners" menu - it's there for audio, digital 
>>video, and video tuners.  The same could be said of the networking menu, 
>>and presumably others.
>>
>>You can actually reorganize things simply by changing the structure of 
>>the top-level Kconfig file.  With the following patches, I reorganized 
>>the multimedia options into the form that you are probably looking for.  
>>(hopefully they won't be mangled by my mailer)
>>
>>With not too much rewriting (many small changes, I think), the menus can 
>>be organized much better.
>>
>>Essentially, each subdirectory has a Kconfig file that does _not_ 
>>declare itself a standalone menu.  This allows a parent to decide 
>>whether or not to include it in another menu.  The menu should only have 
>>options that pertain to things in its' directory.  ie, the Kconfig file 
>>in drivers/net should not include "Networking" as an option - that is a 
>>higher level decision (ie, it decides whether or not to include the 
>>drivers/net config file).
>>
>>Then, the Kconfig files from various subdirectories can be ordered in 
>>whatever way makes sense from a user's point of view
>>
>>--- drivers/media/Kconfig.orig        2003-02-18 17:15:46.000000000 -0500
>>+++ drivers/media/Kconfig.new 2003-02-18 17:25:27.000000000 -0500
>>@@ -2,8 +2,6 @@
>> # Multimedia device configuration
>> #
>>
>>-menu "Multimedia devices"
>>-
>> config VIDEO_DEV
>>        tristate "Video For Linux"
>>        ---help---
>>@@ -32,5 +30,4 @@
>>
>> source "drivers/media/dvb/Kconfig"
>>
>>-endmenu
>>    
>>
>
>... some patch snipped here ...
>
>  oh, i'm aware that (for example) the multimedia menu stuff
>can be fixed if you go into the directory and change the Kconfig
>file.  but that's exactly the kind of thing i'm trying to 
>*avoid*.  philosophically, it would be ideal to let each 
>directory be a self-contained bundle of related modules
>and the Kconfig menu file that goes with them.
>
>  what has to be avoided is for any of these directories to
>give itself a menu label that implies that it's fairly high
>up in the food chain, and subsequently leave no way to 
>incorporate submenus beneath it.  (see, eg., "Multimedia")
>
The only change to "drivers/media/Kconfig" was the removal of the menu 
and endmenu lines, for exactly the purpose of removing the title.

>  rearranging the top-level options by having to make changes
>to any of the individual subdirectory Kconfig files is just not
>an appealing option.
>
Since the individual files aren't "relocatable" at this point, I think 
that at least *one* change might be needed :)  The idea would be to 
change it once, and not need to do so again for layout changes.

>  i realize that all of this sounds like much ado about
>nothing, but as more options are added to the kernel, this
>is just going to get more unmanageable, but i have no idea
>if anyone else thinks this is something worth addressing.
>
>  if not, i'm willing to drop it.
>
>rday
>
I think it's worth pursuing - I've had no end of annoyance with USB and 
ieee1394 configuration (among other things).

- Steve


