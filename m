Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266558AbUBGD2b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 22:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266567AbUBGD2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 22:28:31 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:12729
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S266558AbUBGD1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 22:27:52 -0500
Message-ID: <40245BBF.501@tmr.com>
Date: Fri, 06 Feb 2004 22:30:07 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: the grugq <grugq@hcunix.net>, "Theodore Ts'o" <tytso@mit.edu>,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
References: "Your message of Wed, 04 Feb 2004 12:05:07 EST." <40212643.4000104@tmr.com> <200402041714.i14HEIVD005246@turing-police.cc.vt.edu>            <402184AA.2010302@tmr.com> <200402050438.i154cAf6013993@turing-police.cc.vt.edu>
In-Reply-To: <200402050438.i154cAf6013993@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Wed, 04 Feb 2004 18:47:54 EST, Bill Davidsen said:
> 
>>>This of course implies that 'chattr +s' (or whatever it was) has to fail
>>>if the link count isn't exactly one.
>>
>>Do you disagree that the count does need to be one?
> 
> 
> I'm not prepared to say that there's no scenario where we *dont* care
> how many links there are, as long as the file *does* get wiped when the
> last one goes away.
> 
> The MH mail handler stores each message in a file - so a mail message is easily
> stored in multiple folders by simply using multiple hard links.  I could
> easily see having mail that I want to +s and go away when I remove it from
> the last folder it was in....

This is then a question of what we want it to do, and I assume that 
either of the obvious behaviours is not only possibe but practical. The 
question is if the objective is to make the data go away when the last 
link is removed, or to make removal of sach a file (unlink) remove the 
contents at the time of the unlink. I think the latter clearly implies 
allowing a single link to the inode.

Since I could make a case for either, I'd like to hear other feedback.
> 
> 
>>I agree with everything you said, "useful" doesn't always map to "easy." 
>>But if you agree that the count needs to be one on files, then you could 
>>also fail if you tried to add it to a directory which was not empty.
> 
> 
> Yes you could.  The question is whether that's a desired semantic or not.

Given my use of the 'setgid' bit as a possible model, I would say that 
having new files created with the attribute is useful, and the user 
putting the attribute on the directory should control the content at the 
time the attribute is set. In other words it will be as useful if we 
just make it apply on files as they are created.
> 
> 
>>In case I didn't make it clear, the use I was considering was to create 
>>a single directory in which created files would really go away when 
>>deleted. I hadn't considered doing it after files were present, what you 
>>say about overhead is clearly an issue. I think I could even envision 
>>some bizarre race conditions if the kernel had to do marking of each 
>>file, so perhaps it's impractical.
> 
> 
> As I said, ugly and murky....

And not needed.
> 
> 
>>But what happens when the 'setgid' bit is put on a directory? At least 
>>in 2.4 existing files do NOT get the group set, only files newly 
>>created. So unless someone feels that's a bug which needs immediate 
>>fixing, I can point to it as a model by which the feature could be 
>>practically implemented.
> 
> 
> Ahh.. but now you're suggesting a different model than "directory must
> be empty".  Obviously more discussion of what we *want* it to do is needed ;)

Yes, the person setting the attribute can control this. Unlike the 
setgid bit it can't be done (currently) as a part of creat().


-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
