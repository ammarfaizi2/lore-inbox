Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282778AbRLKTYB>; Tue, 11 Dec 2001 14:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282781AbRLKTXz>; Tue, 11 Dec 2001 14:23:55 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:5302 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S282728AbRLKTXk>; Tue, 11 Dec 2001 14:23:40 -0500
Message-Id: <5.1.0.14.2.20011211184721.04adc9d0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 11 Dec 2001 19:23:46 +0000
To: Hans Reiser <reiser@namesys.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: reiser4 (was Re: [PATCH] Revised extended attributes
  interface)
Cc: Nathan Scott <nathans@sgi.com>, Andreas Gruenbacher <ag@bestbits.at>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@oss.sgi.com
In-Reply-To: <3C15F5DA.3020206@namesys.com>
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com>
 <20011207202036.J2274@redhat.com>
 <20011208155841.A56289@wobbly.melbourne.sgi.com>
 <3C127551.90305@namesys.com>
 <20011211134213.G70201@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

At 12:02 11/12/01, Hans Reiser wrote:
>  I respond below.
>
>I didn't see that email, probably because I was not on the cc list.
>
>Nathan Scott wrote:
>>hi Hans,
>>On Sat, Dec 08, 2001 at 11:17:21PM +0300, Hans Reiser wrote:
>>>Nathan Scott wrote:
>>>>In a way there's consensus wrt how to do POSIX ACLs on Linux
>>>>now, as both the ext2/ext3 and XFS ACL projects will be using
>>>>the same tools, libraries, etc.  In terms of other ACL types,
>>>>I don't know of anyone actively working on any.
>>>We are taking a very different approach to EAs (and thus to ACLs) as 
>>>described in brief at www.namesys.com/v4/v4.html.  We don't expect 
>>>anyone to take us seriously on it before it works, but silence while 
>>>coding does not equal consensus.;-)
>>>
>>>In essence, we think that if a file can't do what an EA can do, then you 
>>>need to make files able to do more.
>>We did read through your page awhile ago.  It wasn't clear to me
>>how you were addressing Anton's questions here:
>>http://marc.theaimsgroup.com/?l=linux-fsdevel&m=97260371413867&w=2
>>(I couldn't find a reply in the archive, but may have missed it).
>>
>>We were concentrating on something that could be fs-independent,
>>so the lack of answers there put us off a bit, and the dependence
>>on a reiser4() syscall is pretty filesystem-specific too (I guess
>>if your solution is intended to be a reiserfs-specific one, then
>>the questions above are meaningless).
>Changing the name of the system call is not a biggie.  Our approach is to make
>it work for reiserfs, then proselytize.  While we work, we let people know
>what we are working on, and if they join in, great to have it work for more
>than one FS.
>
>>I was curious on another thing also - in the section titled ``The Usual 
>>Resolution Of These Flaws Is A One-Off Solution'',
>>talking about security attributes interfaces, your page says:
>>
>>         "Linus said that we can have a system call to use as 
>> our*experimental plaything in this. With what I have in mind for the
>>API, one rather flexible system call is all we want..."
>>
>>How did you manage to get him to say that?  We were flamed for
>>suggesting a syscall which multiplexed all extended attributes
>>commands though the one interface (because its semantics were
>>not clearly defined & it could be extended with new commands,
>>like ioctl/quotactl/...), and we've also had no luck so far in
>>getting either our original interface, nor any revised syscall
>>interfaces (which aren't like that anymore) accepted by Linus.*
>
>We expect to get flamed once we have a patch.;-)  When we
>have something mature enough to be usable, I expect he'll find a lot that
>could be made better.  He does that.;-)
>
>For us, there are semantic advantages to having a single system call. Probably
>it will get a lot of argument once we have working code, and frankly I prefer
>to have that argument only after it is something usable, and it is easy to see
>the convenience of expression that comes from it.  We want to Linux to be
>MORE expressive than BeOS in regards to files.
>
>>*
>>many thanks.
>>*
>>**
>   **
>*
>Curtis Anderson wrote:
>
>> > The problem with streams-style attributes comes from stepping onto the
>> > slippery slope of trying to put too much generality into it.  I chose the
>> > block-access style of API so that there would be no temptation to start
>> > down that slope.
>>
>>I understand you right up until this.  I just don't get it.  If you 
>>extend the functionality of files and directories so that attributes are 
>>not needed, this is goodness, right?  I sure think it is the right 
>>approach.  We should just decompose carefully what functionality is 
>>provided by attributes that files and directories lack, and one feature 
>>at a time add that capability to files and directories as separate 
>>optional features.

I wrote:

>No, it is _not_ goodness, IMHO. - If you did implement the API for 
>attributes through files and directories, then what would you do with 
>named streams?!?
>*
>   **
>**
>
>*Hans Reiser wrote:
>
>What is your intended functional difference between extended attributes 
>and streams?
>
>None?

Differences in NTFS:

- maximum size (EA limited to 64kiB, named stream 2^63 bytes)
- locality of storage (all EAs are stored in one so they are quicker to 
access when you need to access multiple EAs)
- name namespace (Unicode names for named streams vs ASCII for EAs)
- potential ability to compress/encrypt (EAs cannot do this, named streams 
could possibly and they certainly can be sparse, too which EAs cannot be)
- named streams have creation/modification/access/etc times associated with 
them, EAs don't

How is that for a start?

>Ok, let's assume none until I get your response.  (I can respond more 
>specifically
>after you correct me.)  Let me further go out on a limb,and guess that you 
>intend
>that extended attributes are meta-information about the object, and streams
>are contained within the object.

Streams are only within the inode if they are tiny, otherwise they are 
stored indirect just like normal file data. What they contain is complete 
specific to the creator. Same is valid for EAs, with the exception that all 
EAs are stored as one "stream" (for lack of a better word).

>In this case, a naming convention is quite sufficient to distinguish them.

Still think so? I don't.

>Extended attributes can have names of the form filenameA/..extone.
>
>Streams can have names of the form filenameA/streamone.
>
>In other words, all meta-information about an object should by convention
>(and only by convention, because people should live free, and because
>there is not always an obvious distinction between meta and contained
>information) be preceded by '..'
>
>Note that readdir should return neither stream names nor extended 
>attribute names,
>and the use of 'hidden' directory entries accomplishes this (ala .snapshot
>for WAFL).
>*
>**
>   **

All the below quotes refering to *Curtis are actually from me, IIRC...

>*Curtis:
>You can't possibly have both using the same API since you would then get 
>name collision on filesystems where both named streams and EAs are supported.
>*
>   **
>**
>
>*Name distinctions are what you use to avoid name collisions, see above.
>*

Ok, that would work, BUT:

(Again this is me not Curtis...)

>*Curtis:
>(And I haven't even mentioned EAs and named streams attached to actual 
>_real_ directories yet.)
>
>*
>   **
>*I don't understand this.

Ok, I will try to explain. An inode is the real thing, not a file. An inode 
can by definition be a file or a directory (or a symlink, or special device 
file, etc).

Any of these (i.e. any inode) can have both named streams AND EAs attached 
to them on NTFS. So say I have a directory named MyDir and it contains a 
named stream called MyStream1 and an EA called MyEA1 and two files, one 
called MyStream1 and one called "..MyEA1".

Now with your scheme of naming things, looking up MyDir/MyStream1 matches 
both the file MyStream1 that is in the directory MyDir and the named stream 
MyStream1 belonging to the directory MyDir. - How do you/does one 
distinguish the two in your scheme?!? I can only see it makind a big BANG 
here...

Similarly, looking up MyDir/..MyEA1 matches both the file named "..MyEA1" 
and the EA MyEA1. BANG!

And add a named stream actually named "..MyEA1" to MyDir and you have total 
salad!

See the problem now?

I certainly fail to see how your naming scheme is going to cope with 
this... Perhaps I am missing something?

Now if you have distinct APIs for EAs you have no problems on that side and 
if you don't use the slash but say the colon (like Windows does) for named 
streams you get rid of the named streams in directories problem, too. But 
then you need to forbid the ":" as an accepted character in the file name 
just like Windows does which is probably a reason not to use that API either...

>*
>**
>   **
>
>*Curtis:
>Let's face it: EAs exist. They are _not_ files/directories so the API
>*
>   **
>*Is this an argument?
>
>EA's do not exist in Linux, and they should never exist as something that 
>is more than a file. Since they do not exist, you might as well improve 
>the filesystems you port to Linux while porting them.  APIs shape an OS 
>over the long term, and if done wrong they burden generations after you 
>with crud.

Like Microsoft is going to let me change the NTFS specifications to modify 
how EAs and named streams are stored. Dream on!

But perhaps we are talking past each other: I am talking on-disk format / 
specifications. These exist and no, we cannot change those at all. You can 
do that with reiserfs as it is yours but all of us supporting existing file 
systems owned by corporations like Microsoft, SGI, etc, have to live with 
the specifications.

>*
>**
>   **
>*Curtis:
>should not make them appear as files/directories. - You have to consider 
>that there are a lot of filesystems out there which are already developed 
>and which need to be supported. - Not everyone has their own filesystem 
>which they can change/extend the specifications/implementation of at will.
>*
>   **
>*
>Yes they do.  It is all GPL'd.  Even XFS.  Do the underlying infrastructure
>the right way, and I bet you'll be surprised at how little need there really
>is for ea's done the wrong way. A user space library can cover
>over it all (causing only the obsolete programs using it to suffer while they
>wait to fade away).

?!? GPL has nothing to do with on-disk format and I doubt Microsoft would 
agree that the ntfs on-disk layout is GPL. It's a trade secret! Why do you 
think ntfs developers have to spend half their life using disassemblers and 
hexeditors?!?

>*
>What would have happened if set theory had not just sets and elements, but 
>sets, elements, extended-attributes, and streams, and you could not use 
>the same operators on streams that you use on elements?  It would have 
>been crap as a theoretical model.  It does real damage when you add things 
>that require different operators to the set of primitives. Closure is 
>extremely important to design.  Don't do this.

Since we are going into analogies: You don't use a hammer to affix a screw 
and neither do you use a screwdriver to affix a nail...at least I don't. I 
think you are trying to use a large sledge hammer to put together things 
which do not fit together thus breaking them in the process. To use your 
own words: Don't do this. (-; Each is distinct and should be treated as 
such. </me ducks>

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

