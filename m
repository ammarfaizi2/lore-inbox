Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284998AbRLKMEB>; Tue, 11 Dec 2001 07:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285000AbRLKMDw>; Tue, 11 Dec 2001 07:03:52 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:11535 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S284998AbRLKMDq>; Tue, 11 Dec 2001 07:03:46 -0500
Message-ID: <3C15F5DA.3020206@namesys.com>
Date: Tue, 11 Dec 2001 15:02:34 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: reiser4 (was Re: [PATCH] Revised extended attributes interface)
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com> <20011207202036.J2274@redhat.com> <20011208155841.A56289@wobbly.melbourne.sgi.com> <3C127551.90305@namesys.com> <20011211134213.G70201@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I respond below.

I didn't see that email, probably because I was not on the cc list.

Nathan Scott wrote:

>hi Hans,
>
>On Sat, Dec 08, 2001 at 11:17:21PM +0300, Hans Reiser wrote:
>
>>Nathan Scott wrote:
>>
>>>In a way there's consensus wrt how to do POSIX ACLs on Linux
>>>now, as both the ext2/ext3 and XFS ACL projects will be using
>>>the same tools, libraries, etc.  In terms of other ACL types,
>>>I don't know of anyone actively working on any.
>>>
>>We are taking a very different approach to EAs (and thus to ACLs) as 
>>described in brief at www.namesys.com/v4/v4.html.  We don't expect 
>>anyone to take us seriously on it before it works, but silence while 
>>coding does not equal consensus.;-)
>>
>>In essence, we think that if a file can't do what an EA can do, then you 
>>need to make files able to do more.
>>
>
>We did read through your page awhile ago.  It wasn't clear to me
>how you were addressing Anton's questions here:
>http://marc.theaimsgroup.com/?l=linux-fsdevel&m=97260371413867&w=2
>(I couldn't find a reply in the archive, but may have missed it).  
>
>We were concentrating on something that could be fs-independent,
>so the lack of answers there put us off a bit, and the dependence
>on a reiser4() syscall is pretty filesystem-specific too (I guess
>if your solution is intended to be a reiserfs-specific one, then
>the questions above are meaningless).
>
Changing the name of the system call is not a biggie.  Our approach is 
to make
it work for reiserfs, then proselytize.  While we work, we let people know
what we are working on, and if they join in, great to have it work for more
than one FS.

>
>
>I was curious on another thing also - in the section titled 
>``The Usual Resolution Of These Flaws Is A One-Off Solution'',
>talking about security attributes interfaces, your page says:
>
>	"Linus said that we can have a system call to use as our*experimental plaything in this. With what I have in mind for the
>API, one rather flexible system call is all we want..."
>
>How did you manage to get him to say that?  We were flamed for
>suggesting a syscall which multiplexed all extended attributes
>commands though the one interface (because its semantics were
>not clearly defined & it could be extended with new commands,
>like ioctl/quotactl/...), and we've also had no luck so far in
>getting either our original interface, nor any revised syscall
>interfaces (which aren't like that anymore) accepted by Linus.*
>

We expect to get flamed once we have a patch.;-)  When we
have something mature enough to be usable, I expect he'll find a lot that
could be made better.  He does that.;-)

For us, there are semantic advantages to having a single system call. 
 Probably
it will get a lot of argument once we have working code, and frankly I 
prefer
to have that argument only after it is something usable, and it is easy 
to see
the convenience of expression that comes from it.  We want to Linux to be
MORE expressive than BeOS in regards to files.

>*
>
>many thanks.
>
>*
>
> **

**

    **

*
Curtis Anderson wrote:

> > The problem with streams-style attributes comes from stepping onto the
> > slippery slope of trying to put too much generality into it.  I chose the
> > block-access style of API so that there would be no temptation to start
> > down that slope.
>
>I understand you right up until this.  I just don't get it.  If you extend 
>the functionality of files and directories so that attributes are not 
>needed, this is goodness, right?  I sure think it is the right 
>approach.  We should just decompose carefully what functionality is 
>provided by attributes that files and directories lack, and one feature at 
>a time add that capability to files and directories as separate optional 
>features.

No, it is _not_ goodness, IMHO. - If you did implement the API for 
attributes through files and directori
es, then what would you do with named 
streams?!?
*

    **

**

*Hans Reiser wrote:

What is your intended functional difference between extended attributes and streams?

None?

Ok, let's assume none until I get your response.  (I can respond more specifically
after you correct me.)  Let me further go out on a limb,and guess that you intend
that extended attributes are meta-information about the object, and streams
are contained within the object.

In this case, a naming convention is quite sufficient to distinguish them.

Extended attributes can have names of the form filenameA/..extone.

Streams can have names of the form filenameA/streamone.

In other words, all meta-information about an object should by convention
(and only by convention, because people should live free, and because
there is not always an obvious distinction between meta and contained
information) be preceded by '..'

Note that readdir should return neither stream names nor extended attribute names,
and the use of 'hidden' directory entries accomplishes this (ala .snapshot
for WAFL).
*

**

    **

*Curtis:
You can't possibly have both using the same API since you would then get 
name collision on filesystems where both named streams and EAs are 
supported. 

*

    **

**

*Name distinctions are what you use to avoid name collisions, see above.
*

**

    **

*Curtis:
(And I haven't even mentioned EAs and named streams attached to 
actual _real_ directories yet.)

*

    **

*I don't understand this.
*

**

    **

*Curtis:
Let's face it: EAs exist. They are _not_ files/directories so the API 

*

    **

*Is this an argument?

EA's do not exist in Linux, and they should never exist as something that
is more than a file. Since they do not
exist, you might as well improve the filesystems you port to Linux while
porting them.  APIs shape an OS over the long term, and if done wrong
they burden generations after you with crud.
*

**

    **

*Curtis:
should not make them appear as files/directories. - You have to consider 
that there are a lot of filesystems out there which are already developed 
and which need to be supported. - Not everyone has their own filesystem 
which they can change/extend the specifications/implementation of at will.
*

    **

*
Yes they do.  It is all GPL'd.  Even XFS.  Do the underlying infrastructure
the right way, and I bet you'll be surprised at how little need there really
is for ea's done the wrong way. A user space library can cover
over it all (causing only the obsolete programs using it to suffer while they
wait to fade away).
*



What would have happened if set theory had not just sets and elements, 
but sets, elements, extended-attributes, and streams, and you could not 
use the same operators on streams that you use on elements?  It would 
have been crap as a theoretical model.  It does real damage when you add 
things that require different operators to the set of primitives. 
 Closure is extremely important to design.  Don't do this.

Hans

    **

    **

*
*

