Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319642AbSIMN25>; Fri, 13 Sep 2002 09:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319645AbSIMN24>; Fri, 13 Sep 2002 09:28:56 -0400
Received: from ppp-216-58-171-126.den1.inet.ricochet.net ([216.58.171.126]:1254
	"HELO mail.isnelson.com") by vger.kernel.org with SMTP
	id <S319642AbSIMN2y>; Fri, 13 Sep 2002 09:28:54 -0400
Message-ID: <3D81E936.1050006@earthlink.net>
Date: Fri, 13 Sep 2002 07:33:42 -0600
From: "Ian S. Nelson" <nelsonis@earthlink.net>
Reply-To: nelsonis@earthlink.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ivan Ivanov <ivandi@vamo.orbitel.bg>, linux-kernel@vger.kernel.org
Subject: Re: XFS?
References: <Pine.LNX.4.44.0209131011340.4066-100000@magic.vamo.orbitel.bg>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Ivanov wrote:

>I think that you missed the main problem with all this new "great"
>filesystems. And the main problem is potential data loss in case of a
>crash. Only ext3 supports ordered or journal data mode.
>
>XFS and JFS are designed for large multiprocessor machines powered by UPS
>etc., where the risk of power fail, or some kind of tecnical problem is
>veri low.
>
>On the other side Linux works in much "risky" environment - old
>machines, assembled from "yellow" parts, unstable power suply and so on.
>
>With XFS every time when power fails while writing to file the entire file
>is lost. The joke is that it is normal according FAQ :)
>  
>

This isn't true.  I picked XFS as the filesystem for Echostar's DP-721 
partially because when I power cycle tested them all it seemed to behave 
in the most predictable way. The meta data always seemed to be correct 
and the unflushed blocks were screwed up and *usually pointed to null 
blocks, which is what I expect.  If we're talking about a tiny little 
file then you might lose the whole thing, it's all an unflushed block. 
 Since then I've seen the product in the field have the plug pulled 
multiple times during a PVR recording and you lose the  time during the 
boot but just about everything else is there.    

* I think after hundreds of reboots you could screw that up, we fixed it 
by doing a repair during the boot periodically which was still very very 
fast compared to a fsck.  Also, not terribly important since a few 
blocks is only a couple seconds of recording.

I'm not entirely sure what the correct semantics are for losing power 
during a write, with some of the Reiserfs cuts I was looking at (circa 
kernel 2.3.99) when you pulled the plug the last blocks committed would 
be garbage.  I remember a thread that said something to the extent the 
the DMAs keep going for a few milliseconds after power is cut but the 
data they transfer is trash; I don't know if I believe that or not.  It 
was very consistent though,  it could be that the metadata just pointed 
to blocks on the disk that didn't have zeros in them or something. 
 Still, it didn't trash the whole file, it did it mostly correct 
assuming that you detect that there was a crash and intervene; your logs 
or whatever could have some garbage but everything keeps running for the 
most part.

I really don't know how you call a filesystem good or not.  I think XFS 
isn't in yet simply because it's big and Linus may not have had the time 
yet to read it all.  XFS, JFS, Reiserfs, and even EXT3 are way too big 
to just test in a lab (Alan's house?) and call "bug free, ready for 
production"  You put them in, call them experimental, more of us hammer 
on them, and they grow into trusted.  From my personal experience, all 
of them have been pretty good and I haven't seen major problems with any 
of them in a long time and I did try to do some rigorous scientific 
testing of them all, I'm not just spouting hearsay.

Ian Nelson



