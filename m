Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWCIH0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWCIH0T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 02:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbWCIH0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 02:26:19 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:57496 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750806AbWCIH0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 02:26:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=olAXdQLQ9AbBMcTHBBOaM8Ymk2dyCx5PDo8VYaEA9n91sQqbGccDUfa6q+Ce6BpcsYyvUBCnacFpBWdJgTksL0J8PGLQJApYRqoYWHuCex8fNuHucUtl88Ok5DUU6oRFOlDspq6pIQH6582j7Iw/cyWPPfuQ0D0GtkudHyN54B0=  ;
Message-ID: <440FD88F.4010603@yahoo.com.au>
Date: Thu, 09 Mar 2006 18:26:07 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@google.com>
CC: Mark Fasheh <mark.fasheh@oracle.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com
Subject: Re: [Ocfs2-devel] Ocfs2 performance bugs of doom
References: <4408C2E8.4010600@google.com>	<20060303233617.51718c8e.akpm@osdl.org>	<440B9035.1070404@google.com>	<20060306025800.GA27280@ca-server1.us.oracle.com>	<440BC1C6.1000606@google.com>	<20060306195135.GB27280@ca-server1.us.oracle.com>	<p733bhvgc7f.fsf@verdi.suse.de> <20060307045835.GF27280@ca-server1.us.oracle.com> <440FCA81.7090608@google.com>
In-Reply-To: <440FCA81.7090608@google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

> After untarring four kernel trees, number of locks hits a peak of 128K.
> With 64K buckets the hash, a typical region of the table looks like:
> 
>  3 0 3 6 1 2 2 1 2 6 1 0 1 2 1 0 0 3 1 2 2 3 1 2 5 3 2 2 1 0 3 1
>  1 1 3 5 2 2 1 0 2 3 3 1 3 0 5 2 2 3 0 2 1 3 1 2 4 2 0 2 5 1 4 3
>  5 3 3 3 3 1 4 1 2 1 2 6 2 1 3 0 2 2 2 8 1 2 2 2 3 1 0 1 3 2 1 1
>  1 2 2 2 2 3 2 0 2 2 2 5 2 3 2 1 1 2 6 6 1 2 2 4 2 0 3 0 3 3 3 0
>  2 2 1 1 2 3 2 0 2 3 3 1 3 3 3 1 4 2 8 3 2 2 2 4 3 0 1 2 3 4 2 0
>  3 1 0 1 2 2 3 1 4 2 1 1 3 3 4 3 3 3 4 2 1 4 2 1 5 2 1 3 1 2 3 2
>  1 0 1 5 3 2 1 2 3 0 1 1 2 3 4 4 4 1 3 1 4 3 2 2 4 4 1 3 1 0 0 1
>  3 1 1 3 0 3 0 1 1 1 1 1 3 4 4 2 4 3 4 2 3 3 0 3 4 2 1 5 4 1 3 1
>  1 0 1 0 1 4 1 2 1 4 2 0 2 2 5 2 1 1 1 2 3 6 4 5 5 1 1 2 3 1 5 1
>  3 0 1 0 3 3 2 0 2 1 2 1 0 4 3 2 1 0 1 0 2 7 1 3 2 1 1 2 4 1 3 1
>  2 2 3 1 3 3 1 2 0 2 1 3 1 2 0 4 4 1 2 1 2 3 3 6 0 5 2 1 1 0 3 0
>  1 0 2 0 4 3 2 1 0 0 2 0 1 4 2 4 5 1 0 1 3 2 2 1 1 3 2 3 0 2 1 1
>  3 0 0 0 2 5 3 1 0 2 0 1 0 0 2 0 4 2 1 2 4 3 0 1 2 4 1 3 0 0 1 4
> 
> A poor distribution as you already noticed[1].
[...]
 > [1] And this is our all-important dentry hash function.  Oops.

Why do you say that? I don't think it is particularly bad. Your sample
has an average of 2.06, and a standard deviation of 1.49 while a random
assignment using glibc's random() here has a standard deviation of 1.44

I can't remember much stats, but I think that means in your sample of
over 400, you're likely to find several instances of "6" and not
unlikely to find some higher. Actually given that it is bound at zero
and so not a normal distribution, that is likely to move results a bit
further to the right [I'm sure there's a formula for that], which is
pretty consistent with what you have, and you would hardly notice a
difference using rand()

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
