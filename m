Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263397AbTJQLpS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 07:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263403AbTJQLpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 07:45:18 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:65497 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263397AbTJQLpM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 07:45:12 -0400
Message-ID: <3F8FD646.9070902@namesys.com>
Date: Fri, 17 Oct 2003 15:45:10 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Norman Diamond <ndiamond@wta.att.ne.jp>
CC: Wes Janzen <superchkn@sbcglobal.net>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com, Pavel Machek <pavel@ucw.cz>,
       Vitaly Fertman <vitaly@namesys.com>
Subject: Re: Blockbusting news, this is important (Re: Why are bad disk sectors
 numbered strangely, and what happens to them?)
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60> <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk> <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60> <20031014064925.GA12342@bitwizard.nl> <3F8BA037.9000705@sbcglobal.net> <3F8BBC08.6030901@namesys.com> <11bf01c39492$bc5307c0$3eee4ca5@DIAMONDLX60> <3F8FBADE.7020107@namesys.com> <126d01c3949f$91bdecc0$3eee4ca5@DIAMONDLX60>
In-Reply-To: <126d01c3949f$91bdecc0$3eee4ca5@DIAMONDLX60>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norman Diamond wrote:

>Replying first to Hans Reiser; below to Russell King and Pavel Machek.
>
>  
>
>>Instead of recording the bad blocks, just write to them.
>>    
>>
>
>If writes are guaranteed to force reallocations then this is potentially
>part of a solution.
>
>I still remain suspicious because the first failed read was milliseconds or
>minutes after the preceding write.  I think the odds are very high that the
>sector was already bad at the time of the write but reallocation did not
>occur.  It is possible but I think very unlikely that the sector was
>reallocated to a different physical sector which went bad milliseconds after
>being written after reallocation, and equally unlikely that the sector
>wasn't reallocated because it really hadn't been bad but went bad
>milliseconds later.  In other words, I think it is overwhelmingly likely
>that the write failed but was not detected as such and did not result in
>reallocation.
>  
>
perform the write after the failed read, that way the drive knows it is 
a bad block at the time you write.

>Now, maybe there is a technique to force it anyway.  When a partition is
>newly created and is being formatted with the intention of writing data a
>few minutes later, do writes that "should" have a better chance of being
>detected.  The way to start this is to simply write every block, but this is
>obviously insufficient because my block did get written shortly after the
>partition was formatted and that write didn't cause the block to be
>reallocated.  So in addition to simply writing every block, also read every
>block.  For each read that fails, proceed to do another write which "should"
>force reallocation.
>
>Mr. Reiser, when I created a partition of your design, that technique was
>not offered.  Why?  And will it soon start being offered?
>  
>
I think I discussed with Vitaly offering users the option of writing, 
reading, and then writing again, every block before mkreiserfs.  I 
forget what happened to that idea, Vitaly?

>Also, I remain highly suspicious that for each read that fails, when the
>formatting program proceeds to do another write which "should" force
>reallocation, the drive might not do it.
>
I am not going to worry about such suspicions without evidence or drive 
manufacturer comment, as it has not been our experience so far.

>
>
>Why does it matter?  The drive already reported a read failure.  Maybe Linux
>programs aren't all smart enough to inform the user when a read operation
>results in an I/O error, but drivers could be smarter.
>
There is a general problem with reporting urgent kernel messages to 
users thanks to GUIs covering over the console.



-- 
Hans


