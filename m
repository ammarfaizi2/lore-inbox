Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWBJPxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWBJPxz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 10:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWBJPxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 10:53:55 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:28592 "EHLO
	zcars04f.nortel.com") by vger.kernel.org with ESMTP id S932148AbWBJPxy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 10:53:54 -0500
Message-ID: <43ECB701.1010703@nortel.com>
Date: Fri, 10 Feb 2006 09:53:37 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Shoemaker <c.shoemaker@cox.net>
CC: Joerg Schilling <schilling@fokus.fraunhofer.de>, tytso@mit.edu,
       peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <43EC887B.nailISDGC9CP5@burner> <mj+md-20060210.123726.23341.atrey@ucw.cz> <43EC8E18.nailISDJTQDBG@burner> <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr> <43EC93A2.nailJEB1AMIE6@burner> <20060210141651.GB18707@thunk.org> <43ECA3FC.nailJGC110XNX@burner> <43ECA70C.8050906@nortel.com> <43ECA8BC.nailJHD157VRM@burner> <43ECADA8.9030609@nortel.com> <20060210153223.GA27599@pe.Belkin>
In-Reply-To: <20060210153223.GA27599@pe.Belkin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Feb 2006 15:53:40.0470 (UTC) FILETIME=[297E1160:01C62E5A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Shoemaker wrote:
> On Fri, Feb 10, 2006 at 09:13:44AM -0600, Christopher Friesen wrote:

>>That depends on what "uniquely identified" actually means.
> 
> 
> "The st_ino and st_dev fields taken together uniquely identify the
> file within the system."

>>The other possibility (and this is what you seem to be advocating) is 
>>that a st_ino/st_dev tuple always maps to the same file over the entire 
>>runtime of the system.

> However, I don't think this is a reasonable interpretation, and it's
> clearly _not_ the one that Joerg is implying.
> 
> Joerg is claiming that the quoted sentence also implies that
> _different_ st_ino/st_dev pairs will _always_ identify different
> files.  Taken in just the immediate context of stat.h, this is a
> very reasonable interpretation.

It seems to me that "st_ino/st_dev tuple always maps to the same file" 
is equivalent to "different st_ino/st_dev pairs will always identify 
different files".  What is the distinction between the two statements?

As I see it, the main question is whether it is a unique mapping *at one 
specific point in time*, or is it a unique mapping *for the duration of 
the system*?  Note that in this case "system" includes "parts of the 
tree that may be remotely mounted from other machines on the network".

I would suggest that the spec doesn't specify the duration of the unique 
mapping, and thus as long as there is a unique mapping *at any 
particular point in time*, then there is no conflict.

If we read it as requiring a unique mapping for the duration of the 
system, consider a hypothetical "system" that includes all the devices 
of all the computers on the planet, and they are all dynamically 
appearing and disappearing continuously.  Consider the technical 
challenge in ensuring that each file on this hypothetical system is 
permanently and uniquely identified by a device/inode pair.

Chris
