Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264420AbUAFOz1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 09:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264469AbUAFOz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 09:55:27 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:29600 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264420AbUAFOz0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 09:55:26 -0500
Message-ID: <3FFACC5C.7050900@namesys.com>
Date: Tue, 06 Jan 2004 17:55:24 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: venom@sns.it
CC: "Randy.Dunlap" <rddunlap@osdl.org>, sglines@is-cs.com,
       linux-kernel@vger.kernel.org
Subject: Re: file system technical comparisons
References: <Pine.LNX.4.43.0401061300550.13594-100000@cibs9.sns.it>
In-Reply-To: <Pine.LNX.4.43.0401061300550.13594-100000@cibs9.sns.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

venom@sns.it wrote:

>What would be interesting is a new comparison between reiserFS reiser4 and
>latest XFS. To be onest I think ext3, with or withou HTree, obsolete, but it is
>abvious if you consider its origins, while I do not speack about JFS, since
>technically is interesting, but then the bench I did, more than an year ago,
>were not untisiasmant, and it was buggy when in a DIR there were too many
>"small" files.
>
>Luigi
>
>  
>
Actually I agree with you that JFS is architecturally much more 
interesting than ext3 (though Andrew Morton's readahead code for ext* is 
beautiful stuff).  I haven't really looked at why JFS is slow, though 
usually being slow at <100k sized files in a journaling filesystem is 
due to the journaling code.  The thing about performance is that the 
mistakes count for 4x what the things done right count for.  Chris Mason 
did a lot for V3's performance compared to the competition by writing 
nice journaling code for us.

htree has performance problems that are due to its architecture --- I 
think this is why they don't make it on by default --- it actually slows 
ext3 down substantially for average directory sizes.....  you can see 
that on our benchmarks page, or just by copying around some copies of 
the linux kernel yourself with it on and off.

-- 
Hans


