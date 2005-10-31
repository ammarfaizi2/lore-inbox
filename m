Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbVJaILF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVJaILF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 03:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVJaILE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 03:11:04 -0500
Received: from warden2-p.diginsite.com ([209.195.52.120]:50330 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S1750710AbVJaILC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 03:11:02 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Junio C Hamano <junkio@cox.net>
Cc: linux-kernel@vger.kernel.org, Rob Landley <rob@landley.net>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <7v7jbujfh6.fsf@assigned-by-dhcp.cox.net>
References: <20051029182228.GA14495@havoc.gtf.org><200510301731.47825.rob@landley.net><Pine.LNX.4.64.0510301654310.27915@g5.osdl.org><200510302035.26523.rob@landley.net> <7v7jbujfh6.fsf@assigned-by-dhcp.cox.net>
Date: Mon, 31 Oct 2005 00:10:47 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [git patches] 2.6.x libata updates
In-Reply-To: <7v7jbujfh6.fsf@assigned-by-dhcp.cox.net>
Message-ID: <Pine.LNX.4.62.0510302353370.16065@qynat.qvtvafvgr.pbz>
References: <20051029182228.GA14495@havoc.gtf.org><200510301731.47825.rob@landley.net><Pine.LNX.4.64.0510301654310.27915@g5.osdl.org><200510302035.26523.rob@landley.net>
 <7v7jbujfh6.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Oct 2005, Junio C Hamano wrote:

> Rob Landley <rob@landley.net> writes:
>
>> grep -n MARKER bisect.patch | less
>> (pick a line number)
>> head -n linenumber bisect.patch > test.patch
>>
>> If that's not it, revert test.patch and then try again.  Tell us the first
>> line number that failed, which is the end of the patch we want...
>>
>> Hmmm...  The logical place to put the URL to gitweb is at the _end_ of the
>> patch, attached to the marker.  So that's what they see in the grep, and the
>> last thing they test when they cut at that line with head -n...
>
> Well, do people realize that 'git bisect' is *not* a textual
> half-way between, but rather is computed every time you feed
> new "the patch you told me to test last time was good/bad"
> information?  I do not think statically generating a huge text
> and telling the user to apply up to halfway and bisect by hand
> would not work -- it would be quite different from what git
> bisect would give you.
>
> I think public webserver based bisect service David Lang
> suggests might work.  The interaction with it would start by the
> end user somehow giving it the last known-working commit ID (A)
> (pick from gitweb shortlog, perhaps) and a commit ID newer than
> that that broke things (B) (again, pick from gitweb shortlog).
> Then the service runs bisect on the server side, spit out a diff
> against (A).  The end user applies the patch, try it, and then
> come back and tell if it worked or not,...  Since we are talking
> about the kernel development, I think the cycle might involve
> rebooting the machine; so you would probably need two machines
> (one guinea-pig machine to reboot, another to keep the browser
> open so that your state can be kept somehow).

given the time required to compile a kernel and reboot you can't plan to 
keep the info server side (browser connections will time out well before 
this finishes)

instead this will require saving something on the client and passing it 
back to the server.

offhand I'd say that it would end up working something like this.

1. go to the website and pick starting good/bad points
2. the server will give you a tgz (bzip is significantly more load on the 
server) that contains the patch and a status file.
3. apply the patch to the starting tree (in theory it may be a smaller 
patch to either tree, but it's easier to explain if one is picked all the 
time so initially it should be the working tree). compile the tree and 
test
4. go back to the website, upload the status file and indicate sucess or 
failure
5. goto 2

the file would basicly save and report what git bisect would normally 
store in environment variables.

the server will have to do some sanity checking on the good and bad points 
it's given (for security reasons if nothing else)

potentially it should suggest checking an officially tagged release 
that's between the good and bad points. this may actually slow testing 
slightly (if you know it worked on 2.6.7 and failed on 2.6.12 you would 
probably be the most efficiant if you start bisecting directly, but it's 
far easier for others to understand things if you test 2.6.10 and other 
tagged releases first)

I also suspect that a log of what people are testing would be intereating 
to people as well (if you see a bunch of people bisecting in the same area 
it's an indication that more attention needs to be paied to that area)

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
